import 'package:app_design_system/src/styleguide/colors.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

@internal
typedef SelectionControlFieldColorsTweenBuilder =
    Widget Function(
      BuildContext context,
      AppColor asteriskColor,
      AppColor descriptionColor,
      AppColor valueColor,
      AppColor labelColor,
    );

@internal
class SelectionControlFieldColorsTween extends ImplicitlyAnimatedWidget {
  const SelectionControlFieldColorsTween({
    super.key,
    required this.colors,
    required this.enabled,
    required this.builder,
  }) : super(duration: _duration, curve: _curve);

  static const _duration = Duration(milliseconds: 150);
  static const _curve = Curves.ease;

  final AppColors colors;
  final bool enabled;
  final SelectionControlFieldColorsTweenBuilder builder;

  @override
  _SelectionControlFieldColorsTweenState createState() =>
      _SelectionControlFieldColorsTweenState();
}

class _SelectionControlFieldColorsTweenState
    extends AnimatedWidgetBaseState<SelectionControlFieldColorsTween> {
  AppColorTween? _asteriskColor;
  AppColorTween? _descriptionColor;
  AppColorTween? _valueColor;
  AppColorTween? _labelColor;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    final resolvedColors = _resolveColors();

    _asteriskColor =
        visitor(
              _asteriskColor,
              resolvedColors.asteriskColor,
              (value) => AppColorTween.uniform(value as AppColor)..end = null,
            )!
            as AppColorTween;

    _descriptionColor =
        visitor(
              _descriptionColor,
              resolvedColors.descriptionColor,
              (value) => AppColorTween.uniform(value as AppColor)..end = null,
            )!
            as AppColorTween;

    _valueColor =
        visitor(
              _valueColor,
              resolvedColors.valueColor,
              (value) => AppColorTween.uniform(value as AppColor)..end = null,
            )!
            as AppColorTween;

    _labelColor =
        visitor(
              _labelColor,
              resolvedColors.labelColor,
              (value) => AppColorTween.uniform(value as AppColor)..end = null,
            )!
            as AppColorTween;
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(
      context,
      _asteriskColor!.evaluate(animation),
      _descriptionColor!.evaluate(animation),
      _valueColor!.evaluate(animation),
      _labelColor!.evaluate(animation),
    );
  }

  ({
    AppColor asteriskColor,
    AppColor descriptionColor,
    AppColor valueColor,
    AppColor labelColor,
  })
  _resolveColors() {
    final colors = widget.colors;

    if (widget.enabled) {
      return (
        asteriskColor: colors.foregroundDangerPrimary,
        descriptionColor: colors.foregroundDefaultSecondary,
        valueColor: colors.foregroundDefaultSecondary,
        labelColor: colors.foregroundDefaultPrimary,
      );
    }

    return (
      asteriskColor: colors.foregroundDisabledPrimary,
      descriptionColor: colors.foregroundDisabledSecondary,
      valueColor: colors.foregroundDisabledSecondary,
      labelColor: colors.foregroundDisabledPrimary,
    );
  }
}
