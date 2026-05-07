import 'package:app_design_system/app_design_system.dart';
import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';

import 'test_app.dart';

/// Type of constraints for a scenario in GoldenBuilder
enum AppScenarioConstraints { loose, tight }

enum AppGoldenBuilderColor { white, gray }

/// GoldenBuilder builds column/grid layout for it's children
class AppGoldenBuilder {
  /// Will output a *.png file with a grid layout in 'tests/goldens' folder.
  ///
  /// You need to specify how many columns [columns].
  factory AppGoldenBuilder.grid({
    String? name,
    required int columns,
    AppGoldenBuilderColor color = AppGoldenBuilderColor.gray,
  }) {
    return AppGoldenBuilder._(name: name, columns: columns, color: color);
  }

  /// Will output a .png file with a column layout in 'tests/goldens' folder.
  factory AppGoldenBuilder.column({
    String? name,
    AppGoldenBuilderColor color = AppGoldenBuilderColor.gray,
  }) => AppGoldenBuilder._(name: name, color: color);

  AppGoldenBuilder._({this.name, this.columns = 1, required this.color});

  /// Name of the GoldenBuilder
  final String? name;

  /// number of columns [columns] in a grid
  final int columns;

  final AppGoldenBuilderColor color;

  ///  List of tests [scenarios]  being run within GoldenBuilder
  final List<Widget> scenarios = [];

  ///  [addScenario] will add a test GoldenBuilder
  void addScenario(
    String name,
    Widget widget, {
    AppScenarioConstraints constraints = AppScenarioConstraints.tight,
  }) {
    scenarios.add(
      _Scenario(
        name: name,
        widget: switch (constraints) {
          AppScenarioConstraints.loose => Center(child: widget),
          AppScenarioConstraints.tight => widget,
        },
      ),
    );
  }

  ///  [nextRow] will fill up entire current row with blank scenarios.
  void nextRow() {
    final missingColumns = columns - scenarios.length % columns;
    for (var i = 0; i < missingColumns; i++) {
      scenarios.add(const _Scenario(name: '', widget: SizedBox.shrink()));
    }
  }

  ///  [build] will build a list of [scenarios]  with a given layout
  Widget build() {
    return Builder(
      builder: (context) => ColoredBox(
        color: switch (color) {
          AppGoldenBuilderColor.white =>
            context.colors.backgroundDefaultPrimary,
          AppGoldenBuilderColor.gray =>
            context.colors.backgroundDefaultSecondary,
        },
        child: Padding(
          padding: AppSpacings.s8.vertical,
          child: Column(
            textDirection: TextDirection.ltr,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (name case final name?) ...[
                Padding(
                  padding: AppSpacings.s8.horizontal,
                  child: GoldenText(name, style: AppTextStyles.headlineSmall),
                ),
                AppSpacings.s8.verticalSpace,
                Padding(
                  padding: AppSpacings.s8.horizontal,
                  child: const AppDivider.horizontal(),
                ),
              ],
              AppSpacings.s8.verticalSpace,
              Flexible(child: columns == 1 ? _column() : _grid()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _grid() {
    final children =
        groupBy(scenarios.indexed, (scenario) => scenario.$1 ~/ columns).values
            .map(
              (rowScenarios) => Row(
                textDirection: TextDirection.ltr,
                children: rowScenarios
                    .map((scenario) => Expanded(child: scenario.$2))
                    .toList(),
              ),
            )
            .toList();

    return Column(
      textDirection: TextDirection.ltr,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }

  Widget _column() {
    return Column(
      textDirection: TextDirection.ltr,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: scenarios,
    );
  }
}

class _Scenario extends StatelessWidget {
  const _Scenario({required this.name, required this.widget});

  final String name;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacings.s8.all,
      child: Column(
        textDirection: TextDirection.ltr,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          GoldenText(name, style: AppTextStyles.bodyStrong),
          AppSpacings.s4.verticalSpace,
          widget,
        ],
      ),
    );
  }
}
