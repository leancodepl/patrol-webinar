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

enum AppButtonSize {
  medium(AppSpacings.s8),
  large(AppSpacings.s12);

  const AppButtonSize(this.padding);

  final AppSpacing padding;
}

enum AppButtonType {
  primary,
  secondary,
  tertiary,
  quaternary,
  dangerPrimary,
  dangerSecondary,
  dangerTertiary;

  AppColor getBackgroundColor(
    AppColors colors, {
    required Set<AppPointerSurfaceState> states,
    required bool loading,
    required bool enabled,
  }) {
    if (!enabled) {
      return switch (this) {
        primary => colors.backgroundDisabledPrimary,
        secondary => colors.backgroundDisabledTertiary,
        tertiary => colors.transparent,
        quaternary => colors.transparent,
        dangerPrimary => colors.backgroundDisabledPrimary,
        dangerSecondary => colors.backgroundDisabledTertiary,
        dangerTertiary => colors.transparent,
      };
    }

    if (loading || states.containsPressed) {
      return switch (this) {
        primary => colors.backgroundActivePrimaryPressed,
        secondary => colors.backgroundActiveTertiaryPressed,
        tertiary => colors.backgroundAccentTertiaryPressed,
        quaternary => colors.backgroundDefaultPrimaryPressed,
        dangerPrimary => colors.backgroundDangerPrimaryPressed,
        dangerSecondary => colors.backgroundDangerTertiaryPressed,
        dangerTertiary => colors.backgroundDangerTertiaryPressed,
      };
    }

    return switch (this) {
      primary => colors.backgroundActivePrimary,
      secondary => colors.backgroundDefaultPrimary,
      tertiary => colors.transparent,
      quaternary => colors.transparent,
      dangerPrimary => colors.backgroundDangerPrimary,
      dangerSecondary => colors.backgroundDangerTertiary,
      dangerTertiary => colors.transparent,
    };
  }

  AppColor getForegroundColor(
    AppColors colors, {
    required Set<AppPointerSurfaceState> states,
    required bool loading,
    required bool enabled,
  }) {
    if (!enabled) {
      return switch (this) {
        primary => colors.foregroundDisabledPrimary,
        secondary => colors.foregroundDisabledPrimary,
        tertiary => colors.foregroundDisabledPrimary,
        quaternary => colors.foregroundDisabledPrimary,
        dangerPrimary => colors.foregroundDisabledPrimary,
        dangerSecondary => colors.foregroundDisabledPrimary,
        dangerTertiary => colors.foregroundDisabledPrimary,
      };
    }

    if (loading || states.containsPressed) {
      return switch (this) {
        primary => colors.foregroundInversePrimaryPressed,
        secondary => colors.foregroundActivePrimaryPressed,
        tertiary => colors.foregroundActivePrimaryPressed,
        quaternary => colors.foregroundDefaultSecondaryPressed,
        dangerPrimary => colors.foregroundInversePrimary,
        dangerSecondary => colors.foregroundDangerPrimaryPressed,
        dangerTertiary => colors.foregroundDangerPrimaryPressed,
      };
    }

    return switch (this) {
      primary => colors.foregroundInversePrimary,
      secondary => colors.foregroundActivePrimary,
      tertiary => colors.foregroundActivePrimary,
      quaternary => colors.foregroundDefaultSecondary,
      dangerPrimary => colors.foregroundInversePrimary,
      dangerSecondary => colors.foregroundDangerPrimary,
      dangerTertiary => colors.foregroundDangerPrimary,
    };
  }

  AppColor getBorderColor(
    AppColors colors, {
    required Set<AppPointerSurfaceState> states,
    required bool loading,
    required bool enabled,
  }) {
    if (!enabled) {
      return colors.transparent;
    }

    if (loading) {
      return switch (this) {
        primary || secondary => colors.backgroundActiveTertiary,
        tertiary || quaternary || dangerTertiary => colors.transparent,
        dangerPrimary || dangerSecondary => colors.backgroundDangerTertiary,
      };
    }

    return switch (states) {
      Set(containsPressed: true) => switch (this) {
        primary || secondary => colors.backgroundActiveTertiary,
        tertiary || quaternary || dangerTertiary => colors.transparent,
        dangerPrimary || dangerSecondary => colors.backgroundDangerTertiary,
      },
      _ => switch (this) {
        secondary => colors.foregroundDefaultQuaternary,
        _ => colors.transparent,
      },
    };
  }
}

class AppRawButton extends StatelessWidget {
  AppRawButton({
    super.key,
    AppStandardIconData? leadingIcon,
    required String caption,
    AppStandardIconData? trailingIcon,
    required this.size,
    required this.type,
    this.semanticsLabel,
    required this.onTap,
    this.enabled = true,
    this.loading = false,
    this.fullWidth = false,
  }) : variant = ButtonForegroundCaption(
         leadingIcon: leadingIcon,
         caption: caption,
         trailingIcon: trailingIcon,
       );

  AppRawButton.icon({
    super.key,
    required AppStandardIconData icon,
    required this.size,
    required this.type,
    required this.semanticsLabel,
    required this.onTap,
    this.enabled = true,
    this.loading = false,
  }) : fullWidth = false,
       variant = ButtonForegroundIcon(icon: icon);

  final AppButtonSize size;
  final AppButtonType type;
  final String? semanticsLabel;
  final VoidCallback onTap;
  final bool enabled;
  final bool loading;

  /// If the button's parent passes loose constraints, button will expand to
  /// fill the available space horizontally.
  final bool fullWidth;

  final ButtonForegroundVariant variant;

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
        enabled: enabled && !loading,
        onTap: onTap,
        builder: (context, states) {
          final foregroundColor = type.getForegroundColor(
            colors,
            states: states,
            enabled: enabled,
            loading: loading,
          );
          final backgroundColor = type.getBackgroundColor(
            colors,
            states: states,
            enabled: enabled,
            loading: loading,
          );
          final borderColor = type.getBorderColor(
            colors,
            states: states,
            enabled: enabled,
            loading: loading,
          );

          return _ColorsTween(
            backgroundColor: backgroundColor,
            borderColor: borderColor,
            duration: AppDurations.pointer,
            curve: states.transitionCurve,
            builder: (context, background, borderColor) {
              final button = _ButtonContainer(
                backgroundColor: background,
                borderColor: borderColor,
                padding: size.padding.all,
                child: ButtonForeground(
                  foregroundColor: foregroundColor,
                  loading: loading,
                  variant: variant,
                  spacing: AppSpacings.s8,
                  labelStyle: _labelStyle,
                  curve: states.transitionCurve,
                  duration: AppDurations.pointer,
                ),
              );

              return switch (fullWidth) {
                true => SizedBox(width: double.infinity, child: button),
                false => button,
              };
            },
          );
        },
      ),
    );
  }
}

class _ButtonContainer extends StatelessWidget {
  const _ButtonContainer({
    required this.child,
    required this.backgroundColor,
    required this.borderColor,
    required this.padding,
  });

  final Widget child;
  final AppColor backgroundColor;
  final AppColor borderColor;
  final EdgeInsetsDirectional padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: backgroundColor,
        border: Border.all(
          color: borderColor,
          width: 2,
          strokeAlign: BorderSide.strokeAlignOutside,
        ),
      ),
      child: Stack(
        alignment: AlignmentDirectional.center,
        fit: StackFit.passthrough,
        children: [
          SizedBox.square(dimension: _labelStyle.getEffectiveHeight(context)),
          child,
        ],
      ),
    );
  }
}

typedef _ColorsTweenBuilder =
    Widget Function(
      BuildContext context,
      AppColor backgroundColor,
      AppColor borderColor,
    );

class _ColorsTween extends ImplicitlyAnimatedWidget {
  const _ColorsTween({
    required this.backgroundColor,
    required this.borderColor,
    required this.builder,
    required super.duration,
    required super.curve,
  });

  final AppColor backgroundColor;
  final AppColor? borderColor;
  final _ColorsTweenBuilder builder;

  @override
  _ColorsTweenState createState() => _ColorsTweenState();
}

class _ColorsTweenState extends AnimatedWidgetBaseState<_ColorsTween> {
  AppColorTween? _backgroundColor;
  AppColorTween? _borderColor;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _backgroundColor =
        visitor(
              _backgroundColor,
              widget.backgroundColor,
              (dynamic value) =>
                  AppColorTween.uniform(value as AppColor)..end = null,
            )!
            as AppColorTween;

    final borderColor = widget.borderColor;
    _borderColor =
        visitor(
              _borderColor,
              borderColor,
              (dynamic value) =>
                  AppColorTween.uniform(value as AppColor)..end = null,
            )
            as AppColorTween?;
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(
      context,
      _backgroundColor!.evaluate(animation),
      _borderColor!.evaluate(animation),
    );
  }
}
