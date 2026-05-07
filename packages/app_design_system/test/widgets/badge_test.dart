import 'package:app_design_system/app_design_system.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import '../test_app.dart';

enum _CaptionLength { short, long }

void main() {
  group('AppBadge', () {
    testGoldens('types', (tester) async {
      final surface = Surface.canvas(width: 400, height: 250);
      final keys = GlobalKeyGenerator();

      await pumpWidgetBuilder(
        tester,
        GoldenTable(
          header: const GoldenTableHeader(
            headerName: 'Variant',
            cellNames: ['Default'],
          ),
          rows: [
            for (final type in AppBadgeType.values) ...[
              GoldenTableRow(
                details: 'Type: ${type.name}',
                cells: [
                  AppBadge(
                    leadingIcon: AppStandardIcons.arrowNarrowUp,
                    caption: 'Lorem ipsum',
                    trailingIcon: AppStandardIcons.arrowNarrowRight,
                    type: type,
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

      await widgetsMatchGoldens(tester, 'badge', surface: surface);
    });

    testGoldens('varied', (tester) async {
      final surface = Surface.canvas(width: 550, height: 750);
      final keys = GlobalKeyGenerator();

      await pumpWidgetBuilder(
        tester,
        GoldenTable(
          cellAlignment: GoldenTableCellAlignment.stretch,
          header: const GoldenTableHeader(
            headerName: 'Layout',
            cellNames: ['Fit'],
          ),
          cellWrapper: (context, child) =>
              Align(alignment: AlignmentDirectional.centerStart, child: child),
          rows: [
            for (final captionLength in _CaptionLength.values)
              for (final leadingIcon in [AppStandardIcons.plus, null])
                for (final trailingIcon in [AppStandardIcons.x, null]) ...[
                  GoldenTableRow(
                    details:
                        'Leading icon: ${leadingIcon?.name}\n'
                        'Caption: ${captionLength.name}\n'
                        'Trailing icon: ${trailingIcon?.name}',
                    cells: [
                      AppBadge(
                        leadingIcon: leadingIcon,
                        trailingIcon: trailingIcon,
                        caption: switch (captionLength) {
                          _CaptionLength.short => 'Lorem ipsum',
                          _CaptionLength.long =>
                            'Lorem ipsum dolor sit amet, consectetur',
                        },
                        type: AppBadgeType.success,
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

      await widgetsMatchGoldens(tester, 'badge_varied', surface: surface);
    });
  });
}
