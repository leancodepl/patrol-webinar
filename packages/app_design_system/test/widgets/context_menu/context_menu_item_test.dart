import 'package:app_design_system/app_design_system.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import '../../test_app.dart';

void main() {
  group('AppContextMenuItem', () {
    testGoldens('states', (tester) async {
      final surface = Surface.canvas(height: 300, width: 500);

      final keys = GlobalKeyGenerator();

      await pumpWidgetBuilder(
        tester,
        GoldenTable(
          cellFlex: 300,
          cellAlignment: GoldenTableCellAlignment.stretch,
          header: const GoldenTableHeader(
            headerName: 'Type',
            cellNames: ['Default'],
          ),
          rows: [
            GoldenTableRow(
              details: 'Enabled',
              cells: [
                AppContextMenuItem(
                  title: 'Title text',
                  onTap: () {},
                  leadingIcon: AppStandardIcons.atom01,
                  details: 'Details',
                  trailingIcon: AppStandardIcons.check,
                  parent: true,
                ),
              ],
            ),
            GoldenTableRow(
              details: 'Pressed',
              cells: [
                AppContextMenuItem(
                  key: keys.next(),
                  title: 'Title text',
                  onTap: () {},
                  leadingIcon: AppStandardIcons.atom01,
                  details: 'Details',
                  trailingIcon: AppStandardIcons.check,
                  parent: true,
                ),
              ],
            ),
            GoldenTableRow(
              details: 'Disabled',
              cells: [
                AppContextMenuItem(
                  title: 'Title text',
                  onTap: () {},
                  leadingIcon: AppStandardIcons.atom01,
                  details: 'Details',
                  trailingIcon: AppStandardIcons.check,
                  parent: true,
                  enabled: false,
                ),
              ],
            ),
          ],
        ),
        surface: surface,
      );

      await tester.tapDownAll(keys);

      await tester.pumpAndSettle();

      await widgetsMatchGoldens(
        tester,
        'context_menu_item_states',
        surface: surface,
      );
    });

    testGoldens('varied', (tester) async {
      final surface = Surface.canvas(height: 1500, width: 600);

      final keys = GlobalKeyGenerator();

      await pumpWidgetBuilder(
        tester,
        GoldenTable(
          cellAlignment: GoldenTableCellAlignment.stretch,
          header: const GoldenTableHeader(
            headerName: 'Type',
            cellNames: ['Default'],
          ),
          rows: [
            for (final leadingIcon in {AppStandardIcons.atom01, null})
              for (final details in {'Details', null})
                for (final trailingIcon in {AppStandardIcons.check, null})
                  for (final parent in {true, false})
                    GoldenTableRow(
                      details:
                          'Elements: '
                                  '${leadingIcon != null ? 'leading icon, ' : ''}'
                                  'title, '
                                  '${details != null ? 'details, ' : ''}'
                                  '${trailingIcon != null ? 'trailing icon, ' : ''}'
                                  '${parent ? 'parent, ' : ''}'
                                  '.'
                              .replaceAll(', .', '.'),
                      cells: [
                        AppContextMenuItem(
                          title: 'Title text',
                          onTap: () {},
                          leadingIcon: leadingIcon,
                          details: details,
                          trailingIcon: trailingIcon,
                          parent: parent,
                        ),
                      ],
                    ),
            for (final title in {
              'Lorem',
              'Lorem ipsum dolor sit amet, consectetur adipiscing',
            })
              for (final details in {
                'Aliquam',
                'Aliquam hendrerit ante nec felis pretium, vitae vulputate',
              })
                GoldenTableRow(
                  details:
                      'Elements: '
                      '${title.length > 10 ? 'long' : 'short'} title, '
                      '${details.length > 10 ? 'long' : 'short'} details.',
                  cells: [
                    AppContextMenuItem(
                      title: title,
                      details: details,
                      onTap: () {},
                    ),
                  ],
                ),
          ],
        ),
        surface: surface,
      );

      await tester.tapDownAll(keys);

      await tester.pumpAndSettle();

      await widgetsMatchGoldensSingle(
        tester,
        'context_menu_item_varied',
        surface: surface,
      );
    });
  });
}
