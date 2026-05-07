import 'package:app_design_system/src/widgets/icon/standard.dart';
import 'package:app_design_system/src/widgets/selection_control/checkbox.dart';
import 'package:app_design_system/src/widgets/selection_control_tile/selection_control_tile_base.dart';
import 'package:flutter/widgets.dart';

class AppCheckboxTile extends StatelessWidget {
  const AppCheckboxTile({
    super.key,
    this.enabled = true,
    required this.onChanged,
    required this.label,
    required this.selected,
    this.showCheckbox = true,
    this.description,
    this.value,
    this.trailingIcon,
  });

  const AppCheckboxTile.tristate({
    super.key,
    this.enabled = true,
    required this.onChanged,
    required this.label,
    required this.selected,
    this.showCheckbox = true,
    this.description,
    this.value,
    this.trailingIcon,
  });

  final bool enabled;
  final ValueChanged<bool> onChanged;
  final String label;
  final bool selected;
  final bool showCheckbox;
  final String? description;
  final String? value;
  final AppStandardIconData? trailingIcon;

  @override
  Widget build(BuildContext context) {
    return SelectionControlTileBase(
      enabled: enabled,
      selected: selected,
      label: label,
      description: description,
      value: value,
      trailingIcon: trailingIcon,
      onTap: () => onChanged(!selected),
      selectionControl: showCheckbox
          ? AppRawCheckbox(enabled: enabled, value: selected, onChanged: (_) {})
          : null,
    );
  }
}
