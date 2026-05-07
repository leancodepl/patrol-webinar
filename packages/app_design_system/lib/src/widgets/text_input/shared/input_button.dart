import 'package:app_design_system/src/styleguide/colors.dart';
import 'package:app_design_system/src/styleguide/motion.dart';
import 'package:app_design_system/src/styleguide/spacing.dart';
import 'package:app_design_system/src/styleguide/typography.dart';
import 'package:app_design_system/src/utils/pointer_surface.dart';
import 'package:app_design_system/src/widgets/button/button_foreground.dart';
import 'package:app_design_system/src/widgets/button/button_semantics.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

const _labelStyle = AppTextStyles.button;

@internal
enum InputButtonType {
  brand,
  base;

  AppColor getForegroundColor(
    AppColors colors, {
    required Set<AppPointerSurfaceState> states,
    required bool enabled,
    required bool loading,
  }) {
    if (!enabled) {
      return colors.foregroundDisabledSecondary;
    }

    if (loading || states.containsPressed) {
      return switch (this) {
        brand => colors.foregroundActivePrimaryPressed,
        base => colors.foregroundDefaultSecondaryPressed,
      };
    }

    return switch (this) {
      brand => colors.foregroundActivePrimary,
      base => colors.foregroundDefaultSecondary,
    };
  }
}

@internal
typedef InputButtonVariant = ButtonForegroundVariant;

@internal
typedef InputButtonCaption = ButtonForegroundCaption;

@internal
typedef InputButtonIcon = ButtonForegroundIcon;

@internal
class InputButton extends StatelessWidget {
  const InputButton({
    super.key,
    required this.spacing,
    required this.variant,
    required this.type,
    this.semanticsLabel,
    required this.onTap,
    this.enabled = true,
    this.loading = false,
  });

  final AppSpacing spacing;
  final InputButtonType type;
  final InputButtonVariant variant;
  final String? semanticsLabel;
  final VoidCallback onTap;
  final bool enabled;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return ButtonSemantics(
      semanticsLabel: semanticsLabel,
      caption: variant.captionOrNull,
      enabled: enabled,
      loading: loading,
      onTap: onTap,
      child: SizedBox(
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
              spacing: spacing,
              foregroundColor: foregroundColor,
              loading: loading,
              variant: variant,
              labelStyle: _labelStyle,
              curve: states.transitionCurve,
              duration: AppDurations.pointer,
            );
          },
        ),
      ),
    );
  }
}
