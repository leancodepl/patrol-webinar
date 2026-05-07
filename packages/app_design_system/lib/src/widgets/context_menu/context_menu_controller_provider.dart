import 'package:app_design_system/src/widgets/context_menu/context_menu_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

@internal
class ContextMenuControllerProvider extends InheritedWidget {
  const ContextMenuControllerProvider({
    super.key,
    required super.child,
    required this.controller,
  });

  final AppContextMenuController controller;

  static AppContextMenuController? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ContextMenuControllerProvider>()
        ?.controller;
  }

  @override
  bool updateShouldNotify(ContextMenuControllerProvider oldWidget) {
    return controller != oldWidget.controller;
  }
}
