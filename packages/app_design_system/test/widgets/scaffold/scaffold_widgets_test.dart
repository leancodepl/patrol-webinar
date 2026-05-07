// Better readibility for tests
// ignore_for_file: avoid_redundant_argument_values

import 'package:app_design_system/app_design_system.dart';
import 'package:app_design_system/src/utils/global_key_extensions.dart';
import 'package:app_design_system/src/widgets/scaffold/widgets/pinned_bottom_segment_layout.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'common.dart';

void main() {
  group('AppScaffold.widgets', () {
    const footerThatDoesNotHandleBottomSafeArea = SizedBox();

    testWidgets('builds with top bar, FAB and footer', (tester) async {
      const topBarKey = Key('AppTopBar');
      const fabKey = Key('FloatingActionButton');
      const footerKey = Key('Footer');

      // It needs to be short enough to not have scroll extent
      final tiles = getKeyedPlaceholderTiles(5);

      await tester.pumpWidget(
        ScaffoldWidgetTestsWrapper(
          scaffold: AppScaffold.widgets(
            topBar: const AppTopBarPlaceholder(key: topBarKey),
            floatingActionButton: const FabPlaceholder(key: fabKey),
            footerBuilder: (context, _, _) =>
                const FooterPlaceholder(key: footerKey),
            children: [for (final tile in tiles.values) tile],
          ),
        ),
      );

      expect(find.byKey(topBarKey), findsOneWidget);
      expect(find.byKey(fabKey), findsOneWidget);
      expect(find.byKey(footerKey), findsOneWidget);

      for (final tile in tiles.entries) {
        expect(find.byKey(tile.key), findsOneWidget);
      }
    });

    testWidgets('builds without body padding on useBodyPadding = false', (
      tester,
    ) async {
      // It needs to be long enough to have scroll extent
      final tiles = getKeyedPlaceholderTiles(25);
      final controllerWithOffset = ScrollController(
        initialScrollOffset: tiles.length * placeholderTileHeight,
      );

      await tester.pumpWidget(
        ScaffoldWidgetTestsWrapper(
          scaffold: AppScaffold.widgets(
            scrollController: controllerWithOffset,
            useBodyPadding: false,
            useSafeArea: false,
            children: [for (final tile in tiles.values) tile],
          ),
        ),
      );

      await tester.pumpAndSettle();

      final bodyBottomPosition = tester
          .getBottomRight(find.byKey(tiles.entries.last.key))
          .dy;

      expect(bodyBottomPosition, ScaffoldWidgetTestsWrapper.height);
    });

    testWidgets('builds with body padding on useBodyPadding = true', (
      tester,
    ) async {
      // It needs to be long enough to have scroll extent
      final tiles = getKeyedPlaceholderTiles(25);
      final controllerWithOffset = ScrollController(
        initialScrollOffset: tiles.length * placeholderTileHeight,
      );

      await tester.pumpWidget(
        ScaffoldWidgetTestsWrapper(
          scaffold: AppScaffold.widgets(
            scrollController: controllerWithOffset,
            useBodyPadding: true,
            useSafeArea: false,
            children: [for (final tile in tiles.values) tile],
          ),
        ),
      );

      await tester.pumpAndSettle();

      final bodyBottomPosition = tester
          .getBottomRight(find.byKey(tiles.entries.last.key))
          .dy;

      expect(
        bodyBottomPosition,
        ScaffoldWidgetTestsWrapper.height - AppScaffold.bodyPadding.value,
      );
    });

    testWidgets('builds without body padding on useSafeArea = false', (
      tester,
    ) async {
      // It needs to be long enough to have scroll extent
      final tiles = getKeyedPlaceholderTiles(25);
      final controllerWithOffset = ScrollController(
        initialScrollOffset: tiles.length * placeholderTileHeight,
      );

      await tester.pumpWidget(
        ScaffoldWidgetTestsWrapper(
          useMediaQueryPadding: true,
          scaffold: AppScaffold.widgets(
            scrollController: controllerWithOffset,
            useBodyPadding: false,
            useSafeArea: false,
            children: [for (final tile in tiles.values) tile],
          ),
        ),
      );

      await tester.pumpAndSettle();

      final bodyBottomPosition = tester
          .getBottomRight(find.byKey(tiles.entries.last.key))
          .dy;

      expect(bodyBottomPosition, ScaffoldWidgetTestsWrapper.height);
    });

    testWidgets('builds with body padding on useSafeArea = true', (
      tester,
    ) async {
      // It needs to be long enough to have scroll extent
      final tiles = getKeyedPlaceholderTiles(25);
      final controllerWithOffset = ScrollController(
        initialScrollOffset: tiles.length * placeholderTileHeight,
      );

      await tester.pumpWidget(
        ScaffoldWidgetTestsWrapper(
          useMediaQueryPadding: true,
          scaffold: AppScaffold.widgets(
            scrollController: controllerWithOffset,
            useBodyPadding: false,
            useSafeArea: true,
            children: [for (final tile in tiles.values) tile],
          ),
        ),
      );

      await tester.pumpAndSettle();

      final bodyBottomPosition = tester
          .getBottomRight(find.byKey(tiles.entries.last.key))
          .dy;

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
            scaffold: AppScaffold.widgets(
              useBodyPadding: false,
              useSafeArea: false,
              children: [
                Builder(
                  builder: (context) {
                    resolvedBodySafePadding = MediaQuery.paddingOf(context);

                    return const SizedBox();
                  },
                ),
              ],
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
      'passes updated safe area through MediaQuery to body on useSafeArea = true',
      (tester) async {
        EdgeInsets? resolvedBodySafePadding;

        await tester.pumpWidget(
          ScaffoldWidgetTestsWrapper(
            useMediaQueryPadding: true,
            scaffold: AppScaffold.widgets(
              topBar: const AppTopBarPlaceholder(),
              useSafeArea: true,
              useBodyPadding: false,
              children: [
                Builder(
                  builder: (context) {
                    resolvedBodySafePadding = MediaQuery.paddingOf(context);

                    return const SizedBox();
                  },
                ),
              ],
            ),
          ),
        );

        expect(resolvedBodySafePadding, EdgeInsets.zero);
      },
    );

    testWidgets(
      'passes updated safe area with preserved top padding through MediaQuery to body on useSafeArea = true and topBar == null',
      (tester) async {
        EdgeInsets? resolvedBodySafePadding;

        await tester.pumpWidget(
          ScaffoldWidgetTestsWrapper(
            useMediaQueryPadding: true,
            scaffold: AppScaffold.widgets(
              useSafeArea: true,
              useBodyPadding: false,
              children: [
                Builder(
                  builder: (context) {
                    resolvedBodySafePadding = MediaQuery.paddingOf(context);

                    return const SizedBox();
                  },
                ),
              ],
            ),
          ),
        );

        expect(
          resolvedBodySafePadding,
          EdgeInsets.only(
            top: ScaffoldWidgetTestsWrapper.mediaQueryPadding.top,
          ),
        );
      },
    );

    testWidgets(
      'passes updated bottom safe area for fab to body through MediaQuery on useSafeArea = false',
      (tester) async {
        EdgeInsets? resolvedBodySafePadding;

        await tester.pumpWidget(
          ScaffoldWidgetTestsWrapper(
            useMediaQueryPadding: true,
            scaffold: AppScaffold.widgets(
              useBodyPadding: false,
              useSafeArea: false,
              floatingActionButton: const FabPlaceholder(),
              children: [
                Builder(
                  builder: (context) {
                    resolvedBodySafePadding = MediaQuery.paddingOf(context);

                    return const SizedBox();
                  },
                ),
              ],
            ),
          ),
        );

        expect(
          resolvedBodySafePadding,
          ScaffoldWidgetTestsWrapper.mediaQueryPadding +
              EdgeInsets.only(
                bottom:
                    FabPlaceholder.height +
                    PinnedBottomSegmentHeight
                        .floatingActionButtonPadding
                        .vertical,
              ),
        );
      },
    );

    testWidgets(
      'builds body without padding regardless of useSafeArea param if there is a footer',
      (tester) async {
        // It needs to be long enough to have max scroll extent
        final tiles = getKeyedPlaceholderTiles(25);
        final controllerWithOffset = ScrollController(
          initialScrollOffset: tiles.length * placeholderTileHeight,
        );

        await tester.pumpWidget(
          ScaffoldWidgetTestsWrapper(
            useMediaQueryPadding: true,
            scaffold: AppScaffold.widgets(
              scrollController: controllerWithOffset,
              useBodyPadding: false,
              useSafeArea: true,
              footerBuilder: (context, _, _) =>
                  footerThatDoesNotHandleBottomSafeArea,
              children: [for (final tile in tiles.values) tile],
            ),
          ),
        );

        await tester.pumpAndSettle();

        final bodyBottomPosition = tester
            .getBottomRight(find.byKey(tiles.entries.last.key))
            .dy;

        expect(bodyBottomPosition, ScaffoldWidgetTestsWrapper.height);
      },
    );

    testWidgets('builds with FAB padding on useSafeArea = true', (
      tester,
    ) async {
      final fabKey = GlobalKey();

      final tiles = getKeyedPlaceholderTiles(5);

      await tester.pumpWidget(
        ScaffoldWidgetTestsWrapper(
          useMediaQueryPadding: true,
          scaffold: AppScaffold.widgets(
            useSafeArea: true,
            floatingActionButton: FabPlaceholder(key: fabKey),
            footerBuilder: (context, _, _) =>
                footerThatDoesNotHandleBottomSafeArea,
            children: [for (final tile in tiles.values) tile],
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

    testWidgets('builds with FAB padding even on useSafeArea = false', (
      tester,
    ) async {
      final fabKey = GlobalKey();

      final tiles = getKeyedPlaceholderTiles(5);

      await tester.pumpWidget(
        ScaffoldWidgetTestsWrapper(
          useMediaQueryPadding: true,
          scaffold: AppScaffold.widgets(
            useSafeArea: false,
            floatingActionButton: FabPlaceholder(key: fabKey),
            children: [for (final tile in tiles.values) tile],
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

    testWidgets(
      'builds with horizontal safe area padding on useSafeArea = true',
      (tester) async {
        final bodyKey = GlobalKey();

        await tester.pumpWidget(
          ScaffoldWidgetTestsWrapper(
            useMediaQueryPadding: true,
            scaffold: AppScaffold.widgets(
              useSafeArea: true,
              useBodyPadding: false,
              children: [
                SizedBox(
                  key: bodyKey,
                  // It's not visible for `tester` if doesn't have height
                  height: 50,
                ),
              ],
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
          scaffold: AppScaffold.widgets(
            useSafeArea: true,
            useBodyPadding: false,
            children: [
              Builder(
                builder: (context) {
                  resolvedBodySafePadding = MediaQuery.paddingOf(context);

                  return const SizedBox();
                },
              ),
            ],
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
            scaffold: AppScaffold.widgets(
              useSafeArea: false,
              useBodyPadding: false,
              children: [
                SizedBox(
                  key: bodyKey,
                  // It's not visible for `tester` if doesn't have height
                  height: 50,
                ),
              ],
            ),
          ),
        );

        await tester.pumpAndSettle();

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
            scaffold: AppScaffold.widgets(
              useSafeArea: false,
              useBodyPadding: false,
              children: [
                Builder(
                  builder: (context) {
                    resolvedBodySafePadding = MediaQuery.paddingOf(context);

                    return const SizedBox();
                  },
                ),
              ],
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

    group('with footer behavior set as bottomPinned', () {
      testWidgets(
        'footer sticks to the bottom of the screen when there is no scroll extent',
        (tester) async {
          const footerKey = Key('Footer');

          final tiles = getKeyedPlaceholderTiles(5);

          await tester.pumpWidget(
            ScaffoldWidgetTestsWrapper(
              scaffold: AppScaffold.widgets(
                footerBehavior: AppScaffoldFooterBehavior.bottomPinned,
                footerBuilder: (context, _, _) =>
                    const FooterPlaceholder(key: footerKey),
                children: [for (final tile in tiles.values) tile],
              ),
            ),
          );

          final footerTopPosition = tester
              .getTopRight(find.byKey(footerKey))
              .dy;

          expect(
            footerTopPosition,
            ScaffoldWidgetTestsWrapper.height - FooterPlaceholder.height,
          );
        },
      );

      testWidgets(
        'footer sticks to the bottom of the screen when there is scroll extent',
        (tester) async {
          const footerKey = Key('Footer');

          // It needs to be long enough to have max scroll extent
          final tiles = getKeyedPlaceholderTiles(25);

          await tester.pumpWidget(
            ScaffoldWidgetTestsWrapper(
              scaffold: AppScaffold.widgets(
                footerBehavior: AppScaffoldFooterBehavior.bottomPinned,
                footerBuilder: (context, _, _) =>
                    const FooterPlaceholder(key: footerKey),
                children: [for (final tile in tiles.values) tile],
              ),
            ),
          );

          final footerTopPosition = tester
              .getTopRight(find.byKey(footerKey))
              .dy;

          expect(
            footerTopPosition,
            ScaffoldWidgetTestsWrapper.height - FooterPlaceholder.height,
          );
        },
      );

      testWidgets(
        'footer sticks to the bottom of the screen on max extent reached',
        (tester) async {
          const footerKey = Key('Footer');

          // It needs to be long enough to have max scroll extent
          final tiles = getKeyedPlaceholderTiles(25);

          final controllerWithOffset = ScrollController(
            initialScrollOffset: tiles.length * placeholderTileHeight,
          );

          await tester.pumpWidget(
            ScaffoldWidgetTestsWrapper(
              scaffold: AppScaffold.widgets(
                scrollController: controllerWithOffset,
                footerBehavior: AppScaffoldFooterBehavior.bottomPinned,
                footerBuilder: (context, _, _) =>
                    const FooterPlaceholder(key: footerKey),
                children: [for (final tile in tiles.values) tile],
              ),
            ),
          );

          await tester.pumpAndSettle();

          final footerTopPosition = tester
              .getTopRight(find.byKey(footerKey))
              .dy;

          expect(
            footerTopPosition,
            ScaffoldWidgetTestsWrapper.height - FooterPlaceholder.height,
          );

          controllerWithOffset.dispose();
        },
      );

      testWidgets(
        'footer sticks to the bottom of the screen on bottom overscroll',
        (tester) async {
          const footerKey = Key('Footer');

          // It needs to be long enough to have max scroll extent
          final tiles = getKeyedPlaceholderTiles(25);

          final controllerWithOffset = ScrollController(
            initialScrollOffset: tiles.length * placeholderTileHeight,
          );

          await tester.pumpWidget(
            ScaffoldWidgetTestsWrapper(
              scaffold: AppScaffold.widgets(
                scrollController: controllerWithOffset,
                footerBehavior: AppScaffoldFooterBehavior.bottomPinned,
                footerBuilder: (context, _, _) =>
                    const FooterPlaceholder(key: footerKey),
                children: [for (final tile in tiles.values) tile],
              ),
            ),
          );

          await tester.pumpAndSettle();

          final footerBottomPosition = tester
              .getBottomRight(find.byKey(footerKey))
              .dy;

          expect(footerBottomPosition, ScaffoldWidgetTestsWrapper.height);
        },
      );

      testWidgets(
        'body content builds with bottom padding equal to footer height',
        (tester) async {
          const footerKey = Key('Footer');

          // It needs to be long enough to have max scroll extent
          final tiles = getKeyedPlaceholderTiles(25);

          final controllerWithOffset = ScrollController(
            initialScrollOffset: tiles.length * placeholderTileHeight,
          );

          await tester.pumpWidget(
            ScaffoldWidgetTestsWrapper(
              scaffold: AppScaffold.widgets(
                scrollController: controllerWithOffset,
                useBodyPadding: false,
                footerBehavior: AppScaffoldFooterBehavior.bottomPinned,
                footerBuilder: (context, _, _) =>
                    const FooterPlaceholder(key: footerKey),
                children: [for (final tile in tiles.values) tile],
              ),
            ),
          );

          await tester.pumpAndSettle();

          final lastTileBottomPosition = tester
              .getBottomRight(find.byKey(tiles.entries.last.key))
              .dy;

          expect(
            lastTileBottomPosition,
            ScaffoldWidgetTestsWrapper.height - FooterPlaceholder.height,
          );

          controllerWithOffset.dispose();
        },
      );

      testWidgets(
        'body content builds with bottom padding equal to footer and floating action button height',
        (tester) async {
          const footerKey = Key('Footer');
          const fabKey = Key('FloatingActionButton');

          // It needs to be long enough to have max scroll extent
          final tiles = getKeyedPlaceholderTiles(25);

          final controllerWithOffset = ScrollController(
            initialScrollOffset: tiles.length * placeholderTileHeight,
          );

          await tester.pumpWidget(
            ScaffoldWidgetTestsWrapper(
              scaffold: AppScaffold.widgets(
                scrollController: controllerWithOffset,
                useBodyPadding: false,
                floatingActionButton: const FabPlaceholder(key: fabKey),
                footerBehavior: AppScaffoldFooterBehavior.bottomPinned,
                footerBuilder: (context, _, _) =>
                    const FooterPlaceholder(key: footerKey),
                children: [for (final tile in tiles.values) tile],
              ),
            ),
          );

          await tester.pumpAndSettle();

          final lastTileBottomPosition = tester
              .getBottomRight(find.byKey(tiles.entries.last.key))
              .dy;

          expect(
            lastTileBottomPosition,
            ScaffoldWidgetTestsWrapper.height -
                FooterPlaceholder.height -
                FabPlaceholder.height -
                PinnedBottomSegmentHeight.floatingActionButtonPadding.vertical,
          );
        },
      );
    });

    group('with footer behavior set as bottomPushed', () {
      testWidgets(
        'footer sticks to the bottom of the screen when there is no scroll extent',
        (tester) async {
          const footerKey = Key('Footer');

          final tiles = getKeyedPlaceholderTiles(5);

          await tester.pumpWidget(
            ScaffoldWidgetTestsWrapper(
              scaffold: AppScaffold.widgets(
                footerBehavior: AppScaffoldFooterBehavior.bottomPushed,
                footerBuilder: (context, _, _) =>
                    const FooterPlaceholder(key: footerKey),
                children: [for (final tile in tiles.values) tile],
              ),
            ),
          );

          await tester.pumpAndSettle();

          final footerTopPosition = tester
              .getTopRight(find.byKey(footerKey))
              .dy;

          expect(
            footerTopPosition,
            ScaffoldWidgetTestsWrapper.height - FooterPlaceholder.height,
          );
        },
      );

      testWidgets(
        'footer is partially pushed off the screen when there is some scroll extent',
        (tester) async {
          const footerKey = Key('Footer');

          // It needs to be short enough to not have max scroll extent but long
          // enough to partially push the footer off the screen
          final tiles = getKeyedPlaceholderTiles(9);

          await tester.pumpWidget(
            ScaffoldWidgetTestsWrapper(
              scaffold: AppScaffold.widgets(
                footerBehavior: AppScaffoldFooterBehavior.bottomPushed,
                footerBuilder: (context, _, _) =>
                    const FooterPlaceholder(key: footerKey),
                children: [for (final tile in tiles.values) tile],
              ),
            ),
          );

          expect(find.byKey(footerKey), findsOneWidget);

          final footerTopPosition = tester
              .getTopRight(find.byKey(footerKey))
              .dy;

          expect(
            footerTopPosition,
            greaterThan(
              ScaffoldWidgetTestsWrapper.height - FooterPlaceholder.height,
            ),
          );
        },
      );

      testWidgets(
        'footer is completely pushed off the screen when there is a big scroll extent',
        (tester) async {
          const footerKey = Key('Footer');

          // It needs to be long enough to have scroll extent
          final tiles = getKeyedPlaceholderTiles(25);

          await tester.pumpWidget(
            ScaffoldWidgetTestsWrapper(
              scaffold: AppScaffold.widgets(
                footerBehavior: AppScaffoldFooterBehavior.bottomPushed,
                footerBuilder: (context, _, _) =>
                    const FooterPlaceholder(key: footerKey),
                children: [for (final tile in tiles.values) tile],
              ),
            ),
          );

          expect(find.byKey(footerKey), findsNothing);
        },
      );

      testWidgets('footer is visible at the end of long scrollable list', (
        tester,
      ) async {
        const footerKey = Key('Footer');

        // It needs to be long enough to have scroll extent
        final tiles = getKeyedPlaceholderTiles(25);

        final controllerWithOffset = ScrollController(
          initialScrollOffset: tiles.length * placeholderTileHeight,
        );

        await tester.pumpWidget(
          ScaffoldWidgetTestsWrapper(
            scaffold: AppScaffold.widgets(
              footerBehavior: AppScaffoldFooterBehavior.bottomPushed,
              scrollController: controllerWithOffset,
              footerBuilder: (context, _, _) =>
                  const FooterPlaceholder(key: footerKey),
              children: [for (final tile in tiles.values) tile],
            ),
          ),
        );

        await tester.pumpAndSettle();

        expect(find.byKey(footerKey), findsOneWidget);
      });
    });

    group('with footer behavior set as endPinned', () {
      testWidgets('footer is below content when there is no scroll extent', (
        tester,
      ) async {
        const footerKey = Key('Footer');

        // It needs to be short enough to not have max scroll extent
        final tiles = getKeyedPlaceholderTiles(5);

        await tester.pumpWidget(
          ScaffoldWidgetTestsWrapper(
            scaffold: AppScaffold.widgets(
              useBodyPadding: false,
              useSafeArea: false,
              footerBehavior: AppScaffoldFooterBehavior.endPinned,
              footerBuilder: (context, _, _) =>
                  const FooterPlaceholder(key: footerKey),
              children: [for (final tile in tiles.values) tile],
            ),
          ),
        );

        final footerTopPosition = tester.getTopRight(find.byKey(footerKey)).dy;

        expect(footerTopPosition, tiles.length * placeholderTileHeight);
      });

      testWidgets('FAB is pinned to bottom when there is no scroll extent', (
        tester,
      ) async {
        const fabKey = Key('FloatingActionButton');

        // It needs to be short enough to not have max scroll extent
        final tiles = getKeyedPlaceholderTiles(5);

        await tester.pumpWidget(
          ScaffoldWidgetTestsWrapper(
            scaffold: AppScaffold.widgets(
              useBodyPadding: false,
              footerBehavior: AppScaffoldFooterBehavior.endPinned,
              floatingActionButton: const FabPlaceholder(key: fabKey),
              footerBuilder: (context, _, _) => const FooterPlaceholder(),
              children: [for (final tile in tiles.values) tile],
            ),
          ),
        );

        final fabTopPosition = tester.getTopRight(find.byKey(fabKey)).dy;

        expect(
          fabTopPosition,
          ScaffoldWidgetTestsWrapper.height -
              FabPlaceholder.height -
              PinnedBottomSegmentHeight.floatingActionButtonPadding.bottom,
        );
      });

      testWidgets('footer is pinned to bottom when there is scroll extent', (
        tester,
      ) async {
        const footerKey = Key('Footer');
        const fabKey = Key('FloatingActionButton');

        // It needs to be long enough to have scroll extent
        final tiles = getKeyedPlaceholderTiles(15);

        await tester.pumpWidget(
          ScaffoldWidgetTestsWrapper(
            scaffold: AppScaffold.widgets(
              useBodyPadding: false,
              footerBehavior: AppScaffoldFooterBehavior.endPinned,
              floatingActionButton: const FabPlaceholder(key: fabKey),
              footerBuilder: (context, _, _) =>
                  const FooterPlaceholder(key: footerKey),
              children: [for (final tile in tiles.values) tile],
            ),
          ),
        );

        await tester.pumpAndSettle();

        final footerBottomPosition = tester
            .getBottomRight(find.byKey(footerKey))
            .dy;

        expect(footerBottomPosition, ScaffoldWidgetTestsWrapper.height);
      });

      testWidgets(
        'FAB is pinned to bottom above footer when there is scroll extent',
        (tester) async {
          const fabKey = Key('FloatingActionButton');

          // It needs to be long enough to have scroll extent
          final tiles = getKeyedPlaceholderTiles(25);

          await tester.pumpWidget(
            ScaffoldWidgetTestsWrapper(
              scaffold: AppScaffold.widgets(
                useBodyPadding: false,
                footerBehavior: AppScaffoldFooterBehavior.endPinned,
                floatingActionButton: const FabPlaceholder(key: fabKey),
                footerBuilder: (context, _, _) => const FooterPlaceholder(),
                children: [for (final tile in tiles.values) tile],
              ),
            ),
          );

          await tester.pumpAndSettle();

          final fabBottomPosition = tester
              .getBottomRight(find.byKey(fabKey))
              .dy;

          expect(
            fabBottomPosition,
            ScaffoldWidgetTestsWrapper.height -
                FooterPlaceholder.height -
                PinnedBottomSegmentHeight.floatingActionButtonPadding.bottom,
          );
        },
      );

      testWidgets('footer is dragged with content on bottom overscroll', (
        tester,
      ) async {
        debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

        const footerKey = Key('Footer');

        // It needs to be long enough to have scroll extent
        final tiles = getKeyedPlaceholderTiles(15);

        final controllerWithOffset = ScrollController(
          initialScrollOffset: tiles.length * placeholderTileHeight,
        );

        await tester.pumpWidget(
          ScaffoldWidgetTestsWrapper(
            scaffold: AppScaffold.widgets(
              useBodyPadding: false,
              footerBehavior: AppScaffoldFooterBehavior.endPinned,
              scrollController: controllerWithOffset,
              footerBuilder: (context, _, _) =>
                  const FooterPlaceholder(key: footerKey),
              children: [for (final tile in tiles.values) tile],
            ),
          ),
        );

        await tester.pumpAndSettle();

        final gesture = await tester.startGesture(
          tester.getCenter(find.byKey(tiles.entries.last.key)),
        );

        await gesture.moveBy(const Offset(0, -300));

        await tester.pumpAndSettle();

        final footerTopPosition = tester.getTopRight(find.byKey(footerKey)).dy;

        final lastTileBottomPosition = tester
            .getBottomRight(find.byKey(tiles.entries.last.key))
            .dy;

        expect(footerTopPosition, equals(lastTileBottomPosition));

        debugDefaultTargetPlatformOverride = null;
      });

      testWidgets('FAB sticks to bottom on overscroll', (tester) async {
        debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

        const fabKey = Key('FloatingActionButton');

        // It needs to be long enough to have scroll extent
        final tiles = getKeyedPlaceholderTiles(15);

        final controllerWithOffset = ScrollController(
          initialScrollOffset: tiles.length * placeholderTileHeight,
        );

        await tester.pumpWidget(
          ScaffoldWidgetTestsWrapper(
            scaffold: AppScaffold.widgets(
              useBodyPadding: false,
              footerBehavior: AppScaffoldFooterBehavior.endPinned,
              scrollController: controllerWithOffset,
              floatingActionButton: const FabPlaceholder(key: fabKey),
              footerBuilder: (context, _, _) => const FooterPlaceholder(),
              children: [for (final tile in tiles.values) tile],
            ),
          ),
        );

        await tester.pumpAndSettle();

        final gesture = await tester.startGesture(
          tester.getCenter(find.byKey(tiles.entries.last.key)),
        );

        await gesture.moveBy(const Offset(0, -300));

        await tester.pumpAndSettle();

        final fabBottomPosition = tester.getBottomRight(find.byKey(fabKey)).dy;

        expect(
          fabBottomPosition,
          ScaffoldWidgetTestsWrapper.height -
              PinnedBottomSegmentHeight.floatingActionButtonPadding.bottom,
        );

        debugDefaultTargetPlatformOverride = null;
      });
    });
  });
}
