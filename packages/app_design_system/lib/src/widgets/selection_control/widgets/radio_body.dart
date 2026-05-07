import 'package:app_design_system/src/styleguide/colors.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

@internal
class RadioBody extends StatelessWidget {
  const RadioBody({
    super.key,
    required this.enabled,
    required this.danger,
    required this.pressed,
    required this.selected,
  });

  final bool enabled;
  final bool danger;
  final bool pressed;
  final bool selected;

  static const _size = 20.0;
  static const _dotSize = 10.0;

  static const _colorTransitionDuration = Duration(milliseconds: 150);
  static const _colorTransitionCurve = Curves.ease;

  @override
  Widget build(BuildContext context) {
    final effectiveDotSize = selected ? _dotSize : 0.0;

    final resolvedColor = _resolveColor(context.colors);

    return TweenAnimationBuilder(
      duration: _colorTransitionDuration,
      curve: _colorTransitionCurve,
      tween: switch (selected) {
        true => AppColorTween(end: resolvedColor),
        false => AppColorTween(end: resolvedColor.transparent),
      },
      builder: (context, value, _) => Container(
        width: _size,
        height: _size,
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: resolvedColor, width: 2),
        ),
        alignment: Alignment.center,
        child: Container(
          width: effectiveDotSize,
          height: effectiveDotSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: resolvedColor,
          ),
        ),
      ),
    );
  }

  AppColor _resolveColor(AppColors colors) {
    if (!enabled) {
      return selected
          ? colors.foregroundDisabledPrimary
          : colors.foregroundDisabledSecondary;
    }

    if (danger) {
      return pressed
          ? colors.foregroundDangerPrimaryPressed
          : colors.foregroundDangerPrimary;
    }

    if (selected) {
      return pressed
          ? colors.foregroundActivePrimaryPressed
          : colors.foregroundActivePrimary;
    }

    return pressed
        ? colors.foregroundActivePrimaryPressed
        : colors.foregroundDefaultSecondary;
  }
}
