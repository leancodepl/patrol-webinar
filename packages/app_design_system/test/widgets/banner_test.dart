import 'package:app_design_system/app_design_system.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import '../golden_builder.dart';
import '../test_app.dart';

const _bannerLongText =
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
    'Sed non risus. Suspendisse lectus tortor, dignissim sit amet';

void main() {
  group('AppBanner', () {
    testGoldens('structure', (tester) async {
      final surface = Surface.canvas(width: 600, height: 1800);

      final builder = AppGoldenBuilder.column(name: 'AppBanner (structure)')
        ..addScenario(
          'Base',
          const AppBanner(
            type: AppBannerType.info,
            title: 'Text',
            description: 'Description',
            closeStrategy: AppBannerCloseStrategy.none,
          ),
        )
        ..addScenario(
          'Long text',
          const AppBanner(
            type: AppBannerType.info,
            title: 'Text',
            description: _bannerLongText,
            closeStrategy: AppBannerCloseStrategy.none,
          ),
        )
        ..addScenario(
          'With two actions',
          AppBanner(
            type: AppBannerType.info,
            icon: AppStandardIcons.infoCircle,
            title: 'Banner text',
            actions: [
              AppRawButton(
                caption: 'Action',
                size: AppButtonSize.large,
                type: AppButtonType.primary,
                onTap: () {},
              ),
              AppRawButton(
                caption: 'Action',
                size: AppButtonSize.large,
                type: AppButtonType.secondary,
                onTap: () {},
              ),
            ],
          ),
        )
        ..addScenario(
          'With two actions, forced box layout',
          AppBanner(
            type: AppBannerType.info,
            forceBoxLayout: true,
            icon: AppStandardIcons.infoCircle,
            title: 'Banner text',
            actions: [
              AppRawButton(
                caption: 'Action',
                size: AppButtonSize.large,
                type: AppButtonType.primary,
                onTap: () {},
              ),
              AppRawButton(
                caption: 'Action',
                size: AppButtonSize.large,
                type: AppButtonType.secondary,
                onTap: () {},
              ),
            ],
          ),
        )
        ..addScenario(
          'With description and action',
          AppBanner(
            type: AppBannerType.info,
            icon: AppStandardIcons.infoCircle,
            title: 'Banner text',
            description: 'Description',
            actions: [
              AppRawButton(
                size: AppButtonSize.large,
                type: AppButtonType.primary,
                caption: 'Action',
                onTap: () {},
              ),
            ],
          ),
        )
        ..addScenario(
          'Long text with all elements',
          AppBanner(
            title: _bannerLongText,
            type: AppBannerType.info,
            icon: AppStandardIcons.infoCircle,
            description: _bannerLongText,
            actions: [
              AppRawButton(
                caption: 'Action',
                size: AppButtonSize.large,
                type: AppButtonType.primary,
                onTap: () {},
              ),
              AppRawButton(
                caption: 'Action',
                size: AppButtonSize.large,
                type: AppButtonType.secondary,
                onTap: () {},
              ),
            ],
          ),
        )
        ..addScenario(
          'No action',
          const AppBanner(
            type: AppBannerType.info,
            icon: AppStandardIcons.infoCircle,
            title: 'Banner text',
          ),
        );

      await pumpWidgetBuilder(tester, builder.build(), surface: surface);

      await tester.pumpAndSettle();

      await widgetsMatchGoldens(tester, 'banner', surface: surface);
    });

    testGoldens('types', (tester) async {
      final surface = Surface.canvas(width: 400, height: 650);

      final builder = AppGoldenBuilder.column(name: 'AppBanner (types)')
        ..addScenario(
          'Info',
          const AppBanner(
            type: AppBannerType.info,
            title: 'Text',
            description: 'Description',
          ),
        )
        ..addScenario(
          'Success',
          const AppBanner(
            type: AppBannerType.success,
            title: 'Text',
            description: 'Description',
          ),
        )
        ..addScenario(
          'Warning',
          const AppBanner(
            type: AppBannerType.warning,
            title: 'Text',
            description: 'Description',
          ),
        )
        ..addScenario(
          'Danger',
          const AppBanner(
            type: AppBannerType.danger,
            title: 'Text',
            description: 'Description',
          ),
        );

      await pumpWidgetBuilder(tester, builder.build(), surface: surface);

      await tester.pumpAndSettle();

      await widgetsMatchGoldensSingle(tester, 'banner_types', surface: surface);
    });

    group('close strategies', () {
      testWidgets('none has no close icon button', (tester) async {
        await tester.pumpWidget(
          const TestApp(
            child: AppBanner(
              type: AppBannerType.info,
              title: 'Text',
              description: 'Description',
              closeStrategy: AppBannerCloseStrategy.none,
            ),
          ),
        );

        expect(find.byType(AppIcon), findsNothing);
      });

      testWidgets('collapsible hides the banner on icon tap', (tester) async {
        await tester.pumpWidget(
          const TestApp(
            child: AppBanner(
              type: AppBannerType.info,
              title: 'Text',
              description: 'Description',
              // ignore: avoid_redundant_argument_values, explicit value that we test
              closeStrategy: AppBannerCloseStrategy.collapsible(),
            ),
          ),
        );

        expect(find.text('Text'), findsOneWidget);
        expect(find.text('Description'), findsOneWidget);
        expect(tester.getSize(find.byType(AppBanner)).height, greaterThan(0));

        await tester.tap(
          find.byWidgetPredicate(
            (widget) =>
                widget is AppIcon && widget.data == AppStandardIcons.xClose,
          ),
        );

        await tester.pumpAndSettle();

        expect(find.text('Text'), findsNothing);
        expect(find.text('Description'), findsNothing);
        expect(tester.getSize(find.byType(AppBanner)).height, isZero);
      });
    });

    testWidgets('delegated calls callback', (tester) async {
      var tapped = false;

      await tester.pumpWidget(
        TestApp(
          child: AppBanner(
            type: AppBannerType.info,
            title: 'Text',
            description: 'Description',
            closeStrategy: AppBannerCloseStrategy.delegated(
              onCloseTap: () => tapped = true,
            ),
          ),
        ),
      );

      expect(tapped, isFalse);
      expect(find.text('Text'), findsOneWidget);
      expect(find.text('Description'), findsOneWidget);
      expect(tester.getSize(find.byType(AppBanner)).height, greaterThan(0));

      await tester.tap(
        find.byWidgetPredicate(
          (widget) =>
              widget is AppIcon && widget.data == AppStandardIcons.xClose,
        ),
      );

      expect(tapped, isTrue);
      expect(find.text('Text'), findsOneWidget);
      expect(find.text('Description'), findsOneWidget);
      expect(tester.getSize(find.byType(AppBanner)).height, greaterThan(0));
    });
  });
}
