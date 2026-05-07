import 'package:app_design_system/app_design_system.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import '../../test_app.dart';

final _surface = Surface.canvas(width: 600, height: 500);

void _onChanged<T>(T _) {}

void main() {
  testGoldens('AppToggle', (tester) async {
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
              AppToggle(value: true, onChanged: _onChanged),
              AppToggle(value: false, onChanged: _onChanged),
            ],
          ),
          GoldenTableRow(
            details:
                'State: Pressed\n'
                'Danger: false',
            cells: [
              AppToggle(key: keys.next(), value: true, onChanged: _onChanged),
              AppToggle(key: keys.next(), value: false, onChanged: _onChanged),
            ],
          ),
          const GoldenTableRow(
            details:
                'State: Disabled\n'
                'Danger: false',
            cells: [
              AppToggle(enabled: false, value: true, onChanged: _onChanged),
              AppToggle(enabled: false, value: false, onChanged: _onChanged),
            ],
          ),
          const GoldenTableRow(
            details:
                'State: Enabled\n'
                'Danger: true',
            cells: [
              AppToggle(value: true, danger: true, onChanged: _onChanged),
              AppToggle(value: false, danger: true, onChanged: _onChanged),
            ],
          ),
          GoldenTableRow(
            details:
                'State: Pressed\n'
                'Danger: true',
            cells: [
              AppToggle(
                key: keys.next(),
                value: true,
                danger: true,
                onChanged: _onChanged,
              ),
              AppToggle(
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
              AppToggle(
                enabled: false,
                value: true,
                danger: true,
                onChanged: _onChanged,
              ),
              AppToggle(
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

    await widgetsMatchGoldensRtl(tester, 'toggle', surface: _surface);
  });
}
