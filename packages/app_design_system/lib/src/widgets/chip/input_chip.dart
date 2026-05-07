import 'package:app_design_system/src/styleguide/colors.dart';

import 'package:app_design_system/src/widgets/chip/chip_body.dart';
import 'package:app_design_system/src/widgets/chip/chip_colors.dart';
import 'package:flutter/widgets.dart';

class AppInputChip extends StatelessWidget {
  const AppInputChip({
    super.key,
    this.enabled = true,
    required this.label,
    required this.remove,
    this.closeButtonKey,
  });

  final bool enabled;
  final String label;
  final VoidCallback remove;
  final Key? closeButtonKey;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    final resolvedColors = _resolveColors(colors);

    return Semantics(
      container: true,
      enabled: enabled,
      child: ChipBody(
        enabled: enabled,
        label: label,
        backgroundColor: resolvedColors.backgroundColor,
        borderColor: resolvedColors.borderColor,
        textColor: resolvedColors.textColor,
        iconColor: resolvedColors.iconColor,
        onCloseTap: remove,
        closeButtonKey: closeButtonKey,
      ),
    );
  }

  ChipColors _resolveColors(AppColors colors) {
    if (!enabled) {
      return (
        textColor: colors.foregroundDisabledPrimary,
        iconColor: colors.foregroundDisabledSecondary,
        borderColor: colors.foregroundDisabledTertiary,
        backgroundColor: colors.backgroundDisabledTertiary,
      );
    }

    return (
      textColor: colors.foregroundDefaultPrimary,
      iconColor: colors.foregroundDefaultSecondary,
      borderColor: colors.foregroundDefaultQuaternary,
      backgroundColor: colors.backgroundDefaultPrimary,
    );
  }
}
