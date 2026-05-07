import 'package:app_design_system/app_design_system.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import '../../golden_builder.dart';
import '../../test_app.dart';

void main() {
  group('AppPaginationDots', () {
    testGoldens('simple', (tester) async {
      final surface = Surface.canvas(width: 450, height: 350);
      final builder =
          AppGoldenBuilder.grid(name: 'AppPaginationDots', columns: 5)
            ..addScenario('0/1', const AppPaginationDots(pages: 1, current: 0))
            ..nextRow()
            ..addScenario('0/2', const AppPaginationDots(pages: 2, current: 0))
            ..addScenario('1/2', const AppPaginationDots(pages: 2, current: 1))
            ..nextRow()
            ..addScenario('0/3', const AppPaginationDots(pages: 3, current: 0))
            ..addScenario('1/3', const AppPaginationDots(pages: 3, current: 1))
            ..addScenario('2/3', const AppPaginationDots(pages: 3, current: 2))
            ..nextRow()
            ..addScenario('0/4', const AppPaginationDots(pages: 4, current: 0))
            ..addScenario('1/4', const AppPaginationDots(pages: 4, current: 1))
            ..addScenario('2/4', const AppPaginationDots(pages: 4, current: 2))
            ..addScenario('3/4', const AppPaginationDots(pages: 4, current: 3))
            ..nextRow()
            ..addScenario('0/5', const AppPaginationDots(pages: 5, current: 0))
            ..addScenario('1/5', const AppPaginationDots(pages: 5, current: 1))
            ..addScenario('2/5', const AppPaginationDots(pages: 5, current: 2))
            ..addScenario('3/5', const AppPaginationDots(pages: 5, current: 3))
            ..addScenario('4/5', const AppPaginationDots(pages: 5, current: 4));

      await pumpWidgetBuilder(tester, builder.build(), surface: surface);

      await tester.pumpAndSettle();

      await widgetsMatchGoldens(tester, 'pagination_dots', surface: surface);
    });
  });
}
