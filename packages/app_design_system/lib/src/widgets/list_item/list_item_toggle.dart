import 'package:app_design_system/src/widgets/selection_control/toggle.dart';
import 'package:flutter/widgets.dart';

class AppListItemToggle extends StatelessWidget {
  const AppListItemToggle({
    super.key,
    this.enabled = true,
    required this.value,
    required this.onToggleChanged,
  });

  final bool enabled;
  final bool value;
  final ValueChanged<bool>? onToggleChanged;

  @override
  Widget build(BuildContext context) {
    return AppToggle(
      value: value,
      enabled: enabled,
      onChanged: onToggleChanged,
    );
  }
}
