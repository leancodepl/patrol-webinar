// We need simple colors here
// ignore_for_file: use_design_system_item_AppColors
import 'package:app_design_system/app_design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import '../../test_app.dart';
import 'common.dart';

const _surfaceHeight = 2700.0;
final _surface = Surface.canvas(width: 1950, height: _surfaceHeight);

void main() {
  group('AppScaffold', () {
    testGoldens('widgets', (tester) async {
      final keys = GlobalKeyGenerator();

      await pumpWidgetBuilder(
        tester,
        GoldenTable(
          cellFlex: 220,
          cellWrapper: (context, child) => DeviceFrameForScaffold(child: child),
          header: const GoldenTableHeader(
            headerName: 'Variant',
            cellNames: [
              'Not scrolled (no footer)',
              'Scrolled (no footer)',
              'Not scrolled (footer)',
              'Scrolled (footer)',
            ],
          ),
          rows: [
            for (final row in [
              (useSafeArea: true, useBodyPadding: true),
              (useSafeArea: false, useBodyPadding: true),
              (useSafeArea: true, useBodyPadding: false),
              (useSafeArea: false, useBodyPadding: false),
            ])
              GoldenTableRow(
                details: [
                  if (row.useSafeArea && row.useBodyPadding) 'Default',
                  if (!row.useSafeArea) 'useSafeArea: false',
                  if (!row.useBodyPadding) 'useBodyPadding: false',
                ].join('\n'),
                cells: [
                  AppScaffold.widgets(
                    topBar: const AppTopBarPlaceholder(),
                    useBodyPadding: row.useBodyPadding,
                    useSafeArea: row.useSafeArea,
                    floatingActionButton: const FabPlaceholder(),
                    children: buildPlaceholderTiles(),
                  ),
                  AppScaffold.widgets(
                    key: keys.next(),
                    topBar: const AppTopBarPlaceholder(),
                    useBodyPadding: row.useBodyPadding,
                    scrollController: ScrollController(
                      initialScrollOffset: _surfaceHeight,
                    ),
                    useSafeArea: row.useSafeArea,
                    floatingActionButton: const FabPlaceholder(),
                    children: buildPlaceholderTiles(),
                  ),
                  AppScaffold.widgets(
                    topBar: const AppTopBarPlaceholder(),
                    useBodyPadding: row.useBodyPadding,
                    useSafeArea: row.useSafeArea,
                    floatingActionButton: const FabPlaceholder(),
                    footerBuilder: (context, _, _) => const FooterPlaceholder(),
                    footerBehavior: AppScaffoldFooterBehavior.bottomPinned,
                    children: buildPlaceholderTiles(),
                  ),
                  AppScaffold.widgets(
                    key: keys.next(),
                    topBar: const AppTopBarPlaceholder(),
                    useBodyPadding: row.useBodyPadding,
                    scrollController: ScrollController(
                      initialScrollOffset: _surfaceHeight,
                    ),
                    useSafeArea: row.useSafeArea,
                    floatingActionButton: const FabPlaceholder(),
                    footerBuilder: (context, _, _) => const FooterPlaceholder(),
                    footerBehavior: AppScaffoldFooterBehavior.bottomPinned,
                    children: buildPlaceholderTiles(),
                  ),
                ],
              ),
          ],
        ),
        surface: _surface,
      );

      await tester.pumpAndSettle();

      await widgetsMatchGoldens(tester, 'scaffold', surface: _surface);
    });
  });
}
