import 'package:app_design_system/src/widgets/tooltip/tooltip.dart';
import 'package:app_design_system/src/widgets/tooltip/tooltip_registry_controller.dart';
import 'package:flutter/widgets.dart';

/// Extension on [BuildContext] to show and hide tooltips provided by the
/// [AppTooltip] widget.
extension AppTooltipContextExtension on BuildContext {
  /// Show the tooltip with the given tag that was passed to the [AppTooltip]
  /// widget. Requires the tooltip with the given tag to be registered in the
  /// [AppTooltipRegistry] that is a descendant of this context.
  void showTooltip(Object tag) {
    TooltipRegistryController.of(this).get(tag)?.show();
  }

  /// Hide the tooltip with the given tag that was passed to the [AppTooltip]
  /// widget. Requires the tooltip with the given tag to be registered in the
  /// [AppTooltipRegistry] that is a descendant of this context.
  void hideTooltip(Object tag) {
    TooltipRegistryController.of(this).get(tag)?.hide();
  }

  /// Show if hidden, hide if shown, the tooltip with the given tag that was
  /// passed to the [AppTooltip] widget. Requires the tooltip with the given tag
  /// to be registered in the [AppTooltipRegistry] that is a descendant of this
  /// context.
  void toggleTooltip(Object tag) {
    TooltipRegistryController.of(this).get(tag)?.toggle();
  }
}
