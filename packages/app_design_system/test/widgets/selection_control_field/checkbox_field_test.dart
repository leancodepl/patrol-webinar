import 'package:app_design_system/app_design_system.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import '../../test_app.dart';

final _surface = Surface.canvas(width: 1100, height: 900);

void _onChanged<T>(T _) {}

void main() {
  group('AppCheckboxField', () {
    testGoldens('default', (tester) async {
      final keys = GlobalKeyGenerator();

      await pumpWidgetBuilder(
        tester,
        GoldenTable(
          header: const GoldenTableHeader(
            headerName: 'State',
            cellNames: ['Checked', 'Unchecked'],
          ),
          cellAlignment: GoldenTableCellAlignment.stretch,
          cellFlex: 400,
          rows: [
            GoldenTableRow(
              details: 'Pressed: no',
              cells: [
                AppCheckboxField(
                  checkboxValue: true,
                  onChanged: _onChanged,
                  label: 'Label',
                  description: 'Description',
                  value: 'Value',
                ),
                AppCheckboxField(
                  checkboxValue: false,
                  onChanged: _onChanged,
                  label: 'Label',
                  description: 'Description',
                  value: 'Value',
                ),
              ],
            ),
            GoldenTableRow(
              details: 'Required: yes\nPressed: no',
              cells: [
                AppCheckboxField(
                  checkboxValue: true,
                  onChanged: _onChanged,
                  label: 'Label',
                  description: 'Description',
                  value: 'Value',
                  required: true,
                ),
                AppCheckboxField(
                  checkboxValue: false,
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
                AppCheckboxField(
                  key: keys.next(),
                  checkboxValue: true,
                  onChanged: _onChanged,
                  label: 'Label',
                  description: 'Description',
                  value: 'Value',
                ),
                AppCheckboxField(
                  key: keys.next(),
                  checkboxValue: false,
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
                AppCheckboxField(
                  key: keys.next(),
                  checkboxValue: true,
                  onChanged: _onChanged,
                  label: 'Label',
                  description: 'Description',
                  value: 'Value',
                  required: true,
                ),
                AppCheckboxField(
                  key: keys.next(),
                  checkboxValue: false,
                  onChanged: _onChanged,
                  label: 'Label',
                  description: 'Description',
                  value: 'Value',
                  required: true,
                ),
              ],
            ),
            GoldenTableRow(
              details: 'Error: yes\nRequired: yes\nPressed: no',
              cells: [
                AppCheckboxField(
                  checkboxValue: true,
                  onChanged: _onChanged,
                  label: 'Label',
                  description: 'Description',
                  error: 'Error message kaboom!',
                  value: 'Value',
                  required: true,
                ),
                AppCheckboxField(
                  checkboxValue: false,
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
                AppCheckboxField(
                  key: keys.next(),
                  checkboxValue: true,
                  onChanged: _onChanged,
                  label: 'Label',
                  description: 'Description',
                  error: 'Error message kaboom!',
                  value: 'Value',
                ),
                AppCheckboxField(
                  key: keys.next(),
                  checkboxValue: false,
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
                AppCheckboxField(
                  key: keys.next(),
                  checkboxValue: true,
                  onChanged: _onChanged,
                  label: 'Label',
                  description: 'Description',
                  error: 'Error message kaboom!',
                  value: 'Value',
                  required: true,
                ),
                AppCheckboxField(
                  key: keys.next(),
                  checkboxValue: false,
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
              details: 'Required: yes',
              cells: [
                AppCheckboxField(
                  checkboxValue: true,
                  enabled: false,
                  onChanged: _onChanged,
                  label: 'Label',
                  description: 'Description',
                  value: 'Value',
                  required: true,
                ),
                AppCheckboxField(
                  checkboxValue: false,
                  enabled: false,
                  onChanged: _onChanged,
                  label: 'Label',
                  description: 'Description',
                  value: 'Value',
                  required: true,
                ),
              ],
            ),
            GoldenTableRow(
              details: 'State: Disabled\nError: yes',
              cells: [
                AppCheckboxField(
                  checkboxValue: true,
                  enabled: false,
                  onChanged: _onChanged,
                  label: 'Label',
                  description: 'Description',
                  error: 'Error message kaboom!',
                  value: 'Value',
                ),
                AppCheckboxField(
                  checkboxValue: false,
                  enabled: false,
                  onChanged: _onChanged,
                  label: 'Label',
                  description: 'Description',
                  error: 'Error message kaboom!',
                  value: 'Value',
                ),
              ],
            ),
            GoldenTableRow(
              details: 'State: Disabled',
              cells: [
                AppCheckboxField(
                  checkboxValue: true,
                  enabled: false,
                  onChanged: _onChanged,
                  label: 'Label',
                  description: 'Description',
                  value: 'Value',
                ),
                AppCheckboxField(
                  checkboxValue: false,
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

      await widgetsMatchGoldens(tester, 'checkbox_field', surface: _surface);
    });

    testGoldens('tristate', (tester) async {
      final keys = GlobalKeyGenerator();

      await pumpWidgetBuilder(
        tester,
        GoldenTable(
          header: const GoldenTableHeader(
            headerName: 'State',
            cellNames: ['Checked', 'Intermediate', 'Unchecked'],
          ),
          cellFlex: 300,
          rows: [
            GoldenTableRow(
              details: 'Pressed: no',
              cells: [
                AppCheckboxField.tristate(
                  checkboxValue: true,
                  onChanged: _onChanged,
                  label: 'Label',
                  description: 'Description',
                  value: 'Value',
                ),
                AppCheckboxField.tristate(
                  checkboxValue: null,
                  onChanged: _onChanged,
                  label: 'Label',
                  description: 'Description',
                  value: 'Value',
                ),
                AppCheckboxField.tristate(
                  checkboxValue: false,
                  onChanged: _onChanged,
                  label: 'Label',
                  description: 'Description',
                  value: 'Value',
                ),
              ],
            ),
            GoldenTableRow(
              details: 'Required: yes\nPressed: no',
              cells: [
                AppCheckboxField.tristate(
                  checkboxValue: true,
                  onChanged: _onChanged,
                  label: 'Label',
                  description: 'Description',
                  value: 'Value',
                  required: true,
                ),
                AppCheckboxField.tristate(
                  checkboxValue: null,
                  onChanged: _onChanged,
                  label: 'Label',
                  description: 'Description',
                  value: 'Value',
                  required: true,
                ),
                AppCheckboxField.tristate(
                  checkboxValue: false,
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
                AppCheckboxField.tristate(
                  key: keys.next(),
                  checkboxValue: true,
                  onChanged: _onChanged,
                  label: 'Label',
                  description: 'Description',
                  value: 'Value',
                ),
                AppCheckboxField.tristate(
                  key: keys.next(),
                  checkboxValue: null,
                  onChanged: _onChanged,
                  label: 'Label',
                  description: 'Description',
                  value: 'Value',
                ),
                AppCheckboxField.tristate(
                  key: keys.next(),
                  checkboxValue: false,
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
                AppCheckboxField.tristate(
                  key: keys.next(),
                  checkboxValue: true,
                  onChanged: _onChanged,
                  label: 'Label',
                  description: 'Description',
                  value: 'Value',
                  required: true,
                ),
                AppCheckboxField.tristate(
                  key: keys.next(),
                  checkboxValue: null,
                  onChanged: _onChanged,
                  label: 'Label',
                  description: 'Description',
                  value: 'Value',
                  required: true,
                ),
                AppCheckboxField.tristate(
                  key: keys.next(),
                  checkboxValue: false,
                  onChanged: _onChanged,
                  label: 'Label',
                  description: 'Description',
                  value: 'Value',
                  required: true,
                ),
              ],
            ),
            GoldenTableRow(
              details: 'Error: yes\nRequired: yes\nPressed: no',
              cells: [
                AppCheckboxField.tristate(
                  checkboxValue: true,
                  onChanged: _onChanged,
                  label: 'Label',
                  description: 'Description',
                  error: 'Error message kaboom!',
                  value: 'Value',
                  required: true,
                ),
                AppCheckboxField.tristate(
                  checkboxValue: null,
                  onChanged: _onChanged,
                  label: 'Label',
                  description: 'Description',
                  error: 'Error message kaboom!',
                  value: 'Value',
                  required: true,
                ),
                AppCheckboxField.tristate(
                  checkboxValue: false,
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
                AppCheckboxField.tristate(
                  key: keys.next(),
                  checkboxValue: true,
                  onChanged: _onChanged,
                  label: 'Label',
                  description: 'Description',
                  error: 'Error message kaboom!',
                  value: 'Value',
                ),
                AppCheckboxField.tristate(
                  key: keys.next(),
                  checkboxValue: null,
                  onChanged: _onChanged,
                  label: 'Label',
                  description: 'Description',
                  error: 'Error message kaboom!',
                  value: 'Value',
                ),
                AppCheckboxField.tristate(
                  key: keys.next(),
                  checkboxValue: false,
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
                AppCheckboxField.tristate(
                  key: keys.next(),
                  checkboxValue: true,
                  onChanged: _onChanged,
                  label: 'Label',
                  description: 'Description',
                  error: 'Error message kaboom!',
                  value: 'Value',
                  required: true,
                ),
                AppCheckboxField.tristate(
                  key: keys.next(),
                  checkboxValue: null,
                  onChanged: _onChanged,
                  label: 'Label',
                  description: 'Description',
                  error: 'Error message kaboom!',
                  value: 'Value',
                  required: true,
                ),
                AppCheckboxField.tristate(
                  key: keys.next(),
                  checkboxValue: false,
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
              details: 'State: Disabled\nRequired: yes',
              cells: [
                AppCheckboxField.tristate(
                  checkboxValue: true,
                  enabled: false,
                  onChanged: _onChanged,
                  label: 'Label',
                  description: 'Description',
                  value: 'Value',
                  required: true,
                ),
                AppCheckboxField.tristate(
                  checkboxValue: null,
                  enabled: false,
                  onChanged: _onChanged,
                  label: 'Label',
                  description: 'Description',
                  value: 'Value',
                  required: true,
                ),
                AppCheckboxField.tristate(
                  checkboxValue: false,
                  enabled: false,
                  onChanged: _onChanged,
                  label: 'Label',
                  description: 'Description',
                  value: 'Value',
                  required: true,
                ),
              ],
            ),
            GoldenTableRow(
              details: 'State: Disabled\nError: yes',
              cells: [
                AppCheckboxField.tristate(
                  checkboxValue: true,
                  enabled: false,
                  onChanged: _onChanged,
                  label: 'Label',
                  description: 'Description',
                  error: 'Error message kaboom!',
                  value: 'Value',
                ),
                AppCheckboxField.tristate(
                  checkboxValue: null,
                  enabled: false,
                  onChanged: _onChanged,
                  label: 'Label',
                  description: 'Description',
                  error: 'Error message kaboom!',
                  value: 'Value',
                ),
                AppCheckboxField.tristate(
                  checkboxValue: false,
                  enabled: false,
                  onChanged: _onChanged,
                  label: 'Label',
                  description: 'Description',
                  error: 'Error message kaboom!',
                  value: 'Value',
                ),
              ],
            ),
            GoldenTableRow(
              details: 'State: Disabled',
              cells: [
                AppCheckboxField.tristate(
                  checkboxValue: true,
                  enabled: false,
                  onChanged: _onChanged,
                  label: 'Label',
                  description: 'Description',
                  value: 'Value',
                ),
                AppCheckboxField.tristate(
                  checkboxValue: null,
                  enabled: false,
                  onChanged: _onChanged,
                  label: 'Label',
                  description: 'Description',
                  value: 'Value',
                ),
                AppCheckboxField.tristate(
                  checkboxValue: false,
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

      await widgetsMatchGoldens(
        tester,
        'checkbox_field_tristate',
        surface: _surface,
      );
    });
  });
}
