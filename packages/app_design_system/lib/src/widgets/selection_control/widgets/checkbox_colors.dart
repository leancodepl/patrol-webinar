import 'package:app_design_system/src/styleguide/colors.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

@internal
typedef CheckboxColorsTweenBuilder =
    Widget Function(
      BuildContext context,
      AppColor foregroundColor,
      AppColor backgroundColor,
    );

@internal
class CheckboxColorsTween extends ImplicitlyAnimatedWidget {
  const CheckboxColorsTween({
    super.key,
    required this.colors,
    required this.enabled,
    required this.danger,
    required this.mixed,
    required this.checked,
    required this.pressed,
    required this.builder,
  }) : super(duration: _duration, curve: _curve);

  final AppColors colors;
  final bool enabled;
  final bool danger;
  final bool mixed;
  final bool checked;
  final bool pressed;
  final CheckboxColorsTweenBuilder builder;

  static const _duration = Duration(milliseconds: 150);
  static const _curve = Curves.ease;

  @override
  _CheckboxFieldColorsTweenState createState() =>
      _CheckboxFieldColorsTweenState();
}

class _CheckboxFieldColorsTweenState
    extends AnimatedWidgetBaseState<CheckboxColorsTween> {
  AppColorTween? _foregroundColor;
  AppColorTween? _backgroundColor;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    final resolvedColors = _resolveColors();

    _foregroundColor =
        visitor(
              _foregroundColor,
              resolvedColors.foregroundColor,
              (value) => AppColorTween.uniform(value as AppColor)..end = null,
            )!
            as AppColorTween;

    _backgroundColor =
        visitor(
              _backgroundColor,
              resolvedColors.backgroundColor,
              (value) => AppColorTween.uniform(value as AppColor)..end = null,
            )!
            as AppColorTween;
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(
      context,
      _foregroundColor!.evaluate(animation),
      _backgroundColor!.evaluate(animation),
    );
  }

  ({AppColor foregroundColor, AppColor backgroundColor}) _resolveColors() {
    final colors = widget.colors;
    final hasVisibleIcon = widget.checked || widget.mixed;

    if (!widget.enabled) {
      final backgroundColor = colors.backgroundDisabledTertiary;

      return (
        foregroundColor: hasVisibleIcon
            ? colors.foregroundDisabledPrimary
            : colors.foregroundDisabledSecondary,
        backgroundColor: hasVisibleIcon
            ? backgroundColor
            : backgroundColor.transparent,
      );
    }

    if (widget.danger) {
      final backgroundColor = widget.pressed
          ? colors.backgroundDangerTertiaryPressed
          : colors.backgroundDangerTertiary;

      return (
        foregroundColor: widget.pressed
            ? colors.foregroundDangerPrimaryPressed
            : colors.foregroundDangerPrimary,
        backgroundColor: hasVisibleIcon
            ? backgroundColor
            : backgroundColor.transparent,
      );
    }

    if (widget.pressed) {
      final backgroundColor = colors.backgroundAccentTertiaryPressed;

      return (
        foregroundColor: colors.foregroundActivePrimaryPressed,
        backgroundColor: hasVisibleIcon
            ? backgroundColor
            : backgroundColor.transparent,
      );
    }

    return (
      foregroundColor: hasVisibleIcon
          ? colors.foregroundActivePrimary
          : colors.foregroundDefaultSecondary,
      backgroundColor: hasVisibleIcon
          ? colors.backgroundAccentTertiary
          : colors.backgroundDefaultTertiary.transparent,
    );
  }
}
