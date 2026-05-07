import 'package:app_design_system/app_design_system.dart';
import 'package:change_case/change_case.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import '../../test_app.dart';

final _surface = Surface.canvas(height: 530, width: 300);

void main() {
  group('AppContextMenu', () {
    final cases = [
      (name: 'preffered', alignment: const Alignment(0, -0.8)),
      (name: 'preffered_wrapped', alignment: const Alignment(0, -0.05)),
      (name: 'opposite', alignment: const Alignment(0, 0.5)),
      (name: 'opposite_wrapped', alignment: const Alignment(0, 0.10)),
      (name: 'shifted', alignment: const Alignment(0, 1.30)),
    ];

    for (final c in cases) {
      testGoldens(c.name.toSentenceCase(), (tester) async {
        final keys = GlobalKeyGenerator();

        await pumpWidgetBuilder(
          tester,
          SizedBox(
            width: _surface.size.width,
            height: _surface.size.height,
            child: GoldenScreen(
              alignment: c.alignment,
              child: AppContextMenu(
                anchor: const AppContextMenuAnchor(
                  target: AlignmentDirectional.bottomEnd,
                  menu: AlignmentDirectional.topEnd,
                ),
                controller: AppContextMenuController(initiallyVisible: true),
                items: [
                  for (var i = 0; i < 6; i++)
                    AppContextMenuItem(
                      leadingIcon: AppStandardIcons.atom01,
                      title: 'Lorem ipsum',
                      onTap: () {},
                    ),
                ],
                child: const SizedBox(
                  width: 100,
                  height: 50,
                  child: Placeholder(),
                ),
              ),
            ),
          ),
          surface: _surface,
        );

        await tester.tapDownAll(keys);

        await tester.pumpAndSettle();

        await widgetsMatchGoldensSingle(
          tester,
          'context_menu_alignment_${c.name}',
          surface: _surface,
        );
      });
    }

    final titles = ['Lorem', 'Lorem ipsum', 'Lorem ipsum dolor sit amet'];

    for (final title in titles) {
      testGoldens('title length ${title.length}', (tester) async {
        final keys = GlobalKeyGenerator();

        await pumpWidgetBuilder(
          tester,
          SizedBox(
            width: _surface.size.width,
            height: _surface.size.height,
            child: GoldenScreen(
              alignment: Alignment.center,
              child: AppContextMenu(
                anchor: const AppContextMenuAnchor(
                  target: AlignmentDirectional.bottomEnd,
                  menu: AlignmentDirectional.topEnd,
                ),
                controller: AppContextMenuController(initiallyVisible: true),
                items: [
                  for (var i = 0; i < 6; i++)
                    AppContextMenuItem(title: title, onTap: () {}),
                ],
                child: const SizedBox(
                  width: 100,
                  height: 50,
                  child: Placeholder(),
                ),
              ),
            ),
          ),
          surface: _surface,
        );

        await tester.tapDownAll(keys);

        await tester.pumpAndSettle();

        await widgetsMatchGoldensSingle(
          tester,
          'context_menu_width_title_length_${title.length}',
          surface: _surface,
        );
      });
    }
  });
}
