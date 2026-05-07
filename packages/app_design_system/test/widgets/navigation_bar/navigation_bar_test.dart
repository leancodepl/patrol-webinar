import 'package:app_design_system/app_design_system.dart';
import 'package:collection/collection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import '../../test_app.dart';

final _surface = Surface.canvas(width: 600, height: 550);

void main() {
  group('AppNavigationBar', () {
    testGoldens('4 pages', (tester) async {
      final keys = GlobalKeyGenerator();

      List<AppNavigationBarItem> items({int? pressed, int? badge}) =>
          const [
                AppNavigationBarItem(
                  title: 'Home',
                  icon: AppStandardIcons.home01,
                ),
                AppNavigationBarItem(
                  title: 'Inbox',
                  icon: AppStandardIcons.inbox01,
                ),
                AppNavigationBarItem(
                  title: 'Calls',
                  icon: AppStandardIcons.phoneCall01,
                ),
                AppNavigationBarItem(
                  title: 'Profile',
                  icon: AppStandardIcons.user01,
                ),
              ]
              .mapIndexed(
                (index, item) => AppNavigationBarItem(
                  key: pressed == index ? keys.next() : null,
                  title: item.title,
                  icon: item.icon,
                  badge: badge == index,
                ),
              )
              .toList();

      final controller = AppNavigationBarController(
        initialPage: 1,
        totalPages: 4,
      );

      await pumpWidgetBuilder(
        tester,
        GoldenTable(
          cellFlex: 300,
          cellAlignment: GoldenTableCellAlignment.stretch,
          header: const GoldenTableHeader(
            headerName: 'Variant',
            cellNames: ['Pages: 4'],
          ),
          rows: [
            ...[
              (pressed: null, badge: null),
              (pressed: 3, badge: null),
              (pressed: 0, badge: 0),
              (pressed: 1, badge: 3),
              (pressed: null, badge: 2),
            ].map(
              (row) => GoldenTableRow(
                details:
                    'Current: ${controller.current}\n'
                    'Pressed: ${row.pressed}\n'
                    'Badge: at ${row.badge}',
                cells: [
                  AppNavigationBar(
                    controller: controller,
                    items: items(pressed: row.pressed, badge: row.badge),
                  ),
                ],
              ),
            ),
          ],
        ),
        surface: _surface,
      );

      await tester.tapDownAll(keys);

      await tester.pumpAndSettle();

      await widgetsMatchGoldens(
        tester,
        'navigation_bar_4_pages',
        surface: _surface,
      );
    });

    testGoldens('varied pages', (tester) async {
      final keys = GlobalKeyGenerator();

      List<AppNavigationBarItem> items(int length) => const [
        AppNavigationBarItem(
          title: 'Very long page title',
          icon: AppStandardIcons.home01,
        ),
        AppNavigationBarItem(
          title: 'Another very long page title',
          icon: AppStandardIcons.inbox01,
        ),
        AppNavigationBarItem(
          title: 'Calls',
          icon: AppStandardIcons.phoneCall01,
        ),
        AppNavigationBarItem(title: 'Settings', icon: AppStandardIcons.users01),
        AppNavigationBarItem(title: 'Camera', icon: AppStandardIcons.camera01),
        AppNavigationBarItem(
          title: 'Settings',
          icon: AppStandardIcons.settings01,
        ),
      ].sublist(0, length).toList();

      await pumpWidgetBuilder(
        tester,
        GoldenTable(
          cellFlex: 300,
          cellAlignment: GoldenTableCellAlignment.stretch,
          header: const GoldenTableHeader(
            headerName: 'Variant',
            cellNames: ['Varied pages'],
          ),
          rows: List.generate(6, (index) {
            final length = index + 1;

            return GoldenTableRow(
              details:
                  'Pages: $length\n'
                  'Current: 0',
              cells: [
                AppNavigationBar(
                  controller: AppNavigationBarController(totalPages: length),
                  items: items(length),
                ),
              ],
            );
          }),
        ),
        surface: _surface,
      );

      await tester.tapDownAll(keys);

      await tester.pumpAndSettle();

      await widgetsMatchGoldens(
        tester,
        'navigation_bar_varied_pages',
        surface: _surface,
      );
    });
  });
}
