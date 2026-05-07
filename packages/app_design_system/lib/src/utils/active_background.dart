import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

/// Used to pass info about an active parent down the widget tree to avoid
/// active states in ascendants of active element.
///
/// Example: Icon button inside tappable list item. Tapping on icon button
/// invokes `onTapDown` on both the icon button and list item.
@internal
class AppParentActiveBackgroundProvider extends InheritedWidget {
  const AppParentActiveBackgroundProvider({
    super.key,
    required this.state,
    required super.child,
  });

  final AppParentActiveBackgroundState state;

  @override
  bool updateShouldNotify(AppParentActiveBackgroundProvider oldWidget) =>
      state != oldWidget.state;

  static AppParentActiveBackgroundState? maybeOf(
    BuildContext context,
  ) => context
      .dependOnInheritedWidgetOfExactType<AppParentActiveBackgroundProvider>()
      ?.state;
}

@internal
abstract class AppParentActiveBackgroundState {
  void markChildActiveBackgroundActive(
    AppParentActiveBackgroundState childState,
    bool value,
  );
}

/// How to use this:
///
/// Use [anyChildActiveBackgroundActive] to determine if any child is active.
/// Call [setActive] whenever you set this widget active or inactive.
mixin AppParentActiveBackgroundStateMixin<W extends StatefulWidget> on State<W>
    implements AppParentActiveBackgroundState {
  final _activeChildren = <AppParentActiveBackgroundState>[];

  AppParentActiveBackgroundState? _ancestor;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _ancestor = AppParentActiveBackgroundProvider.maybeOf(context);
  }

  @protected
  bool get anyChildActiveBackgroundActive => _activeChildren.isNotEmpty;

  @override
  void markChildActiveBackgroundActive(
    AppParentActiveBackgroundState childState,
    bool value,
  ) {
    final lastAnyPressed = anyChildActiveBackgroundActive;
    if (value) {
      _activeChildren.add(childState);
    } else {
      _activeChildren.remove(childState);
    }

    final nowAnyPressed = anyChildActiveBackgroundActive;
    if (nowAnyPressed != lastAnyPressed) {
      _ancestor?.markChildActiveBackgroundActive(this, nowAnyPressed);
    }
  }

  @protected
  void setActive(bool active) {
    _ancestor?.markChildActiveBackgroundActive(this, active);
  }

  @override
  void deactivate() {
    setActive(false);
    super.deactivate();
  }
}
