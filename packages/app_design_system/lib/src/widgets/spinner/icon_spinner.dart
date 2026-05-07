import 'package:app_design_system/src/styleguide/colors.dart';
import 'package:app_design_system/src/widgets/freeze_infinite_animations.dart';
import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';

class AppIconSpinner extends StatefulWidget implements PreferredSizeWidget {
  const AppIconSpinner({super.key, required this.color});

  final AppColor color;

  @override
  _AppIconSpinnerState createState() => _AppIconSpinnerState();

  @override
  final preferredSize = const Size.square(24);
}

class _AppIconSpinnerState extends State<AppIconSpinner>
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
        size: widget.preferredSize,
        painter: _AppIconSpinnerPainter(
          color: widget.color,
          progress: _controller,
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

class _AppIconSpinnerPainter extends CustomPainter {
  _AppIconSpinnerPainter({required this.color, required this.progress})
    : super(repaint: progress);

  final AppColor color;
  final Animation<double> progress;

  static const _stroke = 1.5;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = _stroke;

    final tween = AppColorTween(begin: color, end: color.transparent);

    final lines = [
      (const Offset(12, 2), const Offset(12, 6)),
      (const Offset(4.92157, 4.99994), const Offset(7.75, 7.82837)),
      (const Offset(6, 12), const Offset(2, 12)),
      (const Offset(4.92157, 19.0784), const Offset(7.75, 16.25)),
      (const Offset(12, 18), const Offset(12, 22)),
      (const Offset(19.0784, 19.0784), const Offset(16.25, 16.25)),
      (const Offset(22, 12), const Offset(18, 12)),
      (const Offset(19.0784, 4.99994), const Offset(16.25, 7.82837)),
    ];

    lines.forEachIndexed((index, line) {
      final threshold = index / lines.length;
      final distance = (progress.value - threshold) % 1;

      paint.color = tween.transform(distance);

      canvas.drawLine(line.$1, line.$2, paint);
    });
  }

  @override
  bool shouldRepaint(_AppIconSpinnerPainter old) => old.color != color;
}
