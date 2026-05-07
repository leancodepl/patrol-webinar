import 'package:app_design_system/src/widgets/selection_control_tile/radio_tile.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import '../../test_app.dart';
import 'common.dart';

void main() {
  group('AppRadioTile', () {
    testGoldens('default', (tester) async {
      final keys = GlobalKeyGenerator();

      final surface = Surface.canvas(width: 1200, height: 2400);
      await pumpWidgetBuilder(
        tester,
        GoldenTable(
          header: const GoldenTableHeader(
            headerName: 'Selected',
            cellNames: ['False', 'True'],
          ),
          rows: [
            for (final scenario in SelectionControlScenario.getScenarios()) ...[
              GoldenTableRow(
                details: scenario.name,
                cells: [
                  getWidgetFromScenario(
                    scenario,
                    SelectionControlType.radio,
                    false,
                    scenario.pressed ? keys.next() : null,
                  ),
                  getWidgetFromScenario(
                    scenario,
                    SelectionControlType.radio,
                    true,
                    scenario.pressed ? keys.next() : null,
                  ),
                ],
              ),
            ],
          ],
        ),
        surface: surface,
      );

      await tester.tapDownAll(keys);

      await tester.pumpAndSettle();

      await widgetsMatchGoldens(tester, 'radio_tile', surface: surface);
    });

    testWidgets('calls onChanged when tapped', (tester) async {
      const radioValue = false;
      var radioGroupValue = true;

      await tester.pumpWidget(
        TestApp(
          child: Center(
            child: AppRadioTile(
              onChanged: (newValue) {
                radioGroupValue = newValue;
              },
              label: 'label',
              radioValue: radioValue,
              radioGroupValue: radioGroupValue,
            ),
          ),
        ),
      );

      final tileFinder = find.byType(AppRadioTile<bool>);
      await tester.tap(tileFinder);
      await tester.pumpAndSettle();

      expect(radioGroupValue, false);
    });

    testWidgets('Correctly passes the changed value (to true) to callback', (
      tester,
    ) async {
      const radioValue = true;
      var radioGroupValue = false;
      const label = 'label';
      await tester.pumpWidget(
        TestApp(
          child: Center(
            child: AppRadioTile(
              onChanged: (newValue) {
                radioGroupValue = newValue;
              },
              label: label,
              radioValue: radioValue,
              radioGroupValue: radioGroupValue,
            ),
          ),
        ),
      );

      final tileFinder = find.byType(AppRadioTile<bool>);
      await tester.tap(tileFinder);
      await tester.pumpAndSettle();

      expect(radioGroupValue, true);
    });
  });
}
