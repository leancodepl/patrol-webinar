import 'package:app_design_system/app_design_system.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import '../../../golden_builder.dart';
import '../../../test_app.dart';

class _FocusedFocusNodeStub extends FocusNode {
  @override
  bool get hasFocus => true;
}

void main() {
  group('AppTopBar', () {
    testGoldens('simple', (tester) async {
      final surface = Surface.canvas(height: 1200);

      final builder =
          AppGoldenBuilder.grid(
              name: 'AppTextArea',
              columns: 2,
              color: AppGoldenBuilderColor.white,
            )
            ..addScenario(
              'Base',
              const AppTextArea(
                decoration: AppTextAreaDecoration(label: 'Label'),
              ),
            )
            ..addScenario(
              'Base focused',
              AppTextArea(
                focusNode: _FocusedFocusNodeStub(),
                decoration: const AppTextAreaDecoration(label: 'Label'),
              ),
            )
            ..addScenario(
              'With value',
              AppTextArea(
                controller: TextEditingController(text: 'Value'),
                decoration: const AppTextAreaDecoration(
                  label: 'Label',
                  help: 'Help',
                ),
              ),
            )
            ..addScenario(
              'With value focused',
              AppTextArea(
                controller: TextEditingController(text: 'Value'),
                focusNode: _FocusedFocusNodeStub(),
                decoration: const AppTextAreaDecoration(
                  label: 'Label',
                  help: 'Help',
                ),
              ),
            )
            ..addScenario(
              'All elements',
              const AppTextArea(
                decoration: AppTextAreaDecoration(
                  label: 'Label',
                  hint: 'Hint text',
                  help: 'Help',
                  placeholder: 'Placeholder',
                ),
              ),
            )
            ..addScenario(
              'All elements focused',
              AppTextArea(
                focusNode: _FocusedFocusNodeStub(),
                decoration: const AppTextAreaDecoration(
                  label: 'Label',
                  hint: 'Hint text',
                  help: 'Help',
                  placeholder: 'Placeholder',
                ),
              ),
            )
            ..addScenario(
              'Error',
              const AppTextArea(
                decoration: AppTextAreaDecoration(
                  label: 'Label',
                  error: 'Error message',
                  hint: 'Hint text',
                  help: 'Help',
                  placeholder: 'Placeholder',
                ),
              ),
            )
            ..addScenario(
              'Error focused',
              AppTextArea(
                focusNode: _FocusedFocusNodeStub(),
                decoration: const AppTextAreaDecoration(
                  label: 'Label',
                  error: 'Error message',
                  hint: 'Hint text',
                  help: 'Help',
                  placeholder: 'Placeholder',
                ),
              ),
            )
            ..addScenario(
              'Disabled',
              const AppTextArea(
                enabled: false,
                decoration: AppTextAreaDecoration(
                  label: 'Label',
                  error: 'Error message',
                  hint: 'Hint text',
                  help: 'Help',
                ),
              ),
            )
            ..addScenario(
              'Disabled with value',
              AppTextArea(
                enabled: false,
                controller: TextEditingController(text: 'Value'),
                focusNode: _FocusedFocusNodeStub(),
                decoration: const AppTextAreaDecoration(
                  label: 'Label',
                  error: 'Error message',
                  hint: 'Hint text',
                  help: 'Help',
                ),
              ),
            );

      await pumpWidgetBuilder(tester, builder.build(), surface: surface);

      await tester.pumpAndSettle();

      await widgetsMatchGoldens(tester, 'text_area', surface: surface);
    });
  });
}
