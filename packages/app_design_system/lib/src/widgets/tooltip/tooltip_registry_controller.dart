import 'package:app_design_system/src/widgets/tooltip/tooltip_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

@internal
class TooltipRegistryController extends ChangeNotifier {
  TooltipRegistryController({required this.registryKey});

  final GlobalKey registryKey;
  final Map<Object, TooltipController> _tooltips = {};

  void register(Object key, TooltipController controller) {
    _tooltips[key] = controller;
    notifyListeners();
  }

  void unregister(Object key) {
    _tooltips.remove(key);
    notifyListeners();
  }

  TooltipController? get(Object key) {
    return _tooltips[key];
  }

  static TooltipRegistryController of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<
          InheritedTooltipRegistryController
        >()!
        .controller;
  }
}

@internal
class InheritedTooltipRegistryController extends InheritedWidget {
  const InheritedTooltipRegistryController({
    super.key,
    required super.child,
    required this.controller,
  });

  final TooltipRegistryController controller;

  @override
  bool updateShouldNotify(InheritedTooltipRegistryController oldWidget) {
    return controller != oldWidget.controller;
  }
}
