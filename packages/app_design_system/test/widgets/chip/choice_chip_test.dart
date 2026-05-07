import 'package:app_design_system/app_design_system.dart';
import 'package:flutter/widgets.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import '../../golden_builder.dart';
import '../../test_app.dart';

void main() {
  testGoldens('AppChoiceChip', (tester) async {
    final surface = Surface.canvas(width: 750, height: 750);

    const label = 'Label';
    const veryLongLabel =
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In viverra semper malesuada.';

    final keys = GlobalKeyGenerator();

    final builder = AppGoldenBuilder.column(name: 'AppChoiceChip')
      ..addScenario(
        'Default',
        Align(
          alignment: AlignmentDirectional.topStart,
          child: AppChoiceChip(selected: false, label: label, onTap: () {}),
        ),
      )
      ..addScenario(
        'Default (pressed)',
        Align(
          alignment: AlignmentDirectional.topStart,
          child: AppChoiceChip(
            key: keys.next(),
            selected: false,
            label: label,
            onTap: () {},
          ),
        ),
      )
      ..addScenario(
        'Default (disabled)',
        Align(
          alignment: AlignmentDirectional.topStart,
          child: AppChoiceChip(
            selected: false,
            enabled: false,
            label: label,
            onTap: () {},
          ),
        ),
      )
      ..addScenario(
        'Selected',
        Align(
          alignment: AlignmentDirectional.topStart,
          child: AppChoiceChip(selected: true, label: label, onTap: () {}),
        ),
      )
      ..addScenario(
        'Selected (pressed)',
        Align(
          alignment: AlignmentDirectional.topStart,
          child: AppChoiceChip(
            key: keys.next(),
            selected: true,
            label: label,
            onTap: () {},
          ),
        ),
      )
      ..addScenario(
        'Selected (disabled)',
        Align(
          alignment: AlignmentDirectional.topStart,
          child: AppChoiceChip(
            selected: true,
            enabled: false,
            label: label,
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
            child: AppChoiceChip(
              selected: false,
              label: veryLongLabel,
              onTap: () {},
            ),
          ),
        ),
      );

    await pumpWidgetBuilder(tester, builder.build(), surface: surface);

    await tester.tapDownAll(keys);

    await tester.pumpAndSettle();

    await widgetsMatchGoldens(tester, 'choice_chip', surface: surface);
  });
}
