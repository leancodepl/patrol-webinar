import 'package:app_design_system/app_design_system.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import '../../test_app.dart';

const _caption = 'Caption';
const _semanticsLabel = 'This is a semantics label';

void _onTap() {}

enum _CaptionLength { short, long }

void main() {
  group('AppRawButton', () {
    testGoldens('types', (tester) async {
      final surface = Surface.canvas(width: 750, height: 2000);
      final keys = GlobalKeyGenerator();

      await pumpWidgetBuilder(
        tester,
        AppFreezeInfiniteAnimations(
          child: GoldenTable(
            cellAlignment: GoldenTableCellAlignment.stretch,
            header: const GoldenTableHeader(
              headerName: 'Size',
              cellNames: ['Medium', 'Large'],
            ),
            rows: [
              for (final type in AppButtonType.values) ...[
                GoldenTableRow(
                  details:
                      'Type: ${type.name}\n'
                      'State: Enabled',
                  cells: [
                    for (final size in AppButtonSize.values) ...[
                      GoldenRow(
                        children: [
                          Flexible(
                            child: AppRawButton(
                              leadingIcon: AppStandardIcons.plus,
                              trailingIcon: AppStandardIcons.arrowNarrowRight,
                              caption: _caption,
                              size: size,
                              type: type,
                              onTap: _onTap,
                            ),
                          ),
                          AppSpacings.s8.horizontalSpace,
                          AppRawButton.icon(
                            icon: AppStandardIcons.plus,
                            semanticsLabel: _semanticsLabel,
                            size: size,
                            type: type,
                            onTap: _onTap,
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
                GoldenTableRow(
                  details:
                      'Type: ${type.name}\n'
                      'State: Pressed',
                  cells: [
                    for (final size in AppButtonSize.values) ...[
                      GoldenRow(
                        children: [
                          Flexible(
                            child: AppRawButton(
                              key: keys.next(),
                              leadingIcon: AppStandardIcons.plus,
                              trailingIcon: AppStandardIcons.arrowNarrowRight,
                              caption: _caption,
                              size: size,
                              type: type,
                              onTap: _onTap,
                            ),
                          ),
                          AppSpacings.s8.horizontalSpace,
                          AppRawButton.icon(
                            key: keys.next(),
                            icon: AppStandardIcons.plus,
                            semanticsLabel: _semanticsLabel,
                            size: size,
                            type: type,
                            onTap: _onTap,
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
                GoldenTableRow(
                  details:
                      'Type: ${type.name}\n'
                      'State: Loading',
                  cells: [
                    for (final size in AppButtonSize.values) ...[
                      GoldenRow(
                        children: [
                          Flexible(
                            child: AppRawButton(
                              key: keys.next(),
                              leadingIcon: AppStandardIcons.plus,
                              trailingIcon: AppStandardIcons.arrowNarrowRight,
                              caption: _caption,
                              size: size,
                              type: type,
                              onTap: _onTap,
                              loading: true,
                            ),
                          ),
                          AppSpacings.s8.horizontalSpace,
                          AppRawButton.icon(
                            key: keys.next(),
                            icon: AppStandardIcons.plus,
                            semanticsLabel: _semanticsLabel,
                            size: size,
                            type: type,
                            onTap: _onTap,
                            loading: true,
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
                GoldenTableRow(
                  details:
                      'Type: ${type.name}\n'
                      'State: Disabled',
                  cells: [
                    for (final size in AppButtonSize.values) ...[
                      GoldenRow(
                        children: [
                          Flexible(
                            child: AppRawButton(
                              enabled: false,
                              leadingIcon: AppStandardIcons.plus,
                              trailingIcon: AppStandardIcons.arrowNarrowRight,
                              caption: _caption,
                              size: size,
                              type: type,
                              onTap: _onTap,
                            ),
                          ),
                          AppSpacings.s8.horizontalSpace,
                          AppRawButton.icon(
                            enabled: false,
                            icon: AppStandardIcons.plus,
                            semanticsLabel: _semanticsLabel,
                            size: size,
                            type: type,
                            onTap: _onTap,
                          ),
                        ],
                      ),
                    ],
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

      await widgetsMatchGoldens(tester, 'button', surface: surface);
    });

    testGoldens('varied', (tester) async {
      final surface = Surface.canvas(width: 750, height: 750);
      final keys = GlobalKeyGenerator();

      await pumpWidgetBuilder(
        tester,
        AppFreezeInfiniteAnimations(
          child: GoldenTable(
            cellAlignment: GoldenTableCellAlignment.stretch,
            header: const GoldenTableHeader(
              headerName: 'Layout',
              cellNames: ['Shrink', 'Stretch'],
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
                        Center(
                          child: AppRawButton(
                            leadingIcon: leadingIcon,
                            trailingIcon: trailingIcon,
                            caption: switch (captionLength) {
                              _CaptionLength.short => 'Short',
                              _CaptionLength.long =>
                                'Unfathomably long caption so very long',
                            },
                            size: AppButtonSize.medium,
                            type: AppButtonType.primary,
                            onTap: _onTap,
                          ),
                        ),
                        AppRawButton(
                          leadingIcon: leadingIcon,
                          trailingIcon: trailingIcon,
                          caption: switch (captionLength) {
                            _CaptionLength.short => 'Short',
                            _CaptionLength.long =>
                              'Unfathomably long caption so very long',
                          },
                          size: AppButtonSize.medium,
                          type: AppButtonType.primary,
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

      await widgetsMatchGoldens(tester, 'button_varied', surface: surface);
    });

    group('fullWidth', () {
      testWidgets('= false makes button shrink to fit in loose width', (
        tester,
      ) async {
        await tester.pumpWidget(
          TestApp(
            child: Center(
              child: AppRawButton(
                caption: _caption,
                size: AppButtonSize.medium,
                type: AppButtonType.primary,
                onTap: _onTap,
                // ignore: avoid_redundant_argument_values, explicitly testing
                fullWidth: false,
              ),
            ),
          ),
        );

        final buttonFinder = find.byType(AppRawButton);
        final appWidth = tester.getSize(find.byType(TestApp)).width;

        expect(tester.getSize(buttonFinder).width, lessThan(appWidth));
      });

      testWidgets('= true makes button stretch to fill available loose width', (
        tester,
      ) async {
        await tester.pumpWidget(
          TestApp(
            child: Center(
              child: AppRawButton(
                caption: _caption,
                size: AppButtonSize.medium,
                type: AppButtonType.primary,
                onTap: _onTap,
                fullWidth: true,
              ),
            ),
          ),
        );

        final buttonFinder = find.byType(AppRawButton);
        final appWidth = tester.getSize(find.byType(TestApp)).width;

        expect(tester.getSize(buttonFinder).width, appWidth);
      });
    });
  });
}
