import 'package:app_design_system/src/styleguide/colors.dart';
import 'package:flutter/widgets.dart';

class AppListDivider extends StatelessWidget {
  const AppListDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      height: 1,
      decoration: BoxDecoration(
        color: colors.foregroundDefaultQuaternary,
        borderRadius: BorderRadius.circular(1),
      ),
    );
  }
}
