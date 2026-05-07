// Better readibility for tests
// ignore_for_file: avoid_redundant_argument_values

import 'package:app_design_system/app_design_system.dart';
import 'package:app_design_system/src/utils/global_key_extensions.dart';
import 'package:app_design_system/src/widgets/scaffold/widgets/pinned_bottom_segment_layout.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'common.dart';

void main() {
  group('AppScaffold', () {
    testWidgets('builds with top bar, fab and body', (tester) async {
      const topBarKey = Key('AppTopBar');
      const fabKey = Key('FloatingActionButton');
      const bodyKey = Key('Body');

      await tester.pumpWidget(
        ScaffoldWidgetTestsWrapper(
          scaffold: AppScaffold(
            topBar: const AppTopBarPlaceholder(key: topBarKey),
            floatingActionButton: const FabPlaceholder(key: fabKey),
            body: const SizedBox(key: bodyKey),
          ),
        ),
      );

      expect(find.byKey(topBarKey), findsOneWidget);
      expect(find.byKey(fabKey), findsOneWidget);
      expect(find.byKey(bodyKey), findsOneWidget);
    });

    testWidgets('builds with safe body padding on useSafeArea = true', (
      tester,
    ) async {
      final bodyKey = GlobalKey();

      await tester.pumpWidget(
        ScaffoldWidgetTestsWrapper(
          useMediaQueryPadding: true,
          scaffold: AppScaffold(
            useSafeArea: true,
            useBodyPadding: false,
            body: SizedBox(key: bodyKey),
          ),
        ),
      );

      final bodyBottomPosition = tester.getBottomRight(find.byKey(bodyKey)).dy;

      expect(
        bodyBottomPosition,
        ScaffoldWidgetTestsWrapper.height -
            ScaffoldWidgetTestsWrapper.mediaQueryPaddingValue,
      );
    });

    testWidgets(
      'passes original safe area through MediaQuery to body on useSafeArea = false',
      (tester) async {
        EdgeInsets? resolvedBodySafePadding;

        await tester.pumpWidget(
          ScaffoldWidgetTestsWrapper(
            useMediaQueryPadding: true,
            scaffold: AppScaffold(
              useSafeArea: false,
              useBodyPadding: false,
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
          resolvedBodySafePadding,
          ScaffoldWidgetTestsWrapper.mediaQueryPadding,
        );
      },
    );

    testWidgets(
      'builds with horizontal safe area padding on useSafeArea = true',
      (tester) async {
        final bodyKey = GlobalKey();

        await tester.pumpWidget(
          ScaffoldWidgetTestsWrapper(
            useMediaQueryPadding: true,
            scaffold: AppScaffold(
              useSafeArea: true,
              useBodyPadding: false,
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
          scaffold: AppScaffold(
            useSafeArea: true,
            useBodyPadding: false,
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
            scaffold: AppScaffold(
              useSafeArea: false,
              useBodyPadding: false,
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
            scaffold: AppScaffold(
              useSafeArea: false,
              useBodyPadding: false,
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

    testWidgets(
      'passes original safe area without top inset through MediaQuery to body on useSafeArea = false, topBar != null',
      (tester) async {
        EdgeInsets? resolvedBodySafePadding;

        await tester.pumpWidget(
          ScaffoldWidgetTestsWrapper(
            useMediaQueryPadding: true,
            scaffold: AppScaffold(
              useSafeArea: false,
              useBodyPadding: false,
              topBar: const AppTopBarPlaceholder(),
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
          resolvedBodySafePadding,
          ScaffoldWidgetTestsWrapper.mediaQueryPadding.copyWith(top: 0),
        );
      },
    );

    testWidgets(
      'passes original safe area without bottom padding through MediaQuery to body on useSafeArea = false, footer != null',
      (tester) async {
        EdgeInsets? resolvedFooterPadding;
        EdgeInsets? resolvedBodySafePadding;

        await tester.pumpWidget(
          ScaffoldWidgetTestsWrapper(
            useMediaQueryPadding: true,
            scaffold: AppScaffold(
              useSafeArea: false,
              useBodyPadding: false,
              footerBuilder: (context, padding) {
                resolvedFooterPadding = padding;
                return const FooterPlaceholder();
              },
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
          resolvedFooterPadding,
          ScaffoldWidgetTestsWrapper.mediaQueryPadding.copyWith(top: 0),
        );
        expect(
          resolvedBodySafePadding,
          ScaffoldWidgetTestsWrapper.mediaQueryPadding.copyWith(bottom: 0),
        );
      },
    );

    testWidgets(
      'passes safe area with updated bottom padding through MediaQuery to body on useSafeArea = false, footer != null, footerOnTop = true',
      (tester) async {
        EdgeInsets? resolvedFooterPadding;
        EdgeInsets? resolvedBodySafePadding;

        await tester.pumpWidget(
          ScaffoldWidgetTestsWrapper(
            useMediaQueryPadding: true,
            scaffold: AppScaffold(
              useSafeArea: false,
              useBodyPadding: false,
              footerOnTop: true,
              footerBuilder: (context, padding) {
                resolvedFooterPadding = padding;

                return const FooterPlaceholder();
              },
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
          resolvedFooterPadding,
          ScaffoldWidgetTestsWrapper.mediaQueryPadding.copyWith(top: 0),
        );
        expect(
          resolvedBodySafePadding,
          ScaffoldWidgetTestsWrapper.mediaQueryPadding.copyWith(
            bottom: FooterPlaceholder.height,
          ),
        );
      },
    );

    testWidgets(
      'passes original safe area with modified bottom padding through MediaQuery to body on useSafeArea = false, footer != null, footerOnTop = false',
      (tester) async {
        EdgeInsets? resolvedFooterPadding;
        EdgeInsets? resolvedBodySafePadding;

        await tester.pumpWidget(
          ScaffoldWidgetTestsWrapper(
            useMediaQueryPadding: true,
            scaffold: AppScaffold(
              useSafeArea: false,
              useBodyPadding: false,
              footerOnTop: false,
              footerBuilder: (context, padding) {
                resolvedFooterPadding = padding;

                return const FooterPlaceholder();
              },
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
          resolvedFooterPadding,
          ScaffoldWidgetTestsWrapper.mediaQueryPadding.copyWith(top: 0),
        );
        expect(
          resolvedBodySafePadding,
          ScaffoldWidgetTestsWrapper.mediaQueryPadding.copyWith(bottom: 0),
        );
      },
    );

    testWidgets(
      'passes updated safe area through MediaQuery to body on useSafeArea = true',
      (tester) async {
        EdgeInsets? resolvedBodySafePadding;

        await tester.pumpWidget(
          ScaffoldWidgetTestsWrapper(
            useMediaQueryPadding: true,
            scaffold: AppScaffold(
              topBar: const AppTopBarPlaceholder(),
              useSafeArea: true,
              useBodyPadding: false,
              body: Builder(
                builder: (context) {
                  resolvedBodySafePadding = MediaQuery.paddingOf(context);

                  return const SizedBox();
                },
              ),
            ),
          ),
        );

        expect(resolvedBodySafePadding, EdgeInsets.zero);
      },
    );

    testWidgets(
      'passes updated safe area through MediaQuery to body on useSafeArea = true and topBar == null',
      (tester) async {
        EdgeInsets? resolvedBodySafePadding;

        await tester.pumpWidget(
          ScaffoldWidgetTestsWrapper(
            useMediaQueryPadding: true,
            scaffold: AppScaffold(
              useSafeArea: true,
              useBodyPadding: false,
              body: Builder(
                builder: (context) {
                  resolvedBodySafePadding = MediaQuery.paddingOf(context);

                  return const SizedBox();
                },
              ),
            ),
          ),
        );

        expect(resolvedBodySafePadding, EdgeInsets.zero);
      },
    );

    testWidgets(
      'builds with top safe padding on useSafeArea = true and topBar == null',
      (tester) async {
        final bodyKey = GlobalKey();

        await tester.pumpWidget(
          ScaffoldWidgetTestsWrapper(
            useMediaQueryPadding: true,
            scaffold: AppScaffold(
              useSafeArea: true,
              useBodyPadding: false,
              body: SizedBox(key: bodyKey),
            ),
          ),
        );

        final bodyTopPosition = bodyKey.getGlobalRect()!.top;

        expect(
          bodyTopPosition,
          ScaffoldWidgetTestsWrapper.mediaQueryPadding.top,
        );
      },
    );

    testWidgets('builds without safe body padding on useSafeArea = false', (
      tester,
    ) async {
      final bodyKey = GlobalKey();

      await tester.pumpWidget(
        ScaffoldWidgetTestsWrapper(
          useMediaQueryPadding: true,
          scaffold: AppScaffold(
            useSafeArea: false,
            useBodyPadding: false,
            body: SizedBox(key: bodyKey),
          ),
        ),
      );

      final bodyBottomPosition = bodyKey.getGlobalRect()!.bottom;

      expect(bodyBottomPosition, ScaffoldWidgetTestsWrapper.height);
    });

    testWidgets('builds FAB above footer with proper padding', (tester) async {
      final fabKey = GlobalKey();

      await tester.pumpWidget(
        ScaffoldWidgetTestsWrapper(
          useMediaQueryPadding: true,
          scaffold: AppScaffold(
            useSafeArea: true,
            floatingActionButton: FabPlaceholder(key: fabKey),
            body: const SizedBox(),
          ),
        ),
      );

      final fabBottomPosition = fabKey.getGlobalRect()!;

      expect(
        fabBottomPosition.bottom,
        ScaffoldWidgetTestsWrapper.height -
            ScaffoldWidgetTestsWrapper.mediaQueryPaddingValue -
            PinnedBottomSegmentHeight.floatingActionButtonPadding.bottom,
      );

      expect(
        fabBottomPosition.right,
        ScaffoldWidgetTestsWrapper.width -
            ScaffoldWidgetTestsWrapper.mediaQueryPaddingValue -
            PinnedBottomSegmentHeight.floatingActionButtonPadding.end,
      );
    });

    testWidgets('builds with body padding on useBodyPadding = true', (
      tester,
    ) async {
      final bodyKey = GlobalKey();

      await tester.pumpWidget(
        ScaffoldWidgetTestsWrapper(
          scaffold: AppScaffold(
            useBodyPadding: true,
            useSafeArea: false,
            body: SizedBox(key: bodyKey),
          ),
        ),
      );

      final bodyBottomPosition = bodyKey.getGlobalRect()!.bottom;

      expect(
        bodyBottomPosition,
        ScaffoldWidgetTestsWrapper.height - AppScaffold.bodyPadding.value,
      );
    });

    testWidgets('builds without body padding on useBodyPadding = false', (
      tester,
    ) async {
      final bodyKey = GlobalKey();

      await tester.pumpWidget(
        ScaffoldWidgetTestsWrapper(
          scaffold: AppScaffold(
            useBodyPadding: false,
            useSafeArea: false,
            body: SizedBox(key: bodyKey),
          ),
        ),
      );

      final bodyBottomPosition = bodyKey.getGlobalRect()!.bottom;

      expect(bodyBottomPosition, ScaffoldWidgetTestsWrapper.height);
    });

    testWidgets(
      'scaffold eats viewInsets for body and footer with resizeToAvoidBottomInsets=true',
      (tester) async {
        final bodyKey = GlobalKey();
        final footerKey = GlobalKey();

        const footerHeight = 10.0;
        double? bodyBottomViewInsets;
        double? footerBottomViewInsets;

        await tester.pumpWidget(
          ScaffoldWidgetTestsWrapper(
            useMediaQueryViewInsets: true,
            scaffold: AppScaffold(
              resizeToAvoidBottomInset: true,
              useBodyPadding: false,
              useSafeArea: false,
              body: Builder(
                builder: (context) {
                  bodyBottomViewInsets = MediaQuery.viewInsetsOf(
                    context,
                  ).bottom;

                  return SizedBox(key: bodyKey);
                },
              ),
              footerBuilder: (context, padding) {
                footerBottomViewInsets = MediaQuery.viewInsetsOf(
                  context,
                ).bottom;

                return SizedBox(key: footerKey, height: footerHeight);
              },
            ),
          ),
        );

        final bodyBottom = bodyKey.getGlobalRect()!.bottom;
        final footerBottom = footerKey.getGlobalRect()!.bottom;

        expect(
          bodyBottom,
          ScaffoldWidgetTestsWrapper.height -
              ScaffoldWidgetTestsWrapper.mediaQueryViewInsetsValue -
              footerHeight,
        );
        expect(bodyBottomViewInsets, isZero);

        expect(
          footerBottom,
          ScaffoldWidgetTestsWrapper.height -
              ScaffoldWidgetTestsWrapper.mediaQueryViewInsetsValue,
        );
        expect(footerBottomViewInsets, isZero);
      },
    );

    testWidgets(
      'scaffold leaves viewInsets for body and footer with resizeToAvoidBottomInsets=false',
      (tester) async {
        final bodyKey = GlobalKey();
        final footerKey = GlobalKey();

        const footerHeight = 10.0;
        double? bodyBottomViewInsets;
        double? footerBottomViewInsets;

        await tester.pumpWidget(
          ScaffoldWidgetTestsWrapper(
            useMediaQueryViewInsets: true,
            scaffold: AppScaffold(
              resizeToAvoidBottomInset: false,
              useBodyPadding: false,
              useSafeArea: false,
              body: Builder(
                builder: (context) {
                  bodyBottomViewInsets = MediaQuery.viewInsetsOf(
                    context,
                  ).bottom;

                  return SizedBox(key: bodyKey);
                },
              ),
              footerBuilder: (context, padding) {
                footerBottomViewInsets = MediaQuery.viewInsetsOf(
                  context,
                ).bottom;

                return SizedBox(key: footerKey, height: footerHeight);
              },
            ),
          ),
        );

        final bodyBottom = bodyKey.getGlobalRect()!.bottom;
        final footerBottom = footerKey.getGlobalRect()!.bottom;

        expect(bodyBottom, ScaffoldWidgetTestsWrapper.height - footerHeight);
        expect(
          bodyBottomViewInsets,
          ScaffoldWidgetTestsWrapper.mediaQueryViewInsetsValue - footerHeight,
        );

        expect(footerBottom, ScaffoldWidgetTestsWrapper.height);
        expect(
          footerBottomViewInsets,
          ScaffoldWidgetTestsWrapper.mediaQueryViewInsetsValue,
        );
      },
    );

    testWidgets(
      'using safe area has bottom padding when contents do not scroll but are under bottom padding',
      (tester) async {
        final scrollController = ScrollController();
        double? bottomSafeAreaPadding;

        await tester.pumpWidget(
          ScaffoldWidgetTestsWrapper(
            useMediaQueryPadding: true,
            scaffold: AppScaffold.widgets(
              scrollController: scrollController,
              useBodyPadding: false,
              children: [
                SizedBox(
                  height:
                      ScaffoldWidgetTestsWrapper.height -
                      ScaffoldWidgetTestsWrapper.mediaQueryPadding.bottom -
                      5,
                  child: Builder(
                    builder: (context) {
                      bottomSafeAreaPadding = MediaQuery.viewPaddingOf(
                        context,
                      ).bottom;

                      return const SizedBox();
                    },
                  ),
                ),
              ],
            ),
          ),
        );

        expect(scrollController.position.minScrollExtent, isZero);
        expect(scrollController.position.maxScrollExtent, greaterThan(0));
        expect(bottomSafeAreaPadding, isZero);
      },
    );

    testWidgets('.widgets footerBuilder padding does not include top', (
      tester,
    ) async {
      EdgeInsets? resolvedFooterPadding;

      await tester.pumpWidget(
        ScaffoldWidgetTestsWrapper(
          useMediaQueryPadding: true,
          scaffold: AppScaffold.widgets(
            children: const [],
            footerBuilder: (context, overlapsContent, padding) {
              resolvedFooterPadding = padding;

              return const FooterPlaceholder();
            },
          ),
        ),
      );

      expect(
        resolvedFooterPadding,
        ScaffoldWidgetTestsWrapper.mediaQueryPadding.copyWith(top: 0),
      );
    });
  });
}
