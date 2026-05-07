import 'package:app_design_system/app_design_system.dart';
import 'package:flutter/widgets.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import '../../test_app.dart';

final _surface = Surface.canvas(width: 200, height: 150);

void main() {
  testGoldens('AppIconSpinner', (tester) async {
    final keys = GlobalKeyGenerator();

    await pumpWidgetBuilder(
      tester,
      AppFreezeInfiniteAnimations(
        child: GoldenTable(
          header: const GoldenTableHeader(
            headerName: 'Type',
            cellNames: ['Default'],
          ),
          rows: [
            GoldenTableRow(
              details: 'Start',
              cells: [
                Builder(
                  builder: (context) => AppIconSpinner(
                    color: context.colors.foregroundActivePrimary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      surface: _surface,
    );

    await tester.tapDownAll(keys);

    await tester.pumpAndSettle();

    await widgetsMatchGoldensSingle(tester, 'icon_spinner', surface: _surface);
  });
}
