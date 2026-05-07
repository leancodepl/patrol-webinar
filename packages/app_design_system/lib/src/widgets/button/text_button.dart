import 'package:app_design_system/src/styleguide/colors.dart';
import 'package:app_design_system/src/styleguide/motion.dart';
import 'package:app_design_system/src/styleguide/spacing.dart';
import 'package:app_design_system/src/styleguide/typography.dart';
import 'package:app_design_system/src/utils/pointer_surface.dart';
import 'package:app_design_system/src/widgets/button/button_foreground.dart';
import 'package:app_design_system/src/widgets/button/button_semantics.dart';
import 'package:app_design_system/src/widgets/icon/icon.dart';
import 'package:flutter/widgets.dart';

const _labelStyle = AppTextStyles.button;

enum AppTextButtonType {
  brand,
  base,
  danger;

  AppColor getForegroundColor(
    AppColors colors, {
    required Set<AppPointerSurfaceState> states,
    required bool enabled,
    required bool loading,
  }) {
    if (!enabled) {
      return switch (this) {
        brand => colors.foregroundDisabledPrimary,
        base => colors.foregroundDisabledSecondary,
        danger => colors.foregroundDisabledPrimary,
      };
    }

    if (loading || states.containsPressed) {
      return switch (this) {
        brand => colors.foregroundActivePrimaryPressed,
        base => colors.foregroundDefaultSecondaryPressed,
        danger => colors.foregroundDangerPrimaryPressed,
      };
    }

    return switch (this) {
      brand => colors.foregroundActivePrimary,
      base => colors.foregroundDefaultSecondary,
      danger => colors.foregroundDangerPrimary,
    };
  }
}

class AppRawTextButton extends StatelessWidget {
  AppRawTextButton({
    super.key,
    AppStandardIconData? leadingIcon,
    required String caption,
    AppStandardIconData? trailingIcon,
    required this.type,
    this.semanticsLabel,
    required this.onTap,
    this.enabled = true,
    this.loading = false,
  }) : variant = ButtonForegroundCaption(
         leadingIcon: leadingIcon,
         caption: caption,
         trailingIcon: trailingIcon,
       );

  AppRawTextButton.icon({
    super.key,
    required AppStandardIconData icon,
    required this.type,
    required this.semanticsLabel,
    required this.onTap,
    this.enabled = true,
    this.loading = false,
  }) : variant = ButtonForegroundIcon(icon: icon);

  final AppTextButtonType type;
  final String? semanticsLabel;
  final VoidCallback onTap;
  final bool enabled;
  final bool loading;

  final ButtonForegroundVariant variant;

  static const height = 24.0;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return ButtonSemantics(
      semanticsLabel: semanticsLabel,
      caption: variant.captionOrNull,
      enabled: enabled,
      loading: loading,
      onTap: onTap,
      child: AppPointerSurface(
        enabled: enabled,
        onTap: onTap,
        builder: (context, states) {
          final foregroundColor = type.getForegroundColor(
            colors,
            states: states,
            enabled: enabled,
            loading: loading,
          );

          return ButtonForeground(
            spacing: AppSpacings.s8,
            foregroundColor: foregroundColor,
            loading: loading,
            variant: variant,
            labelStyle: _labelStyle,
            curve: states.transitionCurve,
            duration: AppDurations.pointer,
          );
        },
      ),
    );
  }
}
