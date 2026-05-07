import 'package:app_design_system/app_design_system.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import '../../test_app.dart';

final _surface = Surface.canvas(width: 900, height: 900);

void _onChanged(bool value) {}

void main() {
  group('AppRadioField', () {
    testGoldens('default', (tester) async {
      final keys = GlobalKeyGenerator();

      const groupValue = true;

      await pumpWidgetBuilder(
        tester,
        GoldenTable(
          header: const GoldenTableHeader(
            headerName: 'State',
            cellNames: ['Selected', 'Not selected'],
          ),
          cellFlex: 350,
          cellAlignment: GoldenTableCellAlignment.stretch,
          rows: [
            const GoldenTableRow(
              details: 'Pressed: no',
              cells: [
                AppRadioField(
                  radioValue: true,
                  radioGroupValue: groupValue,
                  onChanged: _onChanged,
                  label: 'Label',
                  description: 'Description',
                  value: 'Value',
                ),
                AppRadioField(
                  radioValue: false,
                  radioGroupValue: groupValue,
                  onChanged: _onChanged,
                  label: 'Label',
                  description: 'Description',
                  value: 'Value',
                ),
              ],
            ),
            const GoldenTableRow(
              details: 'Required: yes\nPressed: no',
              cells: [
                AppRadioField(
                  radioValue: true,
                  radioGroupValue: groupValue,
                  onChanged: _onChanged,
                  label: 'Label',
                  description: 'Description',
                  value: 'Value',
                  required: true,
                ),
                AppRadioField(
                  radioValue: false,
                  radioGroupValue: groupValue,
                  onChanged: _onChanged,
                  label: 'Label',
                  description: 'Description',
                  value: 'Value',
                  required: true,
                ),
              ],
            ),
            GoldenTableRow(
              details: 'Pressed: yes',
              cells: [
                AppRadioField(
                  key: keys.next(),
                  radioValue: true,
                  radioGroupValue: groupValue,
                  onChanged: _onChanged,
                  label: 'Label',
                  description: 'Description',
                  value: 'Value',
                ),
                AppRadioField(
                  key: keys.next(),
                  radioValue: false,
                  radioGroupValue: groupValue,
                  onChanged: _onChanged,
                  label: 'Label',
                  description: 'Description',
                  value: 'Value',
                ),
              ],
            ),
            GoldenTableRow(
              details: 'Required: yes\nPressed: yes',
              cells: [
                AppRadioField(
                  key: keys.next(),
                  radioValue: true,
                  radioGroupValue: groupValue,
                  onChanged: _onChanged,
                  label: 'Label',
                  description: 'Description',
                  value: 'Value',
                  required: true,
                ),
                AppRadioField(
                  key: keys.next(),
                  radioValue: false,
                  radioGroupValue: groupValue,
                  onChanged: _onChanged,
                  label: 'Label',
                  description: 'Description',
                  value: 'Value',
                  required: true,
                ),
              ],
            ),
            const GoldenTableRow(
              details: 'Error: yes\nRequired: yes\nPressed: no',
              cells: [
                AppRadioField(
                  radioValue: true,
                  radioGroupValue: groupValue,
                  onChanged: _onChanged,
                  label: 'Label',
                  description: 'Description',
                  error: 'Error message kaboom!',
                  value: 'Value',
                  required: true,
                ),
                AppRadioField(
                  radioValue: false,
                  radioGroupValue: groupValue,
                  onChanged: _onChanged,
                  label: 'Label',
                  description: 'Description',
                  error: 'Error message kaboom!',
                  value: 'Value',
                  required: true,
                ),
              ],
            ),
            GoldenTableRow(
              details: 'Error: yes\nPressed: yes',
              cells: [
                AppRadioField(
                  key: keys.next(),
                  radioValue: true,
                  radioGroupValue: groupValue,
                  onChanged: _onChanged,
                  label: 'Label',
                  description: 'Description',
                  error: 'Error message kaboom!',
                  value: 'Value',
                ),
                AppRadioField(
                  key: keys.next(),
                  radioValue: false,
                  radioGroupValue: groupValue,
                  onChanged: _onChanged,
                  label: 'Label',
                  description: 'Description',
                  error: 'Error message kaboom!',
                  value: 'Value',
                ),
              ],
            ),
            GoldenTableRow(
              details: 'Error: yes\nRequired: yes\nPressed: yes',
              cells: [
                AppRadioField(
                  key: keys.next(),
                  radioValue: true,
                  radioGroupValue: groupValue,
                  onChanged: _onChanged,
                  label: 'Label',
                  description: 'Description',
                  error: 'Error message kaboom!',
                  value: 'Value',
                  required: true,
                ),
                AppRadioField(
                  key: keys.next(),
                  radioValue: false,
                  radioGroupValue: groupValue,
                  onChanged: _onChanged,
                  label: 'Label',
                  description: 'Description',
                  error: 'Error message kaboom!',
                  value: 'Value',
                  required: true,
                ),
              ],
            ),
            const GoldenTableRow(
              details: 'State: Disabled\nRequired: yes',
              cells: [
                AppRadioField(
                  radioValue: true,
                  radioGroupValue: groupValue,
                  enabled: false,
                  onChanged: _onChanged,
                  label: 'Label',
                  description: 'Description',
                  value: 'Value',
                  required: true,
                ),
                AppRadioField(
                  radioValue: false,
                  radioGroupValue: groupValue,
                  enabled: false,
                  onChanged: _onChanged,
                  label: 'Label',
                  description: 'Description',
                  value: 'Value',
                  required: true,
                ),
              ],
            ),
            const GoldenTableRow(
              details: 'State: Disabled\nError: yes',
              cells: [
                AppRadioField(
                  radioValue: true,
                  radioGroupValue: groupValue,
                  enabled: false,
                  onChanged: _onChanged,
                  label: 'Label',
                  description: 'Description',
                  error: 'Error message kaboom!',
                  value: 'Value',
                ),
                AppRadioField(
                  radioValue: false,
                  radioGroupValue: groupValue,
                  enabled: false,
                  onChanged: _onChanged,
                  label: 'Label',
                  description: 'Description',
                  error: 'Error message kaboom!',
                  value: 'Value',
                ),
              ],
            ),
            const GoldenTableRow(
              details: 'State: Disabled',
              cells: [
                AppRadioField(
                  radioValue: true,
                  radioGroupValue: groupValue,
                  enabled: false,
                  onChanged: _onChanged,
                  label: 'Label',
                  description: 'Description',
                  value: 'Value',
                ),
                AppRadioField(
                  radioValue: false,
                  radioGroupValue: groupValue,
                  enabled: false,
                  onChanged: _onChanged,
                  label: 'Label',
                  description: 'Description',
                  value: 'Value',
                ),
              ],
            ),
          ],
        ),
        surface: _surface,
      );

      await tester.tapDownAll(keys);

      await tester.pumpAndSettle();

      await widgetsMatchGoldens(tester, 'radio_field', surface: _surface);
    });
  });
}
