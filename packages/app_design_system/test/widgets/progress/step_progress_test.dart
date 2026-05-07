import 'package:app_design_system/app_design_system.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import '../../golden_builder.dart';
import '../../test_app.dart';

void main() {
  testGoldens('AppStepProgress', (tester) async {
    final surface = Surface.canvas(width: 400, height: 750);

    const longTitle =
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In viverra semper malesuada.';

    const totalSteps = 7;
    const currentStep = 4;

    final builder = AppGoldenBuilder.column(name: 'AppStepProgress')
      ..addScenario(
        'Default',
        const AppStepProgress(
          semanticsTitle: 'Step progress',
          totalSteps: totalSteps,
          currentStepIndex: currentStep,
          valueBuilder: null,
        ),
      )
      ..addScenario(
        'with title',
        const AppStepProgress(
          totalSteps: totalSteps,
          currentStepIndex: currentStep,
          title: 'Title',
          valueBuilder: null,
        ),
      )
      ..addScenario(
        'with fraction',
        const AppStepProgress(
          semanticsTitle: 'Step progress',
          totalSteps: totalSteps,
          currentStepIndex: currentStep,
          valueBuilder: null,
        ),
      )
      ..addScenario(
        'with title and fraction',
        const AppStepProgress(
          title: 'Title',
          totalSteps: totalSteps,
          currentStepIndex: currentStep,
        ),
      )
      ..addScenario(
        'with long title',
        const AppStepProgress(
          title: longTitle,
          totalSteps: totalSteps,
          currentStepIndex: currentStep,
          valueBuilder: null,
        ),
      )
      ..addScenario(
        'with long title and fraction',
        const AppStepProgress(
          title: longTitle,
          totalSteps: totalSteps,
          currentStepIndex: currentStep,
        ),
      );

    await pumpWidgetBuilder(tester, builder.build(), surface: surface);

    await tester.pumpAndSettle();

    await widgetsMatchGoldens(tester, 'step_progress', surface: surface);
  });
}
