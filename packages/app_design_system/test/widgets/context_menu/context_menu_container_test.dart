import 'package:app_design_system/app_design_system.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import '../../test_app.dart';

void main() {
  group('AppContextMenuContainer', () {
    Widget container = AppContextMenuContainer(
      items: [
        for (final leadingIcon in {AppStandardIcons.atom01, null})
          for (final details in {'Aenean a tellus', null})
            for (final trailingIcon in {AppStandardIcons.check, null})
              for (final parent in {true, false})
                AppContextMenuItem(
                  title: 'Lorem ipsum',
                  onTap: () {},
                  leadingIcon: leadingIcon,
                  details: details,
                  trailingIcon: trailingIcon,
                  parent: parent,
                ),
        for (final details in {
          'Aenean a tellus vel lacus pellentesque',
          'Aenean ',
          null,
        })
          for (final title in {'Lorem ipsum dolor sit amet', 'Lorem ipsum'})
            AppContextMenuItem(
              title: title,
              onTap: () {},
              leadingIcon: AppStandardIcons.atom01,
              details: details,
              trailingIcon: AppStandardIcons.check,
            ),
      ],
    );

    container = Padding(padding: AppSpacings.s16.all, child: container);

    testGoldens('unconstrained', (tester) async {
      final surface = Surface.canvas(height: 2000, width: 400);

      await pumpWidgetBuilder(tester, container, surface: surface);

      await tester.pumpAndSettle();

      await widgetsMatchGoldens(
        tester,
        'context_menu_container_unconstrained',
        surface: surface,
      );
    });

    testGoldens('constrained', (tester) async {
      final surface = Surface.canvas(height: 700, width: 400);

      await pumpWidgetBuilder(
        tester,
        SizedBox.fromSize(size: surface.size, child: container),
        surface: surface,
      );

      await tester.pumpAndSettle();

      await widgetsMatchGoldensSingle(
        tester,
        'context_menu_container_constrained',
        surface: surface,
      );
    });
  });
}
