import 'package:app_design_system/app_design_system.dart';
import 'package:flutter/widgets.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import '../../golden_builder.dart';
import '../../test_app.dart';

void main() {
  testGoldens('AppActionChip', (tester) async {
    final surface = Surface.canvas(width: 850, height: 750);

    const label = 'Label';
    const veryLongLabel =
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In viverra semper malesuada.';

    final keys = GlobalKeyGenerator();

    final builder = AppGoldenBuilder.column(name: 'AppActionChip')
      ..addScenario(
        'Default',
        Align(
          alignment: AlignmentDirectional.topStart,
          child: AppActionChip(label: label, onTap: () {}),
        ),
      )
      ..addScenario(
        'Default with prefix icon',
        Align(
          alignment: AlignmentDirectional.topStart,
          child: AppActionChip(
            label: label,
            prefixIcon: AppStandardIcons.cloudSun01,
            onTap: () {},
          ),
        ),
      )
      ..addScenario(
        'Default with suffix icon',
        Align(
          alignment: AlignmentDirectional.topStart,
          child: AppActionChip(
            label: label,
            suffixIcon: AppStandardIcons.arrowRight,
            onTap: () {},
          ),
        ),
      )
      ..addScenario(
        'Default with prefix and suffix icons',
        Align(
          alignment: AlignmentDirectional.topStart,
          child: AppActionChip(
            label: label,
            prefixIcon: AppStandardIcons.cloudSun01,
            suffixIcon: AppStandardIcons.arrowRight,
            onTap: () {},
          ),
        ),
      )
      ..addScenario(
        'Default with prefix and suffix icons (pressed)',
        Align(
          alignment: AlignmentDirectional.topStart,
          child: AppActionChip(
            key: keys.next(),
            label: label,
            prefixIcon: AppStandardIcons.cloudSun01,
            suffixIcon: AppStandardIcons.arrowRight,
            onTap: () {},
          ),
        ),
      )
      ..addScenario(
        'Default with prefix and suffix icons (disabled)',
        Align(
          alignment: AlignmentDirectional.topStart,
          child: AppActionChip(
            label: label,
            enabled: false,
            prefixIcon: AppStandardIcons.cloudSun01,
            suffixIcon: AppStandardIcons.arrowRight,
            onTap: () {},
          ),
        ),
      )
      ..addScenario(
        'Default with long label and reduced space to force text overflow',
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: SizedBox(
            width: 150,
            child: AppActionChip(label: veryLongLabel, onTap: () {}),
          ),
        ),
      )
      ..addScenario(
        'Default with long label, prefix, suffix icons and reduced space to force text overflow',
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: SizedBox(
            width: 150,
            child: AppActionChip(
              label: veryLongLabel,
              prefixIcon: AppStandardIcons.cloudSun01,
              suffixIcon: AppStandardIcons.arrowRight,
              onTap: () {},
            ),
          ),
        ),
      );

    await pumpWidgetBuilder(tester, builder.build(), surface: surface);

    await tester.tapDownAll(keys);

    await tester.pumpAndSettle();

    await widgetsMatchGoldens(tester, 'action_chip', surface: surface);
  });
}
