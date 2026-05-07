import 'package:flutter/widgets.dart';

class AppFreezeInfiniteAnimations extends InheritedWidget {
  const AppFreezeInfiniteAnimations({
    super.key,
    required super.child,
    this.freezeAnimations = true,
  });

  final bool freezeAnimations;

  static bool of(BuildContext context) {
    final freezer = context
        .dependOnInheritedWidgetOfExactType<AppFreezeInfiniteAnimations>();

    return freezer?.freezeAnimations ?? false;
  }

  @override
  bool updateShouldNotify(AppFreezeInfiniteAnimations oldWidget) =>
      oldWidget.freezeAnimations != freezeAnimations;
}
