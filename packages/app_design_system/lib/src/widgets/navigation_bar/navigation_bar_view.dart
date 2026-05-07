import 'package:app_design_system/src/widgets/navigation_bar/navigation_bar_controller.dart';
import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';

enum _TransitionDirection {
  ltr,
  rtl;

  bool get isLtr => this == ltr;
}

enum _TransitionType {
  enter,
  exit;

  bool get isEnter => this == enter;
}

enum _Offstage {
  offstage,
  onstage,
  offstageWhenAnimationCompleted;

  bool resolve(AnimationStatus status) {
    return switch (this) {
      offstage => true,
      onstage => false,
      offstageWhenAnimationCompleted => status == AnimationStatus.completed,
    };
  }
}

class _SinglePageTransitionEntry {
  _SinglePageTransitionEntry({
    required this.index,
    required this.offstage,
    required this.hasBeenSelectedBefore,
    required this.type,
  });

  final int index;
  _Offstage offstage;

  /// This is used to determine whether the page has been selected before.
  bool hasBeenSelectedBefore;
  _TransitionType type;
}

class AppNavigationBarView extends StatefulWidget {
  AppNavigationBarView({
    super.key,
    required this.controller,
    required this.pages,
  }) : assert(pages.length == controller.totalPages);

  final AppNavigationBarController controller;
  final List<Widget> pages;

  @override
  State<AppNavigationBarView> createState() => _AppNavigationBarViewState();
}

class _AppNavigationBarViewState extends State<AppNavigationBarView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  final _entries = <_SinglePageTransitionEntry>[];

  late int _currentIndex;
  late int _previousIndex;
  var _direction = _TransitionDirection.ltr;
  static const _duration = Duration(milliseconds: 250);

  int _getClampedIndex(int index) => index.clamp(0, _entries.length - 1);

  _SinglePageTransitionEntry get _currentEntry =>
      _getEntryClamped(_currentIndex);

  _SinglePageTransitionEntry get _previousEntry =>
      _getEntryClamped(_previousIndex);

  _SinglePageTransitionEntry _getEntry(int index) => _entries[index];

  _SinglePageTransitionEntry _getEntryClamped(int index) =>
      _getEntry(_getClampedIndex(index));

  _SinglePageTransitionEntry? _getEntryOrNull(int index) => switch (_entries) {
    [] => null,
    _ => _getEntryClamped(index),
  };

  var _reduceMotion = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: _duration,
      value: 1,
    )..addStatusListener(_onAnimationStatusChanged);

    _currentIndex = widget.controller.current;
    _previousIndex = (widget.controller.current + 1) % widget.pages.length;

    widget.controller.addListener(_onControllerChanged);

    _setupEntries();
    _stageActiveEntries();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // TODO: Possibly replace with MediaQueryData.reduceMotion when Flutter
    // will support it:
    //  https://github.com/flutter/flutter/issues/65874#issuecomment-864261055
    _reduceMotion = MediaQuery.disableAnimationsOf(context);
  }

  @override
  void didUpdateWidget(AppNavigationBarView oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.controller != oldWidget.controller) {
      oldWidget.controller.removeListener(_onControllerChanged);
      widget.controller.addListener(_onControllerChanged);
      _onControllerChanged();
    }

    if (widget.pages.length != oldWidget.pages.length) {
      _setupEntries();
      _stageActiveEntries();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // This provides a way to handle lazy initialization. A page will be
        // mounted in the element tree right when we select if for the first
        // time.
        ..._entries
            .where((entry) => entry.hasBeenSelectedBefore)
            .map(
              (entry) => _SinglePageTransition(
                animation: _controller,
                type: entry.type,
                offstage: entry.offstage,
                direction: _direction,
                child: widget.pages[entry.index],
              ),
            ),
      ],
    );
  }

  void _onAnimationStatusChanged(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      setState(_stageActiveEntries);
    }
  }

  void _setupEntries() {
    final newEntries = widget.pages.mapIndexed((index, page) {
      final hasBeenSelectedBefore =
          _currentIndex == index ||
          (_getEntryOrNull(index)?.hasBeenSelectedBefore ?? false);

      return _SinglePageTransitionEntry(
        index: index,
        offstage: _Offstage.onstage,
        type: _TransitionType.enter,
        hasBeenSelectedBefore: hasBeenSelectedBefore,
      );
    }).toList();

    _entries.addAll(newEntries);
  }

  void _stageActiveEntries() {
    _currentEntry.hasBeenSelectedBefore = true;
    for (final entry in _entries) {
      if (_currentEntry.index == entry.index) {
        entry
          ..offstage = _Offstage.onstage
          ..type = _TransitionType.enter;
      } else if (_previousEntry.index == entry.index) {
        entry
          ..offstage = _Offstage.offstageWhenAnimationCompleted
          ..type = _TransitionType.exit;
      } else {
        entry.offstage = _Offstage.offstage;
      }
    }
  }

  void _onControllerChanged() {
    if (_currentIndex != widget.controller.current) {
      setState(() {
        _controller.stop();

        _previousIndex = _currentIndex;
        _currentIndex = widget.controller.current;

        _stageActiveEntries();

        _direction = _currentIndex > _previousIndex
            ? _TransitionDirection.ltr
            : _TransitionDirection.rtl;

        if (_reduceMotion) {
          _controller.value = 1;
        } else {
          _controller
            ..value = 0
            ..forward();
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    widget.controller.removeListener(_onControllerChanged);

    super.dispose();
  }
}

class _SinglePageTransition extends StatelessWidget {
  const _SinglePageTransition({
    required this.animation,
    required this.direction,
    required this.type,
    required this.child,
    required this.offstage,
  });

  final Animation<double> animation;
  final Widget child;
  final _TransitionDirection direction;
  final _TransitionType type;
  final _Offstage offstage;

  static const _curve = Curves.ease;
  static const _offsetFactor = 0.2;

  Animatable<double> _getOpacityTransitionAnimatable() {
    final animatable = Tween<double>(
      begin: type.isEnter ? 0 : 1,
      end: type.isEnter ? 1 : 0,
    ).chain(CurveTween(curve: _curve));

    return animatable;
  }

  Animatable<Offset> _getOffsetTransitionAnimatable(
    TextDirection textDirection,
  ) {
    final animatable = Tween(
      begin: _getBeginOffset(textDirection),
      end: _getEndOffset(textDirection),
    ).chain(CurveTween(curve: _curve));

    return animatable;
  }

  double _getSign(TextDirection textDirection) => switch (textDirection) {
    TextDirection.ltr => 1.0,
    TextDirection.rtl => -1.0,
  };

  Offset _getBeginOffset(TextDirection textDirection) =>
      switch (type.isEnter) {
        true => Offset(!direction.isLtr ? -_offsetFactor : _offsetFactor, 0),
        false => Offset.zero,
      } *
      _getSign(textDirection);

  Offset _getEndOffset(TextDirection textDirection) =>
      switch (type.isEnter) {
        true => Offset.zero,
        false => Offset(direction.isLtr ? -_offsetFactor : _offsetFactor, 0),
      } *
      _getSign(textDirection);

  @override
  Widget build(BuildContext context) {
    final textDirection = Directionality.of(context);

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Offstage(
          offstage: offstage.resolve(animation.status),
          child: child,
        );
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          final opacityTween = _getOpacityTransitionAnimatable();
          final offsetTween = _getOffsetTransitionAnimatable(textDirection);
          final maxWidth = constraints.maxWidth;

          return AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              final opacity = opacityTween.evaluate(animation);
              final translation = offsetTween.evaluate(animation);
              final offset = translation * maxWidth;

              return Transform.translate(
                offset: offset,
                child: Opacity(
                  opacity: opacity,
                  child: ClipRect(child: child),
                ),
              );
            },
            child: child,
          );
        },
      ),
    );
  }
}
