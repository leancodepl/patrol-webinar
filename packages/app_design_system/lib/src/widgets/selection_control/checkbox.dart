import 'package:app_design_system/src/utils/pointer_surface.dart';
import 'package:app_design_system/src/widgets/selection_control/widgets/checkbox_body.dart';
import 'package:flutter/widgets.dart';

class AppRawCheckbox extends StatelessWidget {
  const AppRawCheckbox({
    super.key,
    this.enabled = true,
    this.danger = false,
    required bool this.value,
    required this.onChanged,
  });

  const AppRawCheckbox.tristate({
    super.key,
    this.enabled = true,
    this.danger = false,
    required this.value,
    required this.onChanged,
  });

  final bool enabled;
  final bool danger;
  final bool? value;
  final ValueChanged<bool> onChanged;

  static const size = 20.0;

  @override
  Widget build(BuildContext context) {
    final checked = switch (value) {
      true => true,
      false || null => false,
    };

    final mixed = switch (value) {
      null => true,
      false || true => false,
    };

    return Semantics(
      enabled: enabled,
      checked: checked,
      mixed: mixed,
      child: AppPointerSurface(
        enabled: enabled,
        onTap: () => onChanged.call(!checked),
        builder: (context, states) => CheckboxBody(
          enabled: enabled,
          checked: checked,
          mixed: mixed,
          hasError: danger,
          pressed: states.containsPressed,
        ),
      ),
    );
  }
}
