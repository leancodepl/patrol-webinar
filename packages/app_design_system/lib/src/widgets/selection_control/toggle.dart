import 'package:app_design_system/src/config.dart';
import 'package:app_design_system/src/styleguide/colors.dart';
import 'package:app_design_system/src/utils/pointer_surface.dart';
import 'package:flutter/widgets.dart';

class AppToggle extends StatelessWidget {
  const AppToggle({
    super.key,
    this.enabled = true,
    this.danger = false,
    required this.value,
    required this.onChanged,
  });

  final bool enabled;
  final bool danger;
  final bool value;
  final ValueChanged<bool>? onChanged;

  static const _colorTransitionDuration = Duration(milliseconds: 200);
  static const _colorTransitionCurve = Curves.ease;
  static const _internalThumbSize = 20.0;
  static const _internalThumbPressedSize = 25.0;
  static const _height = 24.0;
  static const _width = 40.0;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Semantics(
      enabled: enabled,
      toggled: value,
      child: AppPointerSurface(
        enabled: enabled,
        onTap: _onTap,
        builder: (context, states) => ExcludeSemantics(
          child: AnimatedContainer(
            duration: _colorTransitionDuration,
            curve: _colorTransitionCurve,
            height: _height,
            width: _width,
            alignment: _thumbAlignment,
            padding: const EdgeInsets.all(2),
            decoration: ShapeDecoration(
              shape: const StadiumBorder(),
              color: _getColor(
                colors,
                enabled: enabled,
                value: value,
                danger: danger,
                pressed: states.containsPressed,
              ),
            ),
            // Animate thumb's size and color separately with separate duration which
            // has to be two times longer for thumb size.
            child: AnimatedContainer(
              duration: _thumbSizeTransitionDuration,
              width: _getThumbWidth(states),
              curve: _colorTransitionCurve,
              child: AnimatedContainer(
                duration: _colorTransitionDuration,
                curve: _colorTransitionCurve,
                height: _internalThumbSize,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(_internalThumbSize / 2),
                  color: colors.foregroundInversePrimary,
                ),
                child: AppConfig.showCheckMarkIconOnToggle
                    ? _CheckMarkIcon(
                        enabled: enabled,
                        value: value,
                        danger: danger,
                        pressed: states.containsPressed,
                        duration: _colorTransitionDuration,
                        curve: _colorTransitionCurve,
                      )
                    : null,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTap() => onChanged?.call(!value);

  static AppColor _getColor(
    AppColors colors, {
    required bool enabled,
    required bool value,
    required bool danger,
    required bool pressed,
  }) {
    if (!enabled) {
      return switch (value) {
        true => colors.backgroundDisabledPrimary,
        false => colors.backgroundDisabledSecondary,
      };
    }

    if (danger) {
      return switch (pressed) {
        true => switch (value) {
          true => colors.backgroundDangerPrimaryPressed,
          false => colors.backgroundDangerTertiaryPressed,
        },
        false => switch (value) {
          true => colors.backgroundDangerPrimary,
          false => colors.backgroundDangerTertiary,
        },
      };
    }

    return switch (pressed) {
      true => switch (value) {
        true => colors.backgroundActivePrimaryPressed,
        false => colors.backgroundDefaultTertiaryPressed,
      },
      false => switch (value) {
        true => colors.backgroundActivePrimary,
        false => colors.backgroundDefaultTertiary,
      },
    };
  }

  Duration get _thumbSizeTransitionDuration => _colorTransitionDuration * 2.5;

  double _getThumbWidth(Set<AppPointerSurfaceState> states) => switch (states) {
    Set(containsPressed: true) => _internalThumbPressedSize,
    _ => _internalThumbSize,
  };

  AlignmentDirectional get _thumbAlignment => switch (value) {
    true => AlignmentDirectional.centerEnd,
    false => AlignmentDirectional.centerStart,
  };
}

class _CheckMarkIcon extends StatelessWidget {
  const _CheckMarkIcon({
    required this.enabled,
    required this.value,
    required this.danger,
    required this.pressed,
    required this.duration,
    required this.curve,
  });

  final bool enabled;
  final bool value;
  final bool danger;
  final bool pressed;
  final Duration duration;
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final iconColor = AppToggle._getColor(
      colors,
      enabled: enabled,
      value: value,
      danger: danger,
      pressed: pressed,
    );

    return TweenAnimationBuilder(
      curve: curve,
      tween: switch (value) {
        true => AppColorTween(end: iconColor),
        false => AppColorTween(end: iconColor.transparent),
      },
      duration: duration,
      builder: (context, value, _) => CustomPaint(
        size: const Size.square(18),
        painter: _CheckMarkIconPainter(color: value),
      ),
    );
  }
}

class _CheckMarkIconPainter extends CustomPainter {
  _CheckMarkIconPainter({required this.color});

  final AppColor color;

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2;

    canvas.drawPath(
      Path()
        ..moveTo(0.25 * width, 0.45 * height)
        ..lineTo(0.4375 * width, 0.625 * height)
        ..lineTo(0.75 * width, 0.3125 * height),
      paint,
    );
  }

  @override
  bool shouldRepaint(_CheckMarkIconPainter old) => old.color != color;
}
