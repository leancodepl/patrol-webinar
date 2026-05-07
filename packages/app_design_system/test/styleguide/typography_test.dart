import 'package:app_design_system/app_design_system.dart';
import 'package:flutter/widgets.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import '../test_app.dart';

final _surface = Surface.canvas(width: 1000, height: 600);

void main() {
  testGoldens('AppColors', (tester) async {
    await pumpWidgetBuilder(
      tester,
      Builder(
        builder: (context) {
          return GoldenTable(
            cellAlignment: GoldenTableCellAlignment.stretch,
            header: const GoldenTableHeader(
              headerName: 'Example',
              cellNames: ['Sentence'],
            ),
            rows: AppTextStyles.values.map((style) {
              return GoldenTableRow(
                details: style.styleName,
                cells: [
                  AppText(
                    'Zważywszy, że uznanie',
                    color: context.colors.foregroundDefaultPrimary,
                    style: style,
                  ),
                ],
              );
            }).toList(),
          );
        },
      ),
      surface: _surface,
    );

    await tester.pumpAndSettle();

    await widgetsMatchGoldensSingle(tester, 'typography', surface: _surface);
  });
}
