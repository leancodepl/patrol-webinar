import 'package:app_design_system/app_design_system.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import '../test_app.dart';

final _surface = Surface.canvas(width: 600, height: 800);

void main() {
  group('AppText', () {
    testGoldens('varied max lines', (tester) async {
      final keys = GlobalKeyGenerator();

      const text =
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
          ' Quisque euismod, est nec finibus cursus, quam lectus efficitur'
          ' ipsum, sit amet blandit dui ipsum vitae elit. Nam non auctor lorem.'
          ' Morbi luctus turpis vel aliquet pulvinar.';

      await pumpWidgetBuilder(
        tester,
        GoldenTable(
          cellFlex: 250,
          cellAlignment: GoldenTableCellAlignment.stretch,
          header: const GoldenTableHeader(
            headerName: 'Variant',
            cellNames: ['AppText', 'AppSelectableText'],
          ),
          rows: [
            ...[1, 2, 3, null].map(
              (maxLines) => GoldenTableRow(
                crossAxisAlignment: CrossAxisAlignment.start,
                details: 'Max Lines: $maxLines',
                cells: [
                  AppText(
                    text,
                    style: AppTextStyles.bodyDefault,
                    maxLines: maxLines,
                  ),
                  AppSelectableText(
                    text,
                    style: AppTextStyles.bodyDefault,
                    maxLines: maxLines,
                  ),
                ],
              ),
            ),
          ],
        ),
        surface: _surface,
      );

      await tester.tapDownAll(keys);

      await tester.pumpAndSettle();

      await widgetsMatchGoldens(
        tester,
        'text_varied_max_lines',
        surface: _surface,
      );
    });
  });
}
