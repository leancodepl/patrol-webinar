import 'package:app_design_system/app_design_system.dart';
import 'package:flutter/material.dart' show EdgeInsets;
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import '../../golden_builder.dart';
import '../../test_app.dart';

const _snackBarLongText =
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
    'Sed non risus. Suspendisse lectus tortor, dignissim sit amet';

void main() {
  group('AppSnackbar', () {
    testGoldens('structure', (tester) async {
      final surface = Surface.canvas(width: 600, height: 1400);

      final builder =
          AppGoldenBuilder.column(
              name: 'AppSnackbar (structure)',
              color: AppGoldenBuilderColor.white,
            )
            ..addScenario(
              'Base',
              const AppSnackbar(
                text: 'Text',
                type: AppSnackbarType.neutral,
                automaticallyImplyOnCloseTap: false,
                padding: EdgeInsets.zero,
              ),
            )
            ..addScenario(
              'Long text',
              const AppSnackbar(
                text: _snackBarLongText,
                type: AppSnackbarType.neutral,
                automaticallyImplyOnCloseTap: false,
                padding: EdgeInsets.zero,
              ),
            )
            ..addScenario(
              'All elements',
              AppSnackbar(
                type: AppSnackbarType.info,
                icon: AppStandardIcons.infoCircle,
                text: 'Snackbar text',
                action: AppSnackbarAction(caption: 'Action', onTap: () {}),
                onCloseTap: () {},
                padding: EdgeInsets.zero,
              ),
            )
            ..addScenario(
              'All elements (action below)',
              AppSnackbar(
                type: AppSnackbarType.info,
                icon: AppStandardIcons.infoCircle,
                text: 'Snackbar text',
                action: AppSnackbarAction(
                  position: AppSnackbarActionPosition.below,
                  caption: 'Action',
                  onTap: () {},
                ),
                onCloseTap: () {},
                padding: EdgeInsets.zero,
              ),
            )
            ..addScenario(
              'Long text with all elements',
              AppSnackbar(
                type: AppSnackbarType.info,
                icon: AppStandardIcons.infoCircle,
                text: _snackBarLongText,
                action: AppSnackbarAction(caption: 'Action', onTap: () {}),
                onCloseTap: () {},
                padding: EdgeInsets.zero,
              ),
            )
            ..addScenario(
              'Long text with all elements (action below)',
              AppSnackbar(
                type: AppSnackbarType.info,
                icon: AppStandardIcons.infoCircle,
                text: _snackBarLongText,
                action: AppSnackbarAction(
                  position: AppSnackbarActionPosition.below,
                  caption: 'Action',
                  onTap: () {},
                ),
                onCloseTap: () {},
                padding: EdgeInsets.zero,
              ),
            )
            ..addScenario(
              'No action',
              AppSnackbar(
                type: AppSnackbarType.info,
                icon: AppStandardIcons.infoCircle,
                text: 'Snackbar text',
                onCloseTap: () {},
                padding: EdgeInsets.zero,
              ),
            )
            ..addScenario(
              'Action with icons',
              AppSnackbar(
                type: AppSnackbarType.info,
                icon: AppStandardIcons.infoCircle,
                text: 'Snackbar text',
                action: AppSnackbarAction(
                  leadingIcon: AppStandardIcons.chevronLeft,
                  caption: 'Action',
                  trailingIcon: AppStandardIcons.plus,
                  onTap: () {},
                ),
                onCloseTap: () {},
                padding: EdgeInsets.zero,
              ),
            )
            ..addScenario(
              'Action with icons (action below)',
              AppSnackbar(
                type: AppSnackbarType.info,
                icon: AppStandardIcons.infoCircle,
                text: 'Snackbar text',
                action: AppSnackbarAction(
                  position: AppSnackbarActionPosition.below,
                  leadingIcon: AppStandardIcons.chevronLeft,
                  caption: 'Action',
                  trailingIcon: AppStandardIcons.plus,
                  onTap: () {},
                ),
                onCloseTap: () {},
                padding: EdgeInsets.zero,
              ),
            );

      await pumpWidgetBuilder(
        tester,
        AppSnackbarTheater(child: builder.build()),
        surface: surface,
      );

      await tester.pumpAndSettle();

      await widgetsMatchGoldens(tester, 'snack_bar', surface: surface);
    });

    testGoldens('types', (tester) async {
      final surface = Surface.canvas(width: 400, height: 650);

      final builder =
          AppGoldenBuilder.column(
              name: 'AppSnackbar (types)',
              color: AppGoldenBuilderColor.white,
            )
            ..addScenario(
              'Neutral',
              AppSnackbar(
                type: AppSnackbarType.neutral,
                text: 'Text',
                onCloseTap: () {},
                padding: EdgeInsets.zero,
              ),
            )
            ..addScenario(
              'Info',
              AppSnackbar(
                type: AppSnackbarType.info,
                text: 'Text',
                onCloseTap: () {},
                padding: EdgeInsets.zero,
              ),
            )
            ..addScenario(
              'Success',
              AppSnackbar(
                type: AppSnackbarType.success,
                text: 'Text',
                onCloseTap: () {},
                padding: EdgeInsets.zero,
              ),
            )
            ..addScenario(
              'Warning',
              AppSnackbar(
                type: AppSnackbarType.warning,
                text: 'Text',
                onCloseTap: () {},
                padding: EdgeInsets.zero,
              ),
            )
            ..addScenario(
              'Danger',
              AppSnackbar(
                type: AppSnackbarType.danger,
                text: 'Text',
                onCloseTap: () {},
                padding: EdgeInsets.zero,
              ),
            );

      await pumpWidgetBuilder(
        tester,
        AppSnackbarTheater(child: builder.build()),
        surface: surface,
      );

      await tester.pumpAndSettle();

      await widgetsMatchGoldensSingle(
        tester,
        'snack_bar_types',
        surface: surface,
      );
    });
  });
}
