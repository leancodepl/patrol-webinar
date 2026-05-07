import 'package:app_design_system/src/widgets/icon/standard.dart';
import 'package:app_design_system/src/widgets/selection_control/radio.dart';
import 'package:app_design_system/src/widgets/selection_control_tile/selection_control_tile_base.dart';
import 'package:flutter/widgets.dart';

class AppRadioTile<T> extends StatelessWidget {
  const AppRadioTile({
    super.key,
    this.enabled = true,
    required this.onChanged,
    required this.label,
    required this.radioValue,
    required this.radioGroupValue,
    this.showRadio = true,
    this.description,
    this.value,
    this.trailingIcon,
  });

  final bool enabled;
  final ValueChanged<T> onChanged;
  final String label;
  final T radioValue;
  final T radioGroupValue;
  final bool showRadio;
  final String? description;
  final String? value;
  final AppStandardIconData? trailingIcon;

  bool get _selected => radioValue == radioGroupValue;

  @override
  Widget build(BuildContext context) {
    return SelectionControlTileBase(
      enabled: enabled,
      selected: _selected,
      label: label,
      description: description,
      value: value,
      trailingIcon: trailingIcon,
      onTap: () {
        if (!_selected) {
          onChanged(radioValue);
        }
      },
      selectionControl: showRadio
          ? AppRadio(
              enabled: enabled,
              value: radioValue,
              groupValue: radioGroupValue,
              onChanged: (_) {},
            )
          : null,
    );
  }
}
