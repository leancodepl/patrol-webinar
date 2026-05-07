import 'package:app_design_system/app_design_system.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import '../../test_app.dart';

final _surface = Surface.canvas(width: 200, height: 150);

void main() {
  testGoldens('AppSpinner', (tester) async {
    final keys = GlobalKeyGenerator();

    await pumpWidgetBuilder(
      tester,
      const AppFreezeInfiniteAnimations(
        child: GoldenTable(
          header: GoldenTableHeader(
            headerName: 'Type',
            cellNames: ['Gradient'],
          ),
          rows: [
            GoldenTableRow(details: 'Start', cells: [AppSpinner()]),
          ],
        ),
      ),
      surface: _surface,
    );

    await tester.tapDownAll(keys);

    await tester.pumpAndSettle();

    await widgetsMatchGoldensSingle(tester, 'spinner', surface: _surface);
  });
}
