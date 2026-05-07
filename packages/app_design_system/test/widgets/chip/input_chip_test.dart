import 'package:app_design_system/app_design_system.dart';
import 'package:flutter/widgets.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import '../../golden_builder.dart';
import '../../test_app.dart';

void main() {
  testGoldens('AppInputChip', (tester) async {
    final surface = Surface.canvas(width: 750, height: 400);

    const label = 'Label';
    const veryLongLabel =
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In viverra semper malesuada.';

    final keys = GlobalKeyGenerator();

    final builder = AppGoldenBuilder.column(name: 'AppInputChip')
      ..addScenario(
        'Default',
        Align(
          alignment: AlignmentDirectional.topStart,
          child: AppInputChip(label: label, remove: () {}),
        ),
      )
      ..addScenario(
        'Default (pressed)',
        Align(
          alignment: AlignmentDirectional.topStart,
          child: AppInputChip(
            closeButtonKey: keys.next(),
            label: label,
            remove: () {},
          ),
        ),
      )
      ..addScenario(
        'Disabled',
        Align(
          alignment: AlignmentDirectional.topStart,
          child: AppInputChip(enabled: false, label: label, remove: () {}),
        ),
      )
      ..addScenario(
        'Default with long label and reduced space to force text overflow',
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: SizedBox(
            width: 150,
            child: AppInputChip(label: veryLongLabel, remove: () {}),
          ),
        ),
      );

    await pumpWidgetBuilder(tester, builder.build(), surface: surface);

    await tester.tapDownAll(keys);

    await tester.pumpAndSettle();

    await widgetsMatchGoldens(tester, 'input_chip', surface: surface);
  });
}
