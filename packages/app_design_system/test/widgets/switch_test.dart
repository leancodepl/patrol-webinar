import 'package:app_design_system/app_design_system.dart';
import 'package:flutter/widgets.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import '../test_app.dart';

final _surface = Surface.canvas(width: 1500, height: 400);

enum _Value { first, second, third, dichloromethane, fifth, sixth }

void main() {
  testGoldens('AppSwitch', (tester) async {
    final keys = GlobalKeyGenerator();

    List<AppSwitchOption<_Value>> options(int length) => [
      AppSwitchOption.text(
        text: _Value.values.first.name,
        value: _Value.values.first,
      ),
      AppSwitchOption.icon(
        icon: AppStandardIcons.faceContent,
        value: _Value.values.skip(1).first,
        semanticsLabel: 'Icon',
      ),
      ..._Value.values
          .skip(2)
          .map((value) => AppSwitchOption.text(text: value.name, value: value)),
    ].sublist(0, length).toList();

    await pumpWidgetBuilder(
      tester,
      GoldenTable(
        cellFlex: 300,
        cellAlignment: GoldenTableCellAlignment.stretch,
        header: const GoldenTableHeader(
          headerName: 'Type',
          cellNames: ['Fit', 'Fill'],
        ),
        rows: List.generate(6, (index) {
          final length = index + 1;
          final optionList = options(length);
          final value = optionList[(length / 2).floor()].value;

          return GoldenTableRow(
            details:
                'Options: $length\n'
                'Current: ${value.name}',
            cells: [
              for (final type in AppSwitchType.values)
                Center(
                  child: AppSwitch(
                    options: optionList,
                    value: value,
                    type: type,
                    onChanged: (_) {},
                  ),
                ),
            ],
          );
        }),
      ),
      surface: _surface,
    );

    await tester.tapDownAll(keys);

    await tester.pumpAndSettle();

    await widgetsMatchGoldens(tester, 'switch', surface: _surface);
  });
}
