import 'package:app_design_system/src/styleguide/colors.dart';
import 'package:app_design_system/src/styleguide/spacing.dart';
import 'package:app_design_system/src/widgets/context_menu/context_menu_item.dart';
import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';

class AppContextMenuContainer extends StatelessWidget {
  const AppContextMenuContainer({super.key, required this.items});

  final List<Widget> items;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    final maxIconCount = items
        .map(
          (item) => switch (item) {
            ContextMenuItemDefault(trailingIcon: final _?, parent: true) => 2,
            ContextMenuItemDefault(trailingIcon: final _?) ||
            ContextMenuItemDefault(parent: true) => 1,
            _ => 0,
          },
        )
        .max;

    return ContextMenuMaxIconCount(
      count: maxIconCount,
      child: Container(
        decoration: BoxDecoration(
          color: colors.backgroundDefaultPrimary,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: colors.foregroundDefaultTertiary),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(7),
          child: SingleChildScrollView(
            child: IntrinsicWidth(
              child: Column(
                children: [
                  AppSpacings.s8.verticalSpace,
                  ...items,
                  AppSpacings.s8.verticalSpace,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
