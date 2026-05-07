import 'package:app_design_system/src/styleguide/colors.dart';
import 'package:flutter/widgets.dart';

enum AppDividerSize {
  s1(1),
  s2(2);

  const AppDividerSize(this.value);

  final double value;
}

class AppDivider extends StatelessWidget {
  const AppDivider.vertical({super.key, this.size = AppDividerSize.s1})
    : _axis = Axis.vertical;

  const AppDivider.horizontal({super.key, this.size = AppDividerSize.s1})
    : _axis = Axis.horizontal;

  final AppDividerSize size;
  final Axis _axis;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: switch (_axis) {
        Axis.horizontal => null,
        Axis.vertical => size.value,
      },
      height: switch (_axis) {
        Axis.horizontal => size.value,
        Axis.vertical => null,
      },
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(1),
        color: context.colors.foregroundDefaultQuaternary,
      ),
    );
  }
}
