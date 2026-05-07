import 'package:app_design_system/src/styleguide/colors.dart';
import 'package:app_design_system/src/widgets/selection_control/widgets/checkbox_colors.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

@internal
class CheckboxBody extends StatelessWidget {
  const CheckboxBody({
    super.key,
    required this.enabled,
    required this.hasError,
    required this.checked,
    required this.mixed,
    required this.pressed,
  });

  final bool enabled;
  final bool checked;
  final bool hasError;
  final bool mixed;
  final bool pressed;

  static const size = 24.0;
  static const _frameSize = 18.0;
  static const _borderThickness = 2.0;

  static const _colorTransitionDuration = Duration(milliseconds: 150);
  static const _colorTransitionCurve = Curves.ease;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    final hasVisibleIcon = checked || mixed;

    return Container(
      width: size,
      height: size,
      alignment: AlignmentDirectional.center,
      child: CheckboxColorsTween(
        colors: colors,
        enabled: enabled,
        danger: hasError,
        mixed: mixed,
        checked: checked,
        pressed: pressed,
        builder: (context, foregroundColor, backgroundColor) => Container(
          height: _frameSize,
          width: _frameSize,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: backgroundColor,
            border: Border.all(
              width: _borderThickness,
              color: foregroundColor,
              strokeAlign: BorderSide.strokeAlignCenter,
            ),
          ),
          child: AnimatedOpacity(
            duration: _colorTransitionDuration,
            curve: _colorTransitionCurve,
            opacity: hasVisibleIcon ? 1 : 0,
            child: CustomPaint(
              painter: _CheckboxIconPainter(
                color: foregroundColor,
                mixed: mixed,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CheckboxIconPainter extends CustomPainter {
  _CheckboxIconPainter({required this.color, required this.mixed});

  final AppColor color;
  final bool mixed;

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2;

    canvas.drawPath(switch (mixed) {
      true => _getPathOfMixedIcon(width, height),
      false => _getPathOfCheckIcon(width, height),
    }, paint);
  }

  Path _getPathOfMixedIcon(double width, double height) => Path()
    ..moveTo(0.2 * width, 0.5 * height)
    ..lineTo(0.8 * width, 0.5 * height);

  Path _getPathOfCheckIcon(double width, double height) => Path()
    ..moveTo(0.25 * width, 0.45 * height)
    ..lineTo(0.4375 * width, 0.625 * height)
    ..lineTo(0.75 * width, 0.3125 * height);

  @override
  bool shouldRepaint(_CheckboxIconPainter old) =>
      old.mixed != mixed || old.color != color;
}
