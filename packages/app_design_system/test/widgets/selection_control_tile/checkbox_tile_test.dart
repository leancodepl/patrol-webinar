import 'package:app_design_system/src/widgets/selection_control_tile/checkbox_tile.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import '../../test_app.dart';
import 'common.dart';

void main() {
  group('AppCheckboxTile', () {
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
                    SelectionControlType.checkbox,
                    false,
                    scenario.pressed ? keys.next() : null,
                  ),
                  getWidgetFromScenario(
                    scenario,
                    SelectionControlType.checkbox,
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

      await widgetsMatchGoldens(tester, 'checkbox_tile', surface: surface);
    });

    group('onChanged', () {
      testWidgets('is called with true when unselected tapped', (tester) async {
        var selected = true;
        const label = 'label';
        await tester.pumpWidget(
          TestApp(
            child: Center(
              child: AppCheckboxTile(
                onChanged: (newValue) {
                  selected = newValue;
                },
                label: label,
                selected: selected,
              ),
            ),
          ),
        );

        final tileFinder = find.byType(AppCheckboxTile);
        await tester.tap(tileFinder);
        await tester.pumpAndSettle();

        expect(selected, false);
      });

      testWidgets('is called with false when selected tapped', (tester) async {
        var selected = false;
        const label = 'label';
        await tester.pumpWidget(
          TestApp(
            child: Center(
              child: AppCheckboxTile(
                onChanged: (newValue) {
                  selected = newValue;
                },
                label: label,
                selected: selected,
              ),
            ),
          ),
        );

        final tileFinder = find.byType(AppCheckboxTile);
        await tester.tap(tileFinder);
        await tester.pumpAndSettle();

        expect(selected, true);
      });
    });
  });
}
