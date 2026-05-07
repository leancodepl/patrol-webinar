import 'package:app_design_system/app_design_system.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import '../../golden_builder.dart';
import '../../test_app.dart';

void main() {
  testGoldens('AppLinearProgress', (tester) async {
    final surface = Surface.canvas(width: 400, height: 750);

    const longTitle =
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In viverra semper malesuada.';

    const value = 0.85;

    final builder = AppGoldenBuilder.column(name: 'AppLinearProgress')
      ..addScenario(
        'Default',
        const AppLinearProgress(
          semanticsTitle: 'Linear progress',
          value: value,
          valueBuilder: null,
        ),
      )
      ..addScenario(
        'with title',
        const AppLinearProgress(
          value: value,
          title: 'Title',
          valueBuilder: null,
        ),
      )
      ..addScenario(
        'with percentage',
        const AppLinearProgress(
          semanticsTitle: 'Linear progress',
          value: value,
        ),
      )
      ..addScenario(
        'with title and percentage',
        const AppLinearProgress(title: 'Title', value: value),
      )
      ..addScenario(
        'with long title',
        const AppLinearProgress(
          title: longTitle,
          value: value,
          valueBuilder: null,
        ),
      )
      ..addScenario(
        'with long title and percentage',
        const AppLinearProgress(title: longTitle, value: value),
      );

    await pumpWidgetBuilder(tester, builder.build(), surface: surface);

    await tester.pumpAndSettle();

    await widgetsMatchGoldens(tester, 'linear_progress', surface: surface);
  });
}
