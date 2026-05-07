import 'dart:math';

import 'package:app_design_system/src/config.dart';
import 'package:app_design_system/src/styleguide/colors.dart';
import 'package:app_design_system/src/widgets/freeze_infinite_animations.dart';
import 'package:enhanced_gradients/enhanced_gradients.dart';
import 'package:flutter/widgets.dart';

class AppSpinner extends StatefulWidget {
  const AppSpinner({super.key});

  @override
  _AppSpinnerState createState() => _AppSpinnerState();
}

class _AppSpinnerState extends State<AppSpinner>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final freezeAnimations = AppFreezeInfiniteAnimations.of(context);
    if (freezeAnimations) {
      _controller.stop();
    } else if (!_controller.isAnimating) {
      _controller.repeat();
    }
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: CustomPaint(
        size: const Size.square(40),
        painter: _AppSpinnerPainter(
          color: context.colors.foregroundActivePrimary,
          rotation: _controller,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }
}

class _AppSpinnerPainter extends CustomPainter {
  _AppSpinnerPainter({required this.color, required this.rotation})
    : super(repaint: rotation);

  final AppColor color;
  final Animation<double> rotation;

  static const _angle = 0.75;
  static const _stroke = 5.0;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.shortestSide / 2 - _stroke / 2;
    final startAngle = -rotation.value * 2 * pi;
    final rect = Rect.fromCircle(center: center, radius: radius);

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = _stroke;

    if (AppConfig.gradientSpinner) {
      paint.shader = EnhancedSweepGradient(
        center: FractionalOffset.center,
        colors: [color, color.withValues(alpha: 0)],
        stops: const [0, _angle],
        transform: GradientRotation(startAngle),
      ).createShader(rect);
    } else {
      paint.color = color;
    }

    canvas.drawArc(rect, startAngle, 2 * pi * _angle, false, paint);
  }

  @override
  bool shouldRepaint(_AppSpinnerPainter old) => old.color != color;
}
