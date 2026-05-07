import 'package:app_design_system/app_design_system.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import '../../test_app.dart';

const _caption = 'Caption';
const _semanticsLabel = 'This is a semantics label';

void _onTap() {}

enum _CaptionLength { short, long }

void main() {
  group('AppRawTextButton', () {
    testGoldens('types', (tester) async {
      final surface = Surface.canvas(width: 500, height: 1000);
      final keys = GlobalKeyGenerator();

      await pumpWidgetBuilder(
        tester,
        AppFreezeInfiniteAnimations(
          child: GoldenTable(
            header: const GoldenTableHeader(
              headerName: 'Variant',
              cellNames: ['Default'],
            ),
            rows: [
              for (final type in AppTextButtonType.values) ...[
                GoldenTableRow(
                  details:
                      'Type: ${type.name}\n'
                      'State: Enabled',
                  cells: [
                    GoldenRow(
                      children: [
                        AppRawTextButton(
                          leadingIcon: AppStandardIcons.plus,
                          trailingIcon: AppStandardIcons.arrowNarrowRight,
                          caption: _caption,
                          type: type,
                          onTap: _onTap,
                        ),
                        AppSpacings.s8.horizontalSpace,
                        AppRawTextButton.icon(
                          icon: AppStandardIcons.plus,
                          semanticsLabel: _semanticsLabel,
                          type: type,
                          onTap: _onTap,
                        ),
                      ],
                    ),
                  ],
                ),
                GoldenTableRow(
                  details:
                      'Type: ${type.name}\n'
                      'State: Pressed',
                  cells: [
                    GoldenRow(
                      children: [
                        AppRawTextButton(
                          key: keys.next(),
                          leadingIcon: AppStandardIcons.plus,
                          trailingIcon: AppStandardIcons.arrowNarrowRight,
                          caption: _caption,
                          type: type,
                          onTap: _onTap,
                        ),
                        AppSpacings.s8.horizontalSpace,
                        AppRawTextButton.icon(
                          key: keys.next(),
                          icon: AppStandardIcons.plus,
                          semanticsLabel: _semanticsLabel,
                          type: type,
                          onTap: _onTap,
                        ),
                      ],
                    ),
                  ],
                ),
                GoldenTableRow(
                  details:
                      'Type: ${type.name}\n'
                      'State: Loading',
                  cells: [
                    GoldenRow(
                      children: [
                        AppRawTextButton(
                          key: keys.next(),
                          leadingIcon: AppStandardIcons.plus,
                          trailingIcon: AppStandardIcons.arrowNarrowRight,
                          caption: _caption,
                          type: type,
                          onTap: _onTap,
                          loading: true,
                        ),
                        AppSpacings.s8.horizontalSpace,
                        AppRawTextButton.icon(
                          key: keys.next(),
                          icon: AppStandardIcons.plus,
                          semanticsLabel: _semanticsLabel,
                          type: type,
                          onTap: _onTap,
                          loading: true,
                        ),
                      ],
                    ),
                  ],
                ),
                GoldenTableRow(
                  details:
                      'Type: ${type.name}\n'
                      'State: Disabled',
                  cells: [
                    GoldenRow(
                      children: [
                        AppRawTextButton(
                          enabled: false,
                          leadingIcon: AppStandardIcons.plus,
                          trailingIcon: AppStandardIcons.arrowNarrowRight,
                          caption: _caption,
                          type: type,
                          onTap: _onTap,
                        ),
                        AppSpacings.s8.horizontalSpace,
                        AppRawTextButton.icon(
                          enabled: false,
                          icon: AppStandardIcons.plus,
                          semanticsLabel: _semanticsLabel,
                          type: type,
                          onTap: _onTap,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
        surface: surface,
      );

      await tester.tapDownAll(keys);

      await tester.pumpAndSettle();

      await widgetsMatchGoldens(tester, 'text_button', surface: surface);
    });

    testGoldens('varied', (tester) async {
      final surface = Surface.canvas(width: 550, height: 750);
      final keys = GlobalKeyGenerator();

      await pumpWidgetBuilder(
        tester,
        AppFreezeInfiniteAnimations(
          child: GoldenTable(
            cellAlignment: GoldenTableCellAlignment.stretch,
            header: const GoldenTableHeader(
              headerName: 'Layout',
              cellNames: ['Shrink'],
            ),
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
                        AppRawTextButton(
                          leadingIcon: leadingIcon,
                          trailingIcon: trailingIcon,
                          caption: switch (captionLength) {
                            _CaptionLength.short => 'Short',
                            _CaptionLength.long =>
                              'Unfathomably long caption so very long',
                          },
                          type: AppTextButtonType.brand,
                          onTap: _onTap,
                        ),
                      ],
                    ),
                  ],
            ],
          ),
        ),
        surface: surface,
      );

      await tester.tapDownAll(keys);

      await tester.pumpAndSettle();

      await widgetsMatchGoldens(tester, 'text_button_varied', surface: surface);
    });
  });
}
