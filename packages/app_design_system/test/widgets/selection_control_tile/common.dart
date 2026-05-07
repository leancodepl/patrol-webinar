import 'package:app_design_system/app_design_system.dart';
import 'package:flutter/widgets.dart';

class SelectionControlScenario {
  const SelectionControlScenario({
    required this.name,
    required this.longLabel,
    required this.description,
    required this.longDescription,
    required this.value,
    required this.longValue,
    required this.icon,
    required this.pressed,
    required this.enabled,
    required this.showControl,
  });

  final String name;
  final bool longLabel;
  final bool description;
  final bool longDescription;
  final bool value;
  final bool longValue;
  final bool icon;
  final bool pressed;
  final bool enabled;
  final bool showControl;

  static List<SelectionControlScenario> getScenarios() {
    return [
      const SelectionControlScenario(
        name: 'Default',
        longLabel: false,
        description: false,
        longDescription: false,
        value: false,
        longValue: false,
        icon: false,
        pressed: false,
        enabled: true,
        showControl: true,
      ),
      const SelectionControlScenario(
        name: 'With description',
        longLabel: false,
        description: true,
        longDescription: false,
        value: false,
        longValue: false,
        icon: false,
        pressed: false,
        enabled: true,
        showControl: true,
      ),
      const SelectionControlScenario(
        name: 'With description and value',
        longLabel: false,
        description: true,
        longDescription: false,
        value: true,
        longValue: false,
        icon: false,
        pressed: false,
        enabled: true,
        showControl: true,
      ),
      const SelectionControlScenario(
        name: 'With description, value and icon',
        longLabel: false,
        description: true,
        longDescription: false,
        value: true,
        longValue: false,
        icon: true,
        pressed: false,
        enabled: true,
        showControl: true,
      ),
      const SelectionControlScenario(
        name: 'With description, value, icon and no control',
        longLabel: false,
        description: true,
        longDescription: false,
        value: true,
        longValue: false,
        icon: true,
        pressed: false,
        enabled: true,
        showControl: false,
      ),
      const SelectionControlScenario(
        name: 'With long description, value and icon',
        longLabel: false,
        description: false,
        longDescription: true,
        value: true,
        longValue: false,
        icon: true,
        pressed: false,
        enabled: true,
        showControl: true,
      ),
      const SelectionControlScenario(
        name: 'With long label, long description, value and icon',
        longLabel: true,
        description: false,
        longDescription: true,
        value: true,
        longValue: false,
        icon: true,
        pressed: false,
        enabled: true,
        showControl: true,
      ),
      const SelectionControlScenario(
        name: 'With long description, long value and icon',
        longLabel: false,
        description: false,
        longDescription: true,
        value: false,
        longValue: true,
        icon: true,
        pressed: false,
        enabled: true,
        showControl: true,
      ),
      const SelectionControlScenario(
        name: 'With long description, long value, icon and no control',
        longLabel: false,
        description: false,
        longDescription: true,
        value: false,
        longValue: true,
        icon: true,
        pressed: false,
        enabled: true,
        showControl: false,
      ),
      const SelectionControlScenario(
        name: 'Pressed',
        longLabel: false,
        description: false,
        longDescription: true,
        value: false,
        longValue: true,
        icon: true,
        pressed: true,
        enabled: true,
        showControl: true,
      ),
      const SelectionControlScenario(
        name: 'Disabled',
        longLabel: false,
        description: false,
        longDescription: true,
        value: false,
        longValue: true,
        icon: true,
        pressed: false,
        enabled: false,
        showControl: true,
      ),
    ];
  }
}

const _label = 'Tile label';
const _longLabel =
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In viverra semper malesuada.';
const _description = 'Description';
const _value = 'Value';
const _icon = AppStandardIcons.mail01;
const _longDescription =
    'Bieg w szybkim tempie, możliwy do utrzymania przez dłuższy czas. Wysiłek na granicy komfortu, nie osiągając maksymalnej intensywności.';
const _longValue =
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In viverra semper malesuada.';

Widget getWidgetFromScenario(
  SelectionControlScenario scenario,
  SelectionControlType type,
  bool selected,
  GlobalKey? key,
) {
  return switch (type) {
    SelectionControlType.radio => AppRadioTile(
      key: key,
      label: scenario.longLabel ? _longLabel : _label,
      radioValue: selected,
      radioGroupValue: true,
      enabled: scenario.enabled,
      description: scenario.longDescription
          ? _longDescription
          : scenario.description
          ? _description
          : null,
      value: scenario.longValue
          ? _longValue
          : scenario.value
          ? _value
          : null,
      trailingIcon: scenario.icon ? _icon : null,
      onChanged: (_) {},
      showRadio: scenario.showControl,
    ),
    SelectionControlType.checkbox => AppCheckboxTile(
      key: key,
      onChanged: (_) {},
      label: scenario.longLabel ? _longLabel : _label,
      selected: selected,
      enabled: scenario.enabled,
      description: scenario.longDescription
          ? _longDescription
          : scenario.description
          ? _description
          : null,
      value: scenario.longValue
          ? _longValue
          : scenario.value
          ? _value
          : null,
      trailingIcon: scenario.icon ? _icon : null,
      showCheckbox: scenario.showControl,
    ),
  };
}

enum SelectionControlType { radio, checkbox }
