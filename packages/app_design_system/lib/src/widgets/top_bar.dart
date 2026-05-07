import 'dart:math';

import 'package:app_design_system/src/l10n/l10n.dart';
import 'package:app_design_system/src/styleguide/colors.dart';
import 'package:app_design_system/src/styleguide/spacing.dart';
import 'package:app_design_system/src/styleguide/typography.dart';
import 'package:app_design_system/src/utils/pointer_surface.dart';
import 'package:app_design_system/src/widgets/context_menu/context_menu.dart';
import 'package:app_design_system/src/widgets/context_menu/context_menu_controller.dart';
import 'package:app_design_system/src/widgets/context_menu/context_menu_item.dart';
import 'package:app_design_system/src/widgets/icon/icon.dart';
import 'package:app_design_system/src/widgets/text/text.dart';
import 'package:boxy/boxy.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

final class _ActionData {
  const _ActionData({required this.persistent, required this.index});

  final bool persistent;
  final int index;
}

const _titleId = #title;
const _subtitleId = #subtitle;
const _leadingId = #leading;
const _menuActionId = #menuAction;

/// Preferred DS widget for page top bar.
///
/// If passed, `leading` is always visible, hence value of its
/// `persistent` field is always ignored.
///
/// Title takes as much space as leading action and persistent actions will
/// allow it. If intrinsic title width would cause overflow, then some of
/// non-persistent actions are moved to menu actions of context menu. If
/// intrinsic title width would still cause overflow with non-persistent
/// actions hidden, then title width is reduced according to: leading action,
/// centerTitle, persistent actions and context menu button.
///
/// Parameter `title` is optional and if it isn't passed to the widget then
/// `centerTitle` argument is ignored because the widget lays itself out as
/// if title wasn't centered and had a width of 0.
///
/// If `subtitle` is not null then `title` is required to be not null as well.
/// Subtitle takes as much space as leading action, persistent actions
/// and shown non-persistent actions will allow it. Subtitle intrinsic width
/// does not affect visibility of non-persistent actions.
class AppTopBar extends StatefulWidget {
  const AppTopBar({
    super.key,
    this.leading,
    this.centerTitle = true,
    this.title,
    this.subtitle,
    this.actions = const [],
    this.menuActions = const [],
    this.automaticallyImplyLeading = true,
    this.menuKey,
    this.divider = true,
  }) : assert(
         title != null || subtitle == null,
         'Title cannot be null when subtitle is provided',
       );

  final AppTopBarAction? leading;
  final bool centerTitle;
  final String? title;
  final String? subtitle;
  final List<AppTopBarAction> actions;

  /// Actions that are always shown in the expandable menu.
  final List<AppTopBarAction> menuActions;
  final bool automaticallyImplyLeading;
  final Key? menuKey;

  /// Whether to show a bottom border, the divider.
  final bool divider;

  @override
  State<AppTopBar> createState() => _AppTopBarState();
}

class _AppTopBarState extends State<AppTopBar> {
  final _controller = AppContextMenuController();

  var _collapsedActionsIndexes = <int>{};

  AppTopBarAction? _getLeading(BuildContext context) {
    if (widget.leading != null) {
      return widget.leading;
    }

    final impliesAppBarDismissal =
        ModalRoute.of(context)?.impliesAppBarDismissal ?? false;

    if (widget.automaticallyImplyLeading && impliesAppBarDismissal) {
      return AppTopBarAction.icon(
        icon: AppStandardIcons.chevronLeft,
        semanticsLabel: context.l10n.topBar_menu,
        onTap: Navigator.of(context).pop,
      );
    }

    return null;
  }

  void _onLayoutCollapsedActions(Set<int> collapsedActionsIndexes) {
    if (setEquals(_collapsedActionsIndexes, collapsedActionsIndexes)) {
      return;
    }

    // We have to rebuild widget each time collapsedActionsIndexes changes.
    _collapsedActionsIndexes = collapsedActionsIndexes;
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final titleAlignment = switch (widget.centerTitle) {
      true => AlignmentDirectional.center,
      false => AlignmentDirectional.centerStart,
    };
    final titleTextAlignment = switch (widget.centerTitle) {
      true => TextAlign.center,
      false => TextAlign.start,
    };

    final contextMenuItems = [
      ...[
        ..._collapsedActionsIndexes
            .map((index) => widget.actions.asMap()[index])
            .nonNulls,
        ...widget.menuActions,
      ].map(
        (action) => AppContextMenuItem(
          key: action.key,
          leadingIcon: action.icon,
          title: action.caption ?? action.semanticsLabel ?? '',
          onTap: action.onTap,
        ),
      ),
    ];

    final actionWidgets = widget.actions.mapIndexed(
      (index, action) => BoxyId(
        hasData: true,
        data: _ActionData(persistent: action.persistent, index: index),
        child: TopBarAction(
          key: action.key,
          caption: action.caption,
          icon: action.icon,
          type: action.type,
          semanticsLabel: action.semanticsLabel,
          onTap: action.onTap,
          enabled: action.enabled,
        ),
      ),
    );

    const titleStyle = AppTextStyles.headlineSmall;
    final emptyHeight =
        AppSpacings.s12.vertical.vertical +
        MediaQuery.textScalerOf(
          context,
        ).scale(titleStyle.fontSize * titleStyle.height);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.backgroundDefaultPrimary,
        border: Border(
          bottom: widget.divider
              ? BorderSide(color: colors.foregroundDefaultQuaternary)
              : BorderSide.none,
        ),
      ),
      child: SafeArea(
        left: false,
        right: false,
        bottom: false,
        child: Padding(
          padding: AppSpacings.s8.vertical,
          child: CustomBoxy(
            delegate: _TopBarDelegate(
              direction: Directionality.of(context),
              emptyHeight: emptyHeight,
              centerTitle: switch (widget.title) {
                final _? => widget.centerTitle,
                null => false,
              },
              hasMenuActions: widget.menuActions.isNotEmpty,
              onLayoutCollapsedActions: _onLayoutCollapsedActions,
            ),
            children: [
              if (_getLeading(context) case final leading?)
                BoxyId(
                  id: _leadingId,
                  child: TopBarAction(
                    key: leading.key,
                    icon: leading.icon,
                    caption: leading.caption,
                    type: leading.type,
                    semanticsLabel: leading.semanticsLabel,
                    onTap: leading.onTap,
                    enabled: leading.enabled,
                  ),
                ),
              if (widget.title case final title?) ...[
                BoxyId(
                  id: _titleId,
                  child: Padding(
                    padding: switch (widget.subtitle) {
                      null => AppSpacings.s12.vertical,
                      _ => AppSpacings.s12.top,
                    },
                    child: Semantics(
                      header: true,
                      container: true,
                      child: Stack(
                        fit: StackFit.passthrough,
                        children: [
                          Align(
                            alignment: titleAlignment,
                            heightFactor: 1,
                            child: AppText(
                              title,
                              style: titleStyle,
                              color: colors.foregroundDefaultPrimary,
                              textAlign: titleTextAlignment,
                              maxLines: 1,
                            ),
                          ),
                          Semantics(label: widget.subtitle),
                        ],
                      ),
                    ),
                  ),
                ),
                if (widget.subtitle case final subtitle?)
                  BoxyId(
                    id: _subtitleId,
                    child: ExcludeSemantics(
                      child: Padding(
                        padding: AppSpacings.s4.top + AppSpacings.s12.bottom,
                        child: Align(
                          alignment: titleAlignment,
                          heightFactor: 1,
                          child: AppText(
                            subtitle,
                            style: AppTextStyles.captionDefault,
                            color: colors.foregroundDefaultSecondary,
                            textAlign: titleTextAlignment,
                            maxLines: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
              ...actionWidgets,
              BoxyId(
                id: _menuActionId,
                child: AppContextMenu(
                  controller: _controller,
                  anchor: const AppContextMenuAnchor(
                    target: AlignmentDirectional.bottomEnd,
                    menu: AlignmentDirectional.topEnd,
                  ),
                  items: contextMenuItems,
                  child: TopBarAction(
                    key: widget.menuKey,
                    icon: AppStandardIcons.dotsHorizontal,
                    type: AppTopBarActionType.brand,
                    semanticsLabel: context.l10n.topBar_menu,
                    onTap: _controller.show,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TopBarDelegate extends BoxyDelegate {
  _TopBarDelegate({
    required this.direction,
    required this.emptyHeight,
    required this.centerTitle,
    required this.hasMenuActions,
    required this.onLayoutCollapsedActions,
  });

  final TextDirection direction;
  final double emptyHeight;
  final bool centerTitle;
  final bool hasMenuActions;
  final void Function(Set<int>) onLayoutCollapsedActions;

  BoxyChild? get title => getChildOrNull(_titleId);
  BoxyChild? get subtitle => getChildOrNull(_subtitleId);
  BoxyChild? get leading => getChildOrNull(_leadingId);
  List<BoxyChild> get actions =>
      super.children.where((child) => child.parentData is _ActionData).toList();
  BoxyChild get menuAction => getChild(_menuActionId);

  /// Paint and semantics order
  @override
  List<BoxyChild> get children => [
    ?leading,
    ?title,
    ?subtitle,
    ...actions,
    menuAction,
  ];

  /// Hit test order
  List<BoxyChild> get _childrenHitTestOrder => [
    menuAction,
    ...actions.reversed,
    // Leading before subtitle. When centerTitle=true subtitle might be below bottom part of
    // the actions' hit test area.
    ?leading,
    ?subtitle,
    ?title,
  ];

  _ActionData _actionData(BoxyChild child) => child.parentData as _ActionData;

  /// Minimum distance of title and subtitle from the top bar's horizontal edges.
  static const _titleSubtitleEdgeMargin = 12.0;

  @override
  Size layout() {
    final maxWidth = constraints.maxWidth;
    final maxHeight = constraints.maxHeight;

    final persistentActionIndexes = actions.indexed
        .where((e) => _actionData(e.$2).persistent)
        .map((e) => e.$1)
        .toList();

    final nonPersistentActionIndexes = actions.indexed
        .map((v) => v.$1)
        .toSet()
        .difference(persistentActionIndexes.toSet())
        .toList();

    final leadingWidth = switch (leading) {
      final leading? => leading.render.getMaxIntrinsicWidth(maxHeight),
      null => 0.0,
    };

    var menuWidth = menuAction.layout(constraints.loosen()).width;

    final actionIntrinsicWidths = actions
        .map((action) => action.render.getMaxIntrinsicWidth(maxHeight))
        .toList();

    final persistentActionsWidth = persistentActionIndexes
        .map((index) => actionIntrinsicWidths[index])
        .sum;

    final titleMaxIntrinsicWidth =
        title?.render.getMaxIntrinsicWidth(maxHeight) ?? 0;

    var precalculatedTitleWidth = min(switch (centerTitle) {
      true => maxWidth - 2 * max(persistentActionsWidth, leadingWidth),
      false => maxWidth - leadingWidth - persistentActionsWidth,
    }, titleMaxIntrinsicWidth);

    var nonPersistentActionsWidthExtent = switch (centerTitle) {
      true => (maxWidth - precalculatedTitleWidth) / 2 - persistentActionsWidth,
      false =>
        maxWidth -
            precalculatedTitleWidth -
            leadingWidth -
            persistentActionsWidth,
    };

    var collapsedActionsIndexes = {...nonPersistentActionIndexes};
    var nonPersistentActionsWidth = 0.0;
    for (final index in nonPersistentActionIndexes.reversed) {
      final width = actions[index].render.getMaxIntrinsicWidth(maxHeight);

      nonPersistentActionsWidthExtent -= width;
      if (nonPersistentActionsWidthExtent < 0) {
        break;
      }
      nonPersistentActionsWidth += width;
      collapsedActionsIndexes.remove(index);
    }

    final showMenu = hasMenuActions || collapsedActionsIndexes.isNotEmpty;

    if (showMenu) {
      precalculatedTitleWidth = min(switch (centerTitle) {
        true =>
          maxWidth - 2 * max(persistentActionsWidth + menuWidth, leadingWidth),
        false => maxWidth - leadingWidth - persistentActionsWidth - menuWidth,
      }, titleMaxIntrinsicWidth);

      nonPersistentActionsWidthExtent = switch (centerTitle) {
        true =>
          (maxWidth - precalculatedTitleWidth) / 2 -
              persistentActionsWidth -
              menuWidth,
        false =>
          maxWidth -
              precalculatedTitleWidth -
              leadingWidth -
              persistentActionsWidth -
              menuWidth,
      };

      collapsedActionsIndexes = {...nonPersistentActionIndexes};
      nonPersistentActionsWidth = 0.0;
      for (final index in nonPersistentActionIndexes.reversed) {
        final width = actions[index].render.getMaxIntrinsicWidth(maxHeight);

        nonPersistentActionsWidthExtent -= width;
        if (nonPersistentActionsWidthExtent < 0) {
          break;
        }
        nonPersistentActionsWidth += width;
        collapsedActionsIndexes.remove(index);
      }
    } else {
      menuWidth = 0;
      menuAction.ignore();
    }

    onLayoutCollapsedActions(collapsedActionsIndexes);

    final leadingMargin = switch (leadingWidth) {
      > 0 => 0.0,
      _ => _titleSubtitleEdgeMargin,
    };

    final titleTrailingOffset =
        persistentActionsWidth + nonPersistentActionsWidth + menuWidth;
    final trailingMargin = switch (titleTrailingOffset) {
      > 0 => 0.0,
      _ => _titleSubtitleEdgeMargin,
    };

    var titleWidth = switch (centerTitle) {
      true =>
        maxWidth -
            2 *
                max(
                  leadingWidth + leadingMargin,
                  titleTrailingOffset + trailingMargin,
                ),
      false =>
        maxWidth -
            (leadingWidth +
                leadingMargin +
                titleTrailingOffset +
                trailingMargin),
    };

    if (titleWidth <= 0 && title != null) {
      assert(false, 'Title has no width');
      titleWidth = 1;
    }

    final titleHeight = title?.render.getMaxIntrinsicHeight(titleWidth) ?? 0;
    // Title is full-width if the title is centered.
    final subtitleWidth = switch (centerTitle) {
      true => maxWidth - 2 * _titleSubtitleEdgeMargin,
      false => titleWidth,
    };
    final subtitleHeight =
        subtitle?.render.getMaxIntrinsicHeight(subtitleWidth) ?? 0;

    var height =
        children
            .where((child) => !child.isIgnored)
            .map((child) => child.render.getMinIntrinsicHeight(maxWidth))
            .maxOrNull ??
        emptyHeight;

    height = max(titleHeight + subtitleHeight, height);

    var offsetStart = 0.0;
    if (leading case final leading?) {
      leading.layout(constraints.loosen().copyWith(maxHeight: height));

      offsetStart = switch (direction) {
        TextDirection.ltr => 0.0,
        TextDirection.rtl => maxWidth - leading.size.width,
      };

      leading.position(Offset(offsetStart, 0));
    }

    var offsetEnd = 0.0;
    if (showMenu) {
      final offsetLeft = switch (direction) {
        TextDirection.ltr => maxWidth - menuAction.size.width,
        TextDirection.rtl => offsetEnd,
      };

      menuAction.position(Offset(offsetLeft, 0));

      offsetEnd += menuAction.size.width;
    }

    for (final action in actions.reversed) {
      final actionData = _actionData(action);
      final actionWidth = actionIntrinsicWidths[actionData.index];

      if (collapsedActionsIndexes.contains(actionData.index) ||
          action == menuAction && !showMenu) {
        action
          ..layout(constraints.loosen())
          ..ignore();

        continue;
      }

      action.layout(BoxConstraints.loose(Size(actionWidth, height)));

      final offsetLeft = switch (direction) {
        TextDirection.ltr => maxWidth - offsetEnd - action.size.width,
        TextDirection.rtl => offsetEnd,
      };

      action.position(Offset(offsetLeft, 0));

      offsetEnd += action.size.width;
    }

    final size = Size(maxWidth, height);
    final rect = Offset.zero & size;

    if (title case final title?) {
      title.layout(BoxConstraints(maxWidth: titleWidth));
      subtitle?.layout(BoxConstraints(maxWidth: subtitleWidth));

      final titleOffsetLeft = switch (centerTitle) {
        false => switch (direction) {
          TextDirection.ltr => leadingWidth + leadingMargin,
          TextDirection.rtl =>
            maxWidth - leadingWidth - title.size.width - leadingMargin,
        },
        true => Alignment.topCenter.inscribe(title.size, rect).left,
      };

      title.position(Offset(titleOffsetLeft, 0));
      subtitle?.position(
        Offset(switch (centerTitle) {
          true => _titleSubtitleEdgeMargin,
          false => titleOffsetLeft,
        }, title.size.height),
      );
    }

    return size;
  }

  @override
  bool hitTest(SliverOffset position) {
    for (final child in _childrenHitTestOrder) {
      if (child.hitTest()) {
        addHit();
        return true;
      }
    }

    return false;
  }

  @override
  bool shouldRelayout(_TopBarDelegate oldDelegate) =>
      direction != oldDelegate.direction ||
      centerTitle != oldDelegate.centerTitle ||
      hasMenuActions != oldDelegate.hasMenuActions ||
      onLayoutCollapsedActions != oldDelegate.onLayoutCollapsedActions;
}

const _curve = Curves.ease;
const _duration = Duration(milliseconds: 150);

enum AppTopBarActionType {
  brand,
  idle;

  AppColor getForegroundColor(
    AppColors colors, {
    required Set<AppPointerSurfaceState> states,
    required bool enabled,
  }) {
    if (!enabled) {
      return switch (this) {
        brand => colors.foregroundDisabledPrimary,
        idle => colors.foregroundDisabledSecondary,
      };
    }

    return switch (this) {
      brand => switch (states) {
        Set(containsPressed: true) => colors.foregroundActivePrimaryPressed,
        _ => colors.foregroundActivePrimary,
      },
      idle => switch (states) {
        Set(containsPressed: true) => colors.foregroundDefaultSecondaryPressed,
        _ => colors.foregroundDefaultSecondary,
      },
    };
  }
}

class AppTopBarAction {
  const AppTopBarAction({
    this.key,
    this.persistent = false,
    this.icon,
    required String this.caption,
    this.type = AppTopBarActionType.brand,
    this.semanticsLabel,
    required this.onTap,
    this.enabled = true,
  });

  const AppTopBarAction.icon({
    this.key,
    this.persistent = false,
    required AppStandardIconData this.icon,
    this.type = AppTopBarActionType.brand,
    required String this.semanticsLabel,
    required this.onTap,
    this.enabled = true,
  }) : caption = null;

  final Key? key;

  /// Whether the action will be always shown in the top bar, taking up
  /// space for the title.
  final bool persistent;
  final AppStandardIconData? icon;
  final String? caption;
  final AppTopBarActionType type;
  final String? semanticsLabel;
  final VoidCallback onTap;
  final bool enabled;
}

class TopBarAction extends StatelessWidget {
  const TopBarAction({
    super.key,
    this.icon,
    this.caption,
    required this.type,
    this.semanticsLabel,
    required this.onTap,
    this.enabled = true,
  });

  final AppStandardIconData? icon;
  final String? caption;
  final AppTopBarActionType type;
  final String? semanticsLabel;
  final VoidCallback onTap;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Semantics(
      label: semanticsLabel ?? caption,
      container: true,
      button: true,
      enabled: enabled,
      onTap: enabled ? onTap : null,
      excludeSemantics: true,
      child: AppPointerSurface(
        enabled: enabled,
        onTap: onTap,
        builder: (context, states) {
          final foregroundColor = type.getForegroundColor(
            colors,
            states: states,
            enabled: enabled,
          );

          return Padding(
            padding: AppSpacings.s12.all,
            child: TweenAnimationBuilder(
              tween: AppColorTween.uniform(foregroundColor),
              duration: _duration,
              curve: _curve,
              builder: (context, foregroundColor, child) => Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon case final icon?)
                    AppIcon(
                      icon,
                      size: AppStandardIconSize.s24,
                      semanticsLabel: null,
                      color: foregroundColor,
                      applyTextScaling: true,
                    ),
                  if (caption != null && icon != null)
                    AppSpacings.s8.horizontalSpace,
                  if (caption case final caption?)
                    Flexible(
                      child: AppText(
                        caption,
                        style: AppTextStyles.button,
                        color: foregroundColor,
                        maxLines: 1,
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
