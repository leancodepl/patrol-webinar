import 'package:app_design_system/src/styleguide/colors.dart';
import 'package:app_design_system/src/utils/pointer_surface.dart';
import 'package:app_design_system/src/widgets/chip/chip_body.dart';
import 'package:app_design_system/src/widgets/chip/chip_colors.dart';
import 'package:app_design_system/src/widgets/icon/icon.dart';
import 'package:flutter/widgets.dart';

class AppActionChip extends StatelessWidget {
  const AppActionChip({
    super.key,
    this.enabled = true,
    required this.label,
    required this.onTap,
    this.prefixIcon,
    this.prefixIconSemanticsLabel,
    this.suffixIcon,
    this.suffixIconSemanticsLabel,
    this.iconColor,
  });

  final bool enabled;
  final String label;
  final VoidCallback onTap;
  final AppColor? iconColor;
  final AppStandardIconData? prefixIcon;
  final String? prefixIconSemanticsLabel;
  final AppStandardIconData? suffixIcon;
  final String? suffixIconSemanticsLabel;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Semantics(
      container: true,
      button: true,
      enabled: enabled,
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
            iconColor: resolvedColors.iconColor,
            suffixIcon: suffixIcon,
            suffixIconSemanticsLabel: suffixIconSemanticsLabel,
            prefixIcon: prefixIcon,
            prefixIconSemanticsLabel: prefixIconSemanticsLabel,
          );
        },
      ),
    );
  }

  ChipColors _resolveColors(AppColors colors, {required bool pressed}) {
    if (enabled) {
      return (
        textColor: colors.foregroundDefaultPrimary,
        iconColor: colors.foregroundDefaultSecondary,
        borderColor: colors.foregroundDefaultQuaternary,
        backgroundColor: pressed
            ? colors.backgroundDefaultPrimaryPressed
            : colors.backgroundDefaultPrimary,
      );
    }

    return (
      textColor: colors.foregroundDisabledPrimary,
      iconColor: colors.foregroundDisabledPrimary,
      borderColor: colors.foregroundDisabledTertiary,
      backgroundColor: colors.backgroundDisabledTertiary,
    );
  }
}
