import 'package:app_design_system/src/styleguide/colors.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

@internal
typedef ChipColors = ({
  AppColor textColor,
  AppColor? iconColor,
  AppColor borderColor,
  AppColor backgroundColor,
});

@internal
typedef ChipColorsTweenBuilder =
    Widget Function(
      BuildContext context,
      AppColor backgroundColor,
      AppColor borderColor,
      AppColor textColor,
      AppColor? iconColor,
    );

@internal
class ChipColorsTween extends ImplicitlyAnimatedWidget {
  const ChipColorsTween({
    super.key,
    required this.backgroundColor,
    required this.borderColor,
    required this.textColor,
    required this.iconColor,
    required this.builder,
  }) : super(duration: _duration, curve: _curve);

  static const _duration = Duration(milliseconds: 150);
  static const _curve = Curves.ease;

  final AppColor backgroundColor;
  final AppColor borderColor;
  final AppColor textColor;
  final AppColor? iconColor;
  final ChipColorsTweenBuilder builder;

  @override
  ChipColorsTweenState createState() => ChipColorsTweenState();
}

@internal
class ChipColorsTweenState extends AnimatedWidgetBaseState<ChipColorsTween> {
  AppColorTween? _backgroundColor;
  AppColorTween? _borderColor;
  AppColorTween? _textColor;
  AppColorTween? _iconColor;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _backgroundColor =
        visitor(
              _backgroundColor,
              widget.backgroundColor,
              (value) => AppColorTween.uniform(value as AppColor)..end = null,
            )!
            as AppColorTween;

    final borderColor = widget.borderColor;
    _borderColor =
        visitor(
              _borderColor,
              borderColor,
              (value) => AppColorTween.uniform(value as AppColor)..end = null,
            )!
            as AppColorTween;

    final textColor = widget.textColor;
    _textColor =
        visitor(
              _textColor,
              textColor,
              (value) => AppColorTween.uniform(value as AppColor)..end = null,
            )!
            as AppColorTween;

    final iconColor = widget.iconColor;
    _iconColor =
        visitor(
              _iconColor,
              iconColor,
              (value) => AppColorTween.uniform(value as AppColor)..end = null,
            )
            as AppColorTween?;
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(
      context,
      _backgroundColor!.evaluate(animation),
      _borderColor!.evaluate(animation),
      _textColor!.evaluate(animation),
      _iconColor?.evaluate(animation),
    );
  }
}
