import 'package:app_design_system/src/styleguide/colors.dart';
import 'package:app_design_system/src/utils/pointer_surface.dart';
import 'package:app_design_system/src/widgets/chip/chip_body.dart';
import 'package:app_design_system/src/widgets/chip/chip_colors.dart';
import 'package:flutter/widgets.dart';

class AppChoiceChip extends StatelessWidget {
  const AppChoiceChip({
    super.key,
    this.enabled = true,
    required this.selected,
    required this.label,
    required this.onTap,
  });

  final bool enabled;
  final bool selected;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Semantics(
      container: true,
      button: true,
      enabled: enabled,
      checked: selected,
      onTap: enabled ? onTap : null,
      child: AppPointerSurface(
        enabled: enabled,
        onTap: onTap,
        builder: (context, states) {
          final resolvedColors = _resolveColors(
            colors,
            pressed: states.containsPressed,
          );

          return ChipBody(
            enabled: enabled,
            label: label,
            backgroundColor: resolvedColors.backgroundColor,
            borderColor: resolvedColors.borderColor,
            textColor: resolvedColors.textColor,
          );
        },
      ),
    );
  }

  ChipColors _resolveColors(AppColors colors, {required bool pressed}) {
    if (!enabled) {
      return (
        textColor: colors.foregroundDisabledPrimary,
        iconColor: null,
        borderColor: colors.foregroundDisabledTertiary,
        backgroundColor: colors.backgroundDisabledTertiary,
      );
    }

    if (selected) {
      return (
        textColor: pressed
            ? colors.foregroundInversePrimaryPressed
            : colors.foregroundInversePrimary,
        iconColor: null,
        borderColor: colors.foregroundActiveSecondary.transparent,
        backgroundColor: pressed
            ? colors.backgroundActivePrimaryPressed
            : colors.backgroundActivePrimary,
      );
    }

    return (
      textColor: pressed
          ? colors.foregroundDefaultPrimaryPressed
          : colors.foregroundDefaultPrimary,
      iconColor: null,
      borderColor: colors.foregroundDefaultQuaternary,
      backgroundColor: pressed
          ? colors.backgroundDefaultPrimaryPressed
          : colors.backgroundDefaultPrimary,
    );
  }
}
