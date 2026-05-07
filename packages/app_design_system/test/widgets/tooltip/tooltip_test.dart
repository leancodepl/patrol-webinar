import 'package:app_design_system/app_design_system.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import '../../golden_builder.dart';
import '../../test_app.dart';

void main() {
  group('AppTooltip', () {
    testGoldens('variants', (tester) async {
      final keys = GlobalKeyGenerator();

      final surface = Surface.canvas(width: 1000, height: 1400);
      final builder = AppGoldenBuilder.grid(
        name: 'AppTooltip (variants)',
        columns: 4,
      );

      for (final type in AppTooltipType.values) {
        for (final alignment in AppTooltipAlignmentDirectional.values) {
          builder.addScenario(
            '${type.name} (${alignment.name})',
            _Case(
              targetKey: keys.next(),
              tooltipAlignment: alignment,
              type: type,
            ),
          );
        }
      }

      await pumpWidgetBuilder(tester, builder.build(), surface: surface);

      await tester.pumpAndSettle();

      await tester.tapAll(keys);

      await tester.pumpAndSettle();

      await widgetsMatchGoldens(tester, 'tooltip_variants', surface: surface);
    });

    testGoldens('layout', (tester) async {
      final keys = GlobalKeyGenerator();

      final surface = Surface.canvas(width: 1000, height: 900);
      final builder =
          AppGoldenBuilder.grid(name: 'AppTooltip (layout)', columns: 4)
            ..addScenario(
              'Start',
              _Case(
                targetKey: keys.next(),
                tooltipAlignment: AppTooltipAlignmentDirectional.start,
              ),
            )
            ..addScenario(
              'Top',
              _Case(
                targetKey: keys.next(),
                tooltipAlignment: AppTooltipAlignmentDirectional.top,
              ),
            )
            ..addScenario(
              'End',
              _Case(
                targetKey: keys.next(),
                tooltipAlignment: AppTooltipAlignmentDirectional.end,
              ),
            )
            ..addScenario(
              'Bottom',
              _Case(
                targetKey: keys.next(),
                tooltipAlignment: AppTooltipAlignmentDirectional.bottom,
              ),
            )
            ..addScenario(
              'Flip from Start to End',
              _Case(
                targetKey: keys.next(),
                targetAlignment: const AlignmentDirectional(-0.5, 0),
                tooltipAlignment: AppTooltipAlignmentDirectional.start,
              ),
            )
            ..addScenario(
              'Flip from Top to Bottom',
              _Case(
                targetKey: keys.next(),
                targetAlignment: const AlignmentDirectional(0, -0.5),
                tooltipAlignment: AppTooltipAlignmentDirectional.top,
              ),
            )
            ..addScenario(
              'Flip from End to Start',
              _Case(
                targetKey: keys.next(),
                targetAlignment: const AlignmentDirectional(0.5, 0),
                tooltipAlignment: AppTooltipAlignmentDirectional.end,
              ),
            )
            ..addScenario(
              'Flip from Bottom to Top',
              _Case(
                targetKey: keys.next(),
                targetAlignment: const AlignmentDirectional(0, 0.5),
                tooltipAlignment: AppTooltipAlignmentDirectional.bottom,
              ),
            )
            ..addScenario(
              'Horizontal shift to within bounds (start)',
              _Case(
                text: _CaseText.long,
                targetKey: keys.next(),
                targetAlignment: const AlignmentDirectional(-0.7, 0.5),
                tooltipAlignment: AppTooltipAlignmentDirectional.top,
              ),
            )
            ..addScenario(
              'Horizontal shift to within bounds (end)',
              _Case(
                text: _CaseText.long,
                targetKey: keys.next(),
                targetAlignment: const AlignmentDirectional(0.7, 0.5),
                tooltipAlignment: AppTooltipAlignmentDirectional.top,
              ),
            )
            ..addScenario(
              'Vertical shift to within bounds (top)',
              _Case(
                text: _CaseText.long,
                targetKey: keys.next(),
                targetAlignment: const AlignmentDirectional(0.5, -0.7),
                tooltipAlignment: AppTooltipAlignmentDirectional.start,
              ),
            )
            ..addScenario(
              'Vertical shift to within bounds (bottom)',
              _Case(
                text: _CaseText.long,
                targetKey: keys.next(),
                targetAlignment: const AlignmentDirectional(0.5, 0.7),
                tooltipAlignment: AppTooltipAlignmentDirectional.start,
              ),
            );

      await pumpWidgetBuilder(tester, builder.build(), surface: surface);

      await tester.pumpAndSettle();

      await tester.tapAll(keys);

      await tester.pumpAndSettle();

      await widgetsMatchGoldens(tester, 'tooltip_layout', surface: surface);
    });

    testGoldens('scroll behavior', (tester) async {
      final keys = GlobalKeyGenerator();
      final leftDragKeys = GlobalKeyGenerator();
      final rightDragKeys = GlobalKeyGenerator();
      final topDragKeys = GlobalKeyGenerator();
      final bottomDragKeys = GlobalKeyGenerator();

      final controllers = ScrollControllerGenerator();
      final cannotFitControllers = ScrollControllerGenerator();
      final outOfBoundsControllers = ScrollControllerGenerator();
      final shiftArrowControllers = ScrollControllerGenerator();

      final surface = Surface.canvas(width: 1000, height: 1400);
      final builder =
          AppGoldenBuilder.grid(
              name: 'AppTooltip (scroll behavior)',
              columns: 4,
            )
            ..addScenario(
              'Left before scroll',
              _Case(
                targetKey: keys.next(),
                tooltipAlignment: AppTooltipAlignmentDirectional.start,
                builder: (context, child) => SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: child,
                  ),
                ),
              ),
            )
            ..addScenario(
              'Right before scroll',
              _Case(
                targetKey: keys.next(),
                tooltipAlignment: AppTooltipAlignmentDirectional.end,
                builder: (context, child) => SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  reverse: true,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: child,
                  ),
                ),
              ),
            )
            ..addScenario(
              'Top before scroll',
              _Case(
                targetKey: keys.next(),
                tooltipAlignment: AppTooltipAlignmentDirectional.top,
                builder: (context, child) => SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 50),
                    child: child,
                  ),
                ),
              ),
            )
            ..addScenario(
              'Bottom before scroll',
              _Case(
                targetKey: keys.next(),
                tooltipAlignment: AppTooltipAlignmentDirectional.bottom,
                builder: (context, child) => SingleChildScrollView(
                  reverse: true,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 50),
                    child: child,
                  ),
                ),
              ),
            )
            ..addScenario(
              'Flip from left to right',
              _Case(
                targetKey: keys.next(),
                tooltipAlignment: AppTooltipAlignmentDirectional.start,
                builder: (context, child) => SingleChildScrollView(
                  key: leftDragKeys.next(),
                  scrollDirection: Axis.horizontal,
                  dragStartBehavior: DragStartBehavior.down,
                  controller: controllers.next(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: child,
                  ),
                ),
              ),
            )
            ..addScenario(
              'Flip from right to left',
              _Case(
                targetKey: keys.next(),
                tooltipAlignment: AppTooltipAlignmentDirectional.end,
                builder: (context, child) => SingleChildScrollView(
                  key: rightDragKeys.next(),
                  controller: controllers.next(),
                  reverse: true,
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: child,
                  ),
                ),
              ),
            )
            ..addScenario(
              'Flip from top to bottom',
              _Case(
                targetKey: keys.next(),
                tooltipAlignment: AppTooltipAlignmentDirectional.top,
                builder: (context, child) => SingleChildScrollView(
                  key: topDragKeys.next(),
                  controller: controllers.next(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 50),
                    child: child,
                  ),
                ),
              ),
            )
            ..addScenario(
              'Flip from bottom to top',
              _Case(
                targetKey: keys.next(),
                tooltipAlignment: AppTooltipAlignmentDirectional.bottom,
                builder: (context, child) => SingleChildScrollView(
                  key: bottomDragKeys.next(),
                  reverse: true,
                  controller: controllers.next(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 50),
                    child: child,
                  ),
                ),
              ),
            )
            ..addScenario(
              'Hide when out of bounds to the start',
              _Case(
                targetKey: keys.next(),
                tooltipAlignment: AppTooltipAlignmentDirectional.start,
                builder: (context, child) => SingleChildScrollView(
                  key: leftDragKeys.next(),
                  scrollDirection: Axis.horizontal,
                  controller: outOfBoundsControllers.next(),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(end: 300),
                    child: child,
                  ),
                ),
              ),
            )
            ..addScenario(
              'Hide when out of bounds to the end',
              _Case(
                targetKey: keys.next(),
                tooltipAlignment: AppTooltipAlignmentDirectional.end,
                builder: (context, child) => SingleChildScrollView(
                  key: rightDragKeys.next(),
                  controller: outOfBoundsControllers.next(),
                  reverse: true,
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(start: 300),
                    child: child,
                  ),
                ),
              ),
            )
            ..addScenario(
              'Hide when out of bounds to the top',
              _Case(
                targetKey: keys.next(),
                tooltipAlignment: AppTooltipAlignmentDirectional.top,
                builder: (context, child) => SingleChildScrollView(
                  key: topDragKeys.next(),
                  controller: outOfBoundsControllers.next(),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 200),
                    child: child,
                  ),
                ),
              ),
            )
            ..addScenario(
              'Hide when out of bounds to the bottom',
              _Case(
                targetKey: keys.next(),
                tooltipAlignment: AppTooltipAlignmentDirectional.bottom,
                builder: (context, child) => SingleChildScrollView(
                  key: bottomDragKeys.next(),
                  reverse: true,
                  controller: outOfBoundsControllers.next(),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 200),
                    child: child,
                  ),
                ),
              ),
            )
            ..addScenario(
              'Hide when arrow would not fit on the start',
              _Case(
                targetKey: keys.next(),
                tooltipAlignment: AppTooltipAlignmentDirectional.top,
                builder: (context, child) => SingleChildScrollView(
                  key: leftDragKeys.next(),
                  scrollDirection: Axis.horizontal,
                  controller: cannotFitControllers.next(),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(end: 90),
                    child: child,
                  ),
                ),
              ),
            )
            ..addScenario(
              'Hide when arrow would not fit on the end',
              _Case(
                targetKey: keys.next(),
                tooltipAlignment: AppTooltipAlignmentDirectional.top,
                builder: (context, child) => SingleChildScrollView(
                  key: rightDragKeys.next(),
                  controller: cannotFitControllers.next(),
                  reverse: true,
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(start: 90),
                    child: child,
                  ),
                ),
              ),
            )
            ..addScenario(
              'Hide when arrow would not fit on the top',
              _Case(
                targetKey: keys.next(),
                tooltipAlignment: AppTooltipAlignmentDirectional.start,
                builder: (context, child) => SingleChildScrollView(
                  key: topDragKeys.next(),
                  controller: cannotFitControllers.next(),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 90),
                    child: child,
                  ),
                ),
              ),
            )
            ..addScenario(
              'Hide when arrow would not fit on the bottom',
              _Case(
                targetKey: keys.next(),
                tooltipAlignment: AppTooltipAlignmentDirectional.start,
                builder: (context, child) => SingleChildScrollView(
                  key: bottomDragKeys.next(),
                  reverse: true,
                  controller: cannotFitControllers.next(),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 90),
                    child: child,
                  ),
                ),
              ),
            )
            ..addScenario(
              'Shift arrow to the edge of the target when close to start',
              _Case(
                targetKey: keys.next(),
                targetText: 'Toggle tooltip',
                tooltipAlignment: AppTooltipAlignmentDirectional.top,
                builder: (context, child) => SingleChildScrollView(
                  key: leftDragKeys.next(),
                  scrollDirection: Axis.horizontal,
                  controller: shiftArrowControllers.next(),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.symmetric(
                      horizontal: 100,
                    ),
                    child: child,
                  ),
                ),
              ),
            )
            ..addScenario(
              'Shift arrow to the edge of the target when close to end',
              _Case(
                targetKey: keys.next(),
                targetText: 'Toggle tooltip',
                tooltipAlignment: AppTooltipAlignmentDirectional.top,
                builder: (context, child) => SingleChildScrollView(
                  key: rightDragKeys.next(),
                  controller: shiftArrowControllers.next(),
                  reverse: true,
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsetsDirectional.symmetric(
                      horizontal: 100,
                    ),
                    child: child,
                  ),
                ),
              ),
            )
            ..addScenario(
              'Shift arrow to the edge of the target when close to top',
              _Case(
                targetKey: keys.next(),
                tooltipAlignment: AppTooltipAlignmentDirectional.start,
                builder: (context, child) => SingleChildScrollView(
                  key: topDragKeys.next(),
                  controller: shiftArrowControllers.next(),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.symmetric(
                      vertical: 65,
                    ),
                    child: child,
                  ),
                ),
              ),
            )
            ..addScenario(
              'Shift arrow to the edge of the target when close to bottom',
              _Case(
                targetKey: keys.next(),
                tooltipAlignment: AppTooltipAlignmentDirectional.start,
                builder: (context, child) => SingleChildScrollView(
                  key: bottomDragKeys.next(),
                  reverse: true,
                  controller: shiftArrowControllers.next(),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.symmetric(
                      vertical: 65,
                    ),
                    child: child,
                  ),
                ),
              ),
            );

      await pumpWidgetBuilder(tester, builder.build(), surface: surface);
      await tester.pumpAndSettle();

      await tester.tapAll(keys);
      await tester.pumpAndSettle();

      await tester.jumpToAll(controllers, 100);
      await tester.pumpAndSettle();

      await tester.jumpToAll(outOfBoundsControllers, 360);
      await tester.pumpAndSettle();

      await tester.jumpToAll(cannotFitControllers, 180);
      await tester.pumpAndSettle();

      await tester.jumpToAll(shiftArrowControllers, 220);
      await tester.pumpAndSettle();

      await widgetsMatchGoldensSingle(
        tester,
        'tooltip_scroll_behavior',
        surface: surface,
      );
    });
  });
}

enum _CaseText { short, long }

class _Case extends StatelessWidget {
  const _Case({
    required this.targetKey,
    this.targetText = 'Show',
    this.text = _CaseText.short,
    this.targetAlignment = AlignmentDirectional.center,
    required this.tooltipAlignment,
    this.type = AppTooltipType.info,
    this.builder,
  });

  final Key targetKey;
  final String targetText;
  final _CaseText text;
  final AlignmentDirectional targetAlignment;
  final AppTooltipAlignmentDirectional tooltipAlignment;
  final AppTooltipType type;

  final TransitionBuilder? builder;

  @override
  Widget build(BuildContext context) {
    return TapRegionSurface(
      child: Container(
        height: 200,
        width: 250,
        decoration: BoxDecoration(border: Border.all()),
        child: ClipRect(
          child: AppTooltipRegistry(
            child: Builder(
              builder: (context) {
                final tooltip = SizedBox(
                  height: 200,
                  width: 250,
                  child: Align(
                    alignment: targetAlignment,
                    child: AppTooltip.tag(
                      tag: 'tooltip',
                      text: switch (text) {
                        _CaseText.short => 'Tooltip text',
                        _CaseText.long =>
                          'Enter a valid email address (e.g., user@example.com)',
                      },
                      type: type,
                      alignment: tooltipAlignment,
                      child: AppRawButton(
                        key: targetKey,
                        caption: targetText,
                        size: AppButtonSize.medium,
                        type: AppButtonType.primary,
                        onTap: () => context.showTooltip('tooltip'),
                      ),
                    ),
                  ),
                );

                return switch (builder) {
                  final builder? => builder(context, tooltip),
                  null => tooltip,
                };
              },
            ),
          ),
        ),
      ),
    );
  }
}
