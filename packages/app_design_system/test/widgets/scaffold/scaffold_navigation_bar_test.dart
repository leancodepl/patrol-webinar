// Better readibility for tests
// ignore_for_file: avoid_redundant_argument_values

import 'package:app_design_system/app_design_system.dart';
import 'package:app_design_system/src/utils/global_key_extensions.dart';
import 'package:app_design_system/src/widgets/scaffold/widgets/pinned_bottom_segment_layout.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'common.dart';

enum _Page {
  home,
  search,
  profile,
  settings;

  AppNavigationBarItem get item => AppNavigationBarItem(
    title: name,
    badge: this == profile,
    icon: switch (this) {
      home => AppStandardIcons.home01,
      search => AppStandardIcons.fileSearch01,
      profile => AppStandardIcons.user01,
      settings => AppStandardIcons.settings01,
    },
  );
}

void main() {
  group('AppScaffold.navigationBar', () {
    late AppNavigationBarController controller;

    setUp(() {
      controller = AppNavigationBarController(totalPages: _Page.values.length);
    });

    tearDown(() {
      controller.dispose();
    });

    testWidgets('builds with top bar, body, FAB and navigation bar', (
      tester,
    ) async {
      const topBarKey = Key('AppTopBar');
      const pageBodyKey = Key('PageBody');
      const fabKey = Key('FloatingActionButton');

      await tester.pumpWidget(
        ScaffoldWidgetTestsWrapper(
          scaffold: AppScaffold.navigationBar(
            topBar: const AppTopBarPlaceholder(key: topBarKey),
            floatingActionButton: const FabPlaceholder(key: fabKey),
            navigationController: controller,
            navigationItems: [for (final page in _Page.values) page.item],
            body: const SizedBox(key: pageBodyKey),
          ),
        ),
      );

      expect(find.byKey(topBarKey), findsOneWidget);
      expect(find.byKey(fabKey), findsOneWidget);
      expect(find.byType(AppNavigationBar), findsOneWidget);
      expect(find.byKey(pageBodyKey), findsOneWidget);
    });

    testWidgets(
      'builds with horizontal safe area padding on useSafeArea = true',
      (tester) async {
        final bodyKey = GlobalKey();

        await tester.pumpWidget(
          ScaffoldWidgetTestsWrapper(
            useMediaQueryPadding: true,
            scaffold: AppScaffold.navigationBar(
              useSafeArea: true,
              navigationController: controller,
              navigationItems: [for (final page in _Page.values) page.item],
              body: SizedBox(key: bodyKey),
            ),
          ),
        );

        final bodyLeftPosition = tester.getTopLeft(find.byKey(bodyKey)).dx;
        final bodyRightPosition = tester.getTopRight(find.byKey(bodyKey)).dx;

        expect(
          bodyLeftPosition,
          ScaffoldWidgetTestsWrapper.mediaQueryPadding.left,
        );

        expect(
          bodyRightPosition,
          ScaffoldWidgetTestsWrapper.width -
              ScaffoldWidgetTestsWrapper.mediaQueryPadding.right,
        );
      },
    );

    testWidgets('clears MediaQuery horizontal padding on useSafeArea = true', (
      tester,
    ) async {
      EdgeInsets? resolvedBodySafePadding;

      await tester.pumpWidget(
        ScaffoldWidgetTestsWrapper(
          useMediaQueryPadding: true,
          scaffold: AppScaffold.navigationBar(
            useSafeArea: true,
            navigationController: controller,
            navigationItems: [for (final page in _Page.values) page.item],
            body: Builder(
              builder: (context) {
                resolvedBodySafePadding = MediaQuery.paddingOf(context);

                return const SizedBox();
              },
            ),
          ),
        ),
      );

      expect(resolvedBodySafePadding?.left, 0);
      expect(resolvedBodySafePadding?.right, 0);
    });

    testWidgets(
      'builds with no horizontal safe area padding on useSafeArea = false',
      (tester) async {
        final bodyKey = GlobalKey();

        await tester.pumpWidget(
          ScaffoldWidgetTestsWrapper(
            useMediaQueryPadding: true,
            scaffold: AppScaffold.navigationBar(
              useSafeArea: false,
              navigationController: controller,
              navigationItems: [for (final page in _Page.values) page.item],
              body: SizedBox(key: bodyKey),
            ),
          ),
        );

        final bodyLeftPosition = tester.getTopLeft(find.byKey(bodyKey)).dx;
        final bodyRightPosition = tester.getTopRight(find.byKey(bodyKey)).dx;

        expect(bodyLeftPosition, 0);
        expect(bodyRightPosition, ScaffoldWidgetTestsWrapper.width);
      },
    );

    testWidgets(
      'passes original MediaQuery horizontal padding on useSafeArea = false',
      (tester) async {
        EdgeInsets? resolvedBodySafePadding;

        await tester.pumpWidget(
          ScaffoldWidgetTestsWrapper(
            useMediaQueryPadding: true,
            scaffold: AppScaffold.navigationBar(
              useSafeArea: false,
              navigationController: controller,
              navigationItems: [for (final page in _Page.values) page.item],
              body: Builder(
                builder: (context) {
                  resolvedBodySafePadding = MediaQuery.paddingOf(context);

                  return const SizedBox();
                },
              ),
            ),
          ),
        );

        expect(
          resolvedBodySafePadding?.left,
          ScaffoldWidgetTestsWrapper.mediaQueryPadding.left,
        );
        expect(
          resolvedBodySafePadding?.right,
          ScaffoldWidgetTestsWrapper.mediaQueryPadding.right,
        );
      },
    );

    testWidgets('builds FAB above navigation bar with proper padding', (
      tester,
    ) async {
      final fabKey = GlobalKey();

      await tester.pumpWidget(
        ScaffoldWidgetTestsWrapper(
          useMediaQueryPadding: true,
          scaffold: AppScaffold.navigationBar(
            floatingActionButton: FabPlaceholder(key: fabKey),
            navigationController: controller,
            useSafeArea: true,
            navigationItems: [for (final page in _Page.values) page.item],
            body: const SizedBox(),
          ),
        ),
      );

      final fabWithPaddingBottomPosition = fabKey.getGlobalRect()!.bottom;

      final footerSize = tester.getSize(find.byType(AppNavigationBar));

      expect(
        fabWithPaddingBottomPosition,
        ScaffoldWidgetTestsWrapper.height -
            footerSize.height -
            PinnedBottomSegmentHeight.floatingActionButtonPadding.bottom -
            ScaffoldWidgetTestsWrapper.mediaQueryPadding.bottom,
      );
    });
  });
}
