import 'dart:math';

import 'package:app_design_system/src/l10n/l10n.dart';
import 'package:app_design_system/src/styleguide/colors.dart';
import 'package:app_design_system/src/styleguide/spacing.dart';
import 'package:app_design_system/src/widgets/context_menu/context_menu_container.dart';
import 'package:app_design_system/src/widgets/context_menu/context_menu_controller.dart';
import 'package:app_design_system/src/widgets/context_menu/context_menu_controller_provider.dart';
import 'package:boxy/boxy.dart';
import 'package:flutter/widgets.dart';

part 'context_menu_layout.dart';

const _duration = Duration(milliseconds: 250);

class AppContextMenuAnchor {
  const AppContextMenuAnchor({
    this.target = AlignmentDirectional.bottomCenter,
    this.menu = AlignmentDirectional.topCenter,
  });

  final AlignmentDirectional target;
  final AlignmentDirectional menu;

  _ContextMenuAnchor _resolve(TextDirection textDirection) {
    return _ContextMenuAnchor(
      target: target.resolve(textDirection),
      menu: menu.resolve(textDirection),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    if (other.runtimeType != runtimeType) {
      return false;
    }

    return other is AppContextMenuAnchor &&
        other.target == target &&
        other.menu == menu;
  }

  @override
  int get hashCode => Object.hash(target, menu);
}

final class _ContextMenuAnchor {
  const _ContextMenuAnchor({required this.target, required this.menu});

  final Alignment target;
  final Alignment menu;
}

class AppContextMenu extends StatefulWidget {
  const AppContextMenu({
    super.key,
    required this.child,
    this.items = const [],
    required this.controller,
    this.anchor = const AppContextMenuAnchor(),
  });

  final Widget child;
  final List<Widget> items;
  final AppContextMenuController controller;
  final AppContextMenuAnchor anchor;

  @override
  State<AppContextMenu> createState() => _AppContextMenuState();
}

class _AppContextMenuState extends State<AppContextMenu>
    with SingleTickerProviderStateMixin {
  final _key = GlobalKey<_AppContextMenuState>();

  final scaleAnimationAlignment = ValueNotifier(Alignment.center);

  late final AnimationController _animationController;

  var _visible = false;

  NavigatorState? _navigator;
  OverlayEntry? _overlayEntry;
  LocalHistoryEntry? _localHistoryEntry;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onVisibilityChanged);

    _animationController = AnimationController(
      vsync: this,
      duration: _duration,
    );

    _visible = widget.controller.visible;

    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _toggleMenuVisibilityIfNecessary(),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _navigator = Navigator.maybeOf(context);
  }

  @override
  void didUpdateWidget(AppContextMenu oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller.removeListener(_onVisibilityChanged);
      widget.controller.addListener(_onVisibilityChanged);

      if (_visible != widget.controller.visible) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          _visible = widget.controller.visible;
          _toggleMenuVisibilityIfNecessary();
        });
      }
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onVisibilityChanged);
    _removeOverlay();
    _localHistoryEntry?.remove();
    _localHistoryEntry = null;
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    assert(
      Overlay.maybeOf(context) != null,
      'AppContextMenu must be a descendant of Overlay.',
    );
    assert(
      ModalRoute.of(context) != null,
      'AppContextMenu must be a descendant of ModalRoute.',
    );
    assert(
      MediaQuery.maybeOf(context) != null,
      'AppContextMenu must be a descendant of MediaQuery.',
    );

    return KeyedSubtree(key: _key, child: widget.child);
  }

  void _toggleMenuVisibilityIfNecessary() {
    _pushContextMenuRouteIfNecessary();
    _popContextMenuRouteIfNecessary();
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry?.dispose();
    _overlayEntry = null;
  }

  void _popContextMenuRouteIfNecessary() {
    if (!_visible && _overlayEntry != null) {
      _animationController.reverse().then((_) {
        _navigator?.pop();
      });
    }
  }

  void _pushContextMenuRouteIfNecessary() {
    if (_visible && _overlayEntry == null) {
      final targetRect = _getTargetRect();
      if (targetRect == null) {
        return;
      }

      final overlay = Overlay.of(context);
      final modalRoute = ModalRoute.of(context);
      final mediaQueryData = MediaQuery.of(context);
      final l10n = context.l10n;
      final colors = context.colors;
      final anchor = widget.anchor._resolve(Directionality.of(context));

      _animationController.forward(from: 0);
      final animation = CurveTween(
        curve: Curves.easeInOut,
      ).animate(_animationController);

      final menu = Builder(
        builder: (context) => CustomBoxy(
          delegate: _ContextMenuLayoutDelegate(
            anchor: anchor,
            scaleAnimationAlignment: scaleAnimationAlignment,
            safeAreaPadding: MediaQuery.paddingOf(context),
            targetRect: targetRect,
          ),
          children: [
            ListenableBuilder(
              listenable: animation,
              builder: (context, child) => FadeTransition(
                opacity: animation,
                child: ScaleTransition(
                  scale: animation,
                  alignment: scaleAnimationAlignment.value,
                  child: child,
                ),
              ),
              child: MediaQuery(
                data: mediaQueryData,
                child: AppColorTheme(
                  colors: AppColorTheme.maybeOf(context) ?? colors,
                  child: ContextMenuControllerProvider(
                    controller: widget.controller,
                    child: AppContextMenuContainer(items: widget.items),
                  ),
                ),
              ),
            ),
          ],
        ),
      );

      final overlayEntry = OverlayEntry(
        builder: (context) => Semantics(
          label: l10n.contextMenu_barrierDismissal,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => widget.controller.hide(),
            child: menu,
          ),
        ),
      );

      _overlayEntry = overlayEntry;

      final localHistoryEntry = LocalHistoryEntry(
        onRemove: () {
          _removeOverlay();
          widget.controller.hide();
        },
      );

      _localHistoryEntry = localHistoryEntry;

      modalRoute?.addLocalHistoryEntry(localHistoryEntry);

      overlay.insert(overlayEntry);
    }
  }

  void _onVisibilityChanged() {
    if (widget.controller.visible != _visible) {
      _visible = widget.controller.visible;
      _toggleMenuVisibilityIfNecessary();
    }
  }

  Rect? _getTargetRect() {
    final targetContext = _key.currentContext;

    if (targetContext == null || !targetContext.mounted) {
      return null;
    }

    final targetRenderBox =
        _key.currentContext?.findRenderObject() as RenderBox?;

    if (targetRenderBox == null) {
      return null;
    }

    final targetRect =
        targetRenderBox.localToGlobal(
          Offset.zero,
          ancestor: _navigator?.context.findRenderObject(),
        ) &
        targetRenderBox.size;

    return targetRect;
  }
}
