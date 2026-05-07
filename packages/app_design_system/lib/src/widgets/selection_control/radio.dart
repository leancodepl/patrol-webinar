import 'package:app_design_system/src/utils/pointer_surface.dart';
import 'package:app_design_system/src/widgets/selection_control/widgets/radio_body.dart';
import 'package:flutter/widgets.dart';

class AppRadio<T> extends StatelessWidget {
  const AppRadio({
    super.key,
    this.enabled = true,
    this.danger = false,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  final bool enabled;
  final bool danger;
  final T value;
  final T groupValue;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    final selected = value == groupValue;

    return Semantics(
      enabled: enabled,
      selected: selected,
      inMutuallyExclusiveGroup: true,
      child: AppPointerSurface(
        enabled: enabled,
        onTap: () => onChanged(value),
        builder: (context, states) => RadioBody(
          enabled: enabled,
          selected: selected,
          danger: danger,
          pressed: states.containsPressed,
        ),
      ),
    );
  }
}
