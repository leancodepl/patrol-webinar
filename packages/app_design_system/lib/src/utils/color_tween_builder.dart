import 'package:app_design_system/src/styleguide/colors.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

const _duration = Duration(milliseconds: 250);
const _curve = Curves.ease;

@internal
typedef ColorTweenBuilderCallback =
    Widget Function(BuildContext context, AppColor color, Widget? child);

@internal
class ColorTweenBuilder extends ImplicitlyAnimatedWidget {
  const ColorTweenBuilder({
    super.key,
    required this.color,
    required this.builder,
    super.duration = _duration,
    super.curve = _curve,
    this.child,
  });

  final AppColor color;
  final ColorTweenBuilderCallback builder;
  final Widget? child;

  @override
  _ColorTweenState createState() => _ColorTweenState();
}

class _ColorTweenState extends AnimatedWidgetBaseState<ColorTweenBuilder> {
  AppColorTween? _color;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _color =
        visitor(
              _color,
              widget.color,
              (dynamic value) =>
                  AppColorTween.uniform(value as AppColor)..end = null,
            )!
            as AppColorTween;
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _color!.evaluate(animation), widget.child);
  }
}
