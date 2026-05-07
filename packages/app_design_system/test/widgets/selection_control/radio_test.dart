import 'package:app_design_system/app_design_system.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import '../../test_app.dart';

final _surface = Surface.canvas(width: 600, height: 500);

void _onChanged(bool _) {}

void main() {
  testGoldens('AppRadio', (tester) async {
    final keys = GlobalKeyGenerator();

    await pumpWidgetBuilder(
      tester,
      GoldenTable(
        header: const GoldenTableHeader(
          headerName: 'Group value',
          cellNames: ['True', 'False'],
        ),
        rows: [
          const GoldenTableRow(
            details:
                'State: Enabled\n'
                'Danger: false',
            cells: [
              AppRadio(groupValue: true, onChanged: _onChanged, value: true),
              AppRadio(groupValue: false, onChanged: _onChanged, value: true),
            ],
          ),
          GoldenTableRow(
            details:
                'State: Pressed\n'
                'Danger: false',
            cells: [
              AppRadio(
                key: keys.next(),
                groupValue: true,
                onChanged: _onChanged,
                value: true,
              ),
              AppRadio(
                key: keys.next(),
                groupValue: false,
                onChanged: _onChanged,
                value: true,
              ),
            ],
          ),
          const GoldenTableRow(
            details:
                'State: Disabled\n'
                'Danger: false',
            cells: [
              AppRadio(
                enabled: false,
                groupValue: true,
                onChanged: _onChanged,
                value: true,
              ),
              AppRadio(
                enabled: false,
                groupValue: false,
                onChanged: _onChanged,
                value: true,
              ),
            ],
          ),
          const GoldenTableRow(
            details:
                'State: Enabled\n'
                'Danger: true',
            cells: [
              AppRadio(
                groupValue: true,
                danger: true,
                onChanged: _onChanged,
                value: true,
              ),
              AppRadio(
                groupValue: false,
                danger: true,
                onChanged: _onChanged,
                value: true,
              ),
            ],
          ),
          GoldenTableRow(
            details:
                'State: Pressed\n'
                'Danger: true',
            cells: [
              AppRadio(
                key: keys.next(),
                groupValue: true,
                danger: true,
                onChanged: _onChanged,
                value: true,
              ),
              AppRadio(
                key: keys.next(),
                groupValue: false,
                danger: true,
                onChanged: _onChanged,
                value: true,
              ),
            ],
          ),
          const GoldenTableRow(
            details:
                'State: Disabled\n'
                'Danger: true',
            cells: [
              AppRadio(
                enabled: false,
                groupValue: true,
                danger: true,
                onChanged: _onChanged,
                value: true,
              ),
              AppRadio(
                enabled: false,
                groupValue: false,
                danger: true,
                onChanged: _onChanged,
                value: true,
              ),
            ],
          ),
        ],
      ),
      surface: _surface,
    );

    await tester.tapDownAll(keys);

    await tester.pumpAndSettle();

    await widgetsMatchGoldensSingle(tester, 'radio', surface: _surface);
  });
}
