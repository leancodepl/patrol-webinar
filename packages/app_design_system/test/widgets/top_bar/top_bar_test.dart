import 'package:app_design_system/app_design_system.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import '../../golden_builder.dart';
import '../../test_app.dart';

final _topBarTemplate = AppTopBar(
  title: 'Title',
  subtitle: 'Subtitle',
  leading: AppTopBarAction(
    caption: 'Leading',
    onTap: () {},
    icon: AppStandardIcons.chevronLeft,
  ),
  actions: [
    AppTopBarAction(persistent: true, caption: 'Edit', onTap: () {}),
    AppTopBarAction.icon(
      persistent: true,
      icon: AppStandardIcons.alarmClock,
      semanticsLabel: 'Icon',
      onTap: () {},
    ),
    AppTopBarAction(
      type: AppTopBarActionType.idle,
      icon: AppStandardIcons.searchMd,
      caption: 'Search',
      semanticsLabel: 'Icon',
      onTap: () {},
    ),
    AppTopBarAction(
      type: AppTopBarActionType.idle,
      persistent: true,
      icon: AppStandardIcons.save01,
      caption: 'Save',
      onTap: () {},
    ),
  ],
  menuActions: [AppTopBarAction(caption: 'Menu action', onTap: () {})],
);

void main() {
  group('AppTopBar', () {
    testGoldens('simple', (tester) async {
      final surface = Surface.canvas(width: 600, height: 400);

      final builder =
          AppGoldenBuilder.column(name: 'AppTopBar (with all elements)')
            ..addScenario(
              'Title centered',
              AppTopBar(
                title: _topBarTemplate.title,
                subtitle: _topBarTemplate.subtitle,
                leading: _topBarTemplate.leading,
                actions: _topBarTemplate.actions,
                menuActions: _topBarTemplate.menuActions,
              ),
            )
            ..addScenario(
              'Title uncentered',
              AppTopBar(
                title: _topBarTemplate.title,
                subtitle: _topBarTemplate.subtitle,
                leading: _topBarTemplate.leading,
                actions: _topBarTemplate.actions,
                menuActions: _topBarTemplate.menuActions,
                centerTitle: false,
              ),
            );

      await pumpWidgetBuilder(tester, builder.build(), surface: surface);

      await tester.pumpAndSettle();

      await widgetsMatchGoldens(tester, 'top_bar_simple', surface: surface);
    });

    testGoldens('layout', (tester) async {
      final surface = Surface.canvas(width: 700, height: 1400);
      final keys = GlobalKeyGenerator();

      // Mark render boxes position and size visually so that we can test
      // AppTopBar layout more precisely.
      debugPaintSizeEnabled = true;

      final builder = AppGoldenBuilder.column(name: 'AppTopBar (layout)')
        ..addScenario(
          'Centered title',
          AppTopBar(
            title: _topBarTemplate.title,
            subtitle: _topBarTemplate.subtitle,
            leading: _topBarTemplate.leading,
            actions: _topBarTemplate.actions,
          ),
        )
        ..addScenario(
          'Non-centered title',
          AppTopBar(
            title: _topBarTemplate.title,
            subtitle: _topBarTemplate.subtitle,
            leading: _topBarTemplate.leading,
            actions: _topBarTemplate.actions,
            centerTitle: false,
          ),
        )
        ..addScenario(
          'No subtitle',
          AppTopBar(
            title: _topBarTemplate.title,
            leading: _topBarTemplate.leading,
            actions: _topBarTemplate.actions,
          ),
        )
        ..addScenario(
          'Long subtitle with 2 max lines',
          AppTopBar(
            title: _topBarTemplate.title,
            subtitle:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit'
                ' sed do eiusmod tempor incididunt ut labore et dolore magna',
            leading: _topBarTemplate.leading,
            actions: _topBarTemplate.actions,
            centerTitle: false,
          ),
        )
        ..addScenario(
          'Long subtitle with 2 max lines centered',
          AppTopBar(
            title: _topBarTemplate.title,
            subtitle:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit'
                ' sed do eiusmod tempor incididunt ut labore et dolore magna',
            leading: _topBarTemplate.leading,
            actions: _topBarTemplate.actions,
          ),
        )
        ..addScenario(
          'Without leading and with non-centered title',
          AppTopBar(
            title: _topBarTemplate.title,
            subtitle: _topBarTemplate.subtitle,
            actions: _topBarTemplate.actions,
            centerTitle: false,
            automaticallyImplyLeading: false,
          ),
        )
        ..addScenario(
          'Title hides one non-persistent action which makes menu actions visible',
          AppTopBar(
            title: 'Long title hides one action',
            subtitle: _topBarTemplate.subtitle,
            leading: _topBarTemplate.leading,
            actions: _topBarTemplate.actions,
          ),
        )
        ..addScenario(
          'Title constrained by persistent actions',
          AppTopBar(
            title: 'Long title constrained by persistent actions',
            subtitle: _topBarTemplate.subtitle,
            leading: _topBarTemplate.leading,
            actions: _topBarTemplate.actions,
          ),
        )
        ..addScenario(
          'Non-centered title constrained by leading and persistent actions',
          AppTopBar(
            title:
                'Long title that is constrained by both leading and'
                ' persistent actions',
            subtitle: _topBarTemplate.subtitle,
            leading: _topBarTemplate.leading,
            actions: _topBarTemplate.actions,
            centerTitle: false,
          ),
        )
        ..addScenario(
          'Just title',
          const AppTopBar(title: 'Only title visible here'),
        );

      await pumpWidgetBuilder(tester, builder.build(), surface: surface);

      await tester.tapDownAll(keys);

      await tester.pumpAndSettle();

      await widgetsMatchGoldensSingle(
        tester,
        'top_bar_layout',
        surface: surface,
      );

      debugPaintSizeEnabled = false;
    });

    testWidgets('intrinsics', (tester) async {
      debugPaintSizeEnabled = true;

      await tester.pumpWidgetBuilder(
        SizedBox.fromSize(
          child: TestApp(
            child: AppTopBar(
              title: _topBarTemplate.title,
              subtitle: _topBarTemplate.subtitle,
              leading: _topBarTemplate.leading,
              actions: _topBarTemplate.actions,
              menuActions: _topBarTemplate.menuActions,
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      debugPaintSizeEnabled = false;
    });
  });
}
