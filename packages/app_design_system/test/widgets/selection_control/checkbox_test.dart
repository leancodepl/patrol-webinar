import 'package:app_design_system/app_design_system.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import '../../test_app.dart';

final _surface = Surface.canvas(width: 600, height: 500);

void _onChanged<T>(T _) {}

void main() {
  group('AppRawCheckbox', () {
    testGoldens('default', (tester) async {
      final keys = GlobalKeyGenerator();

      await pumpWidgetBuilder(
        tester,
        GoldenTable(
          header: const GoldenTableHeader(
            headerName: 'State',
            cellNames: ['Checked', 'Unchecked'],
          ),
          rows: [
            const GoldenTableRow(
              details:
                  'State: Enabled\n'
                  'Danger: false',
              cells: [
                AppRawCheckbox(value: true, onChanged: _onChanged),
                AppRawCheckbox(value: false, onChanged: _onChanged),
              ],
            ),
            GoldenTableRow(
              details:
                  'State: Pressed\n'
                  'Danger: false',
              cells: [
                AppRawCheckbox(
                  key: keys.next(),
                  value: true,
                  onChanged: _onChanged,
                ),
                AppRawCheckbox(
                  key: keys.next(),
                  value: false,
                  onChanged: _onChanged,
                ),
              ],
            ),
            const GoldenTableRow(
              details:
                  'State: Disabled\n'
                  'Danger: false',
              cells: [
                AppRawCheckbox(
                  enabled: false,
                  value: true,
                  onChanged: _onChanged,
                ),
                AppRawCheckbox(
                  enabled: false,
                  value: false,
                  onChanged: _onChanged,
                ),
              ],
            ),
            const GoldenTableRow(
              details:
                  'State: Enabled\n'
                  'Danger: true',
              cells: [
                AppRawCheckbox(
                  value: true,
                  danger: true,
                  onChanged: _onChanged,
                ),
                AppRawCheckbox(
                  value: false,
                  danger: true,
                  onChanged: _onChanged,
                ),
              ],
            ),
            GoldenTableRow(
              details:
                  'State: Pressed\n'
                  'Danger: true',
              cells: [
                AppRawCheckbox(
                  key: keys.next(),
                  value: true,
                  danger: true,
                  onChanged: _onChanged,
                ),
                AppRawCheckbox(
                  key: keys.next(),
                  value: false,
                  danger: true,
                  onChanged: _onChanged,
                ),
              ],
            ),
            const GoldenTableRow(
              details:
                  'State: Disabled\n'
                  'Danger: true',
              cells: [
                AppRawCheckbox(
                  enabled: false,
                  value: true,
                  danger: true,
                  onChanged: _onChanged,
                ),
                AppRawCheckbox(
                  enabled: false,
                  value: false,
                  danger: true,
                  onChanged: _onChanged,
                ),
              ],
            ),
          ],
        ),
        surface: _surface,
      );

      await tester.tapDownAll(keys);

      await tester.pumpAndSettle();

      await widgetsMatchGoldensSingle(tester, 'checkbox', surface: _surface);
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
          rows: [
            const GoldenTableRow(
              details:
                  'State: Enabled\n'
                  'Danger: false',
              cells: [
                AppRawCheckbox.tristate(value: true, onChanged: _onChanged),
                AppRawCheckbox.tristate(value: null, onChanged: _onChanged),
                AppRawCheckbox.tristate(value: false, onChanged: _onChanged),
              ],
            ),
            GoldenTableRow(
              details:
                  'State: Pressed\n'
                  'Danger: false',
              cells: [
                AppRawCheckbox.tristate(
                  key: keys.next(),
                  value: true,
                  onChanged: _onChanged,
                ),
                AppRawCheckbox.tristate(
                  key: keys.next(),
                  value: null,
                  onChanged: _onChanged,
                ),
                AppRawCheckbox.tristate(
                  key: keys.next(),
                  value: false,
                  onChanged: _onChanged,
                ),
              ],
            ),
            const GoldenTableRow(
              details:
                  'State: Disabled\n'
                  'Danger: false',
              cells: [
                AppRawCheckbox.tristate(
                  enabled: false,
                  value: true,
                  onChanged: _onChanged,
                ),
                AppRawCheckbox.tristate(
                  enabled: false,
                  value: null,
                  onChanged: _onChanged,
                ),
                AppRawCheckbox.tristate(
                  enabled: false,
                  value: false,
                  onChanged: _onChanged,
                ),
              ],
            ),
            const GoldenTableRow(
              details:
                  'State: Enabled\n'
                  'Danger: true',
              cells: [
                AppRawCheckbox.tristate(
                  value: true,
                  danger: true,
                  onChanged: _onChanged,
                ),
                AppRawCheckbox.tristate(
                  value: null,
                  danger: true,
                  onChanged: _onChanged,
                ),
                AppRawCheckbox.tristate(
                  value: false,
                  danger: true,
                  onChanged: _onChanged,
                ),
              ],
            ),
            GoldenTableRow(
              details:
                  'State: Pressed\n'
                  'Danger: true',
              cells: [
                AppRawCheckbox.tristate(
                  key: keys.next(),
                  value: true,
                  danger: true,
                  onChanged: _onChanged,
                ),
                AppRawCheckbox.tristate(
                  key: keys.next(),
                  value: null,
                  danger: true,
                  onChanged: _onChanged,
                ),
                AppRawCheckbox.tristate(
                  key: keys.next(),
                  value: false,
                  danger: true,
                  onChanged: _onChanged,
                ),
              ],
            ),
            const GoldenTableRow(
              details:
                  'State: Pressed\n'
                  'Danger: true',
              cells: [
                AppRawCheckbox.tristate(
                  enabled: false,
                  value: true,
                  danger: true,
                  onChanged: _onChanged,
                ),
                AppRawCheckbox.tristate(
                  enabled: false,
                  value: null,
                  danger: true,
                  onChanged: _onChanged,
                ),
                AppRawCheckbox.tristate(
                  enabled: false,
                  value: false,
                  danger: true,
                  onChanged: _onChanged,
                ),
              ],
            ),
          ],
        ),
        surface: _surface,
      );

      await tester.tapDownAll(keys);

      await tester.pumpAndSettle();

      await widgetsMatchGoldensSingle(
        tester,
        'checkbox_tristate',
        surface: _surface,
      );
    });
  });
}
