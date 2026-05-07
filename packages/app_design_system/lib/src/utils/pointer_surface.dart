import 'package:app_design_system/src/styleguide/motion.dart';
import 'package:app_design_system/src/utils/active_background.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

@internal
extension AppPointerSurfaceStateSetExtension on Set<AppPointerSurfaceState> {
  bool get containsPressed => contains(AppPointerSurfaceState.pressed);

  /// Returns a curve applied to animated widgets that respond to pointer state
  /// changes. For pressed states, it provides a curve that begins with higher
  /// velocity, creating a more pronounced transition effect. This behavior is
  /// ideal for buttons, actions, or any interactive elements.
  Curve get transitionCurve {
    if (containsPressed) {
      return AppCurves.pointerEnter;
    }
    return AppCurves.pointerLeave;
  }
}

@internal
enum AppPointerSurfaceState { pressed }

@internal
typedef AppPointerSurfaceBuilder =
    Widget Function(BuildContext context, Set<AppPointerSurfaceState> states);

@internal
class AppPointerSurface extends StatefulWidget {
  const AppPointerSurface({
    super.key,
    required this.enabled,
    required this.onTap,
    required this.builder,
  });

  final bool enabled;
  final VoidCallback? onTap;
  final AppPointerSurfaceBuilder builder;

  @override
  State<AppPointerSurface> createState() => _AppPointerSurfaceState();
}

class _AppPointerSurfaceState extends State<AppPointerSurface>
    with AppParentActiveBackgroundStateMixin {
  var _pressed = false;

  void _onTapDown() {
    setState(() {
      _pressed = true;
      setActive(true);
    });
  }

  void _onTapUpOrCancel() {
    setState(() {
      _pressed = false;
      setActive(false);
    });
  }

  Set<AppPointerSurfaceState> _getStates() {
    if (!widget.enabled) {
      return {};
    }

    return {
      if (_pressed && !anyChildActiveBackgroundActive)
        AppPointerSurfaceState.pressed,
    };
  }

  @override
  Widget build(BuildContext context) {
    final states = _getStates();

    return AppParentActiveBackgroundProvider(
      state: this,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: widget.enabled ? widget.onTap : null,
        onTapDown: (_) => _onTapDown(),
        onTapUp: (_) => _onTapUpOrCancel(),
        onTapCancel: _onTapUpOrCancel,
        child: Builder(builder: (context) => widget.builder(context, states)),
      ),
    );
  }
}
