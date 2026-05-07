import 'package:app_design_system/app_design_system.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_app.dart';

enum _Page { home, search, profile, settings }

void main() {
  group('AppNavigationBarView', () {
    testWidgets('properly stages and offstages children', (tester) async {
      final tappedButtons = <_Page>[];

      final controller = AppNavigationBarController(
        totalPages: _Page.values.length,
      );

      await pumpWidgetBuilder(
        tester,
        AppNavigationBarView(
          pages: [
            ..._Page.values.map(
              (page) => Center(
                child: AppRawButton(
                  caption: page.name,
                  size: AppButtonSize.large,
                  type: AppButtonType.primary,
                  onTap: () => tappedButtons.add(page),
                ),
              ),
            ),
          ],
          controller: controller,
        ),
      );

      controller.changePage(_Page.home.index);
      await tester.pumpAndSettle();
      await tester.tap(find.text(_Page.home.name));
      await tester.pumpAndSettle();
      expect(tappedButtons, [_Page.home]);

      controller.changePage(_Page.search.index);
      await tester.pumpAndSettle();
      await tester.tap(find.text(_Page.search.name));
      await tester.pumpAndSettle();
      expect(tappedButtons, [_Page.home, _Page.search]);

      controller.changePage(_Page.profile.index);
      await tester.pumpAndSettle();
      await tester.tap(find.text(_Page.profile.name));
      await tester.pumpAndSettle();
      expect(tappedButtons, [_Page.home, _Page.search, _Page.profile]);

      controller.changePage(_Page.settings.index);
      await tester.pumpAndSettle();
      await tester.tap(find.text(_Page.settings.name));
      await tester.pumpAndSettle();
      expect(tappedButtons, [
        _Page.home,
        _Page.search,
        _Page.profile,
        _Page.settings,
      ]);

      controller.changePage(_Page.home.index);
      await tester.pumpAndSettle();
      await tester.tap(find.text(_Page.home.name));
      await tester.pumpAndSettle();
      expect(tappedButtons, [
        _Page.home,
        _Page.search,
        _Page.profile,
        _Page.settings,
        _Page.home,
      ]);

      controller.changePage(_Page.profile.index);
      await tester.pumpAndSettle();
      await tester.tap(find.text(_Page.profile.name));
      await tester.pumpAndSettle();
      expect(tappedButtons, [
        _Page.home,
        _Page.search,
        _Page.profile,
        _Page.settings,
        _Page.home,
        _Page.profile,
      ]);
    });
  });
}
