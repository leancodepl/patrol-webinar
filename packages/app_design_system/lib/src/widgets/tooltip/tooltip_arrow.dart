part of 'tooltip.dart';

/// Gap used to ensure that the arrow doesn't overextend beyond the balloon.
const _controlGap = 12.0;

class _TooltipArrow extends StatelessWidget {
  const _TooltipArrow({
    required this.type,
    required this.gap,
    required this.renderController,
    required this.visible,
    required this.tooltipAlignment,
    required this.margin,
  });

  final AppTooltipType type;
  final double gap;
  final _TooltipRenderController renderController;
  final bool visible;
  final _TooltipAlignment tooltipAlignment;
  final EdgeInsetsDirectional margin;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    final alignment = tooltipAlignment.toAlignment();

    final controlPadding = EdgeInsetsDirectional.symmetric(
      horizontal: alignment.y != 0 ? _controlGap : 0,
      vertical: alignment.x != 0 ? _controlGap : 0,
    );

    final gapPadding = EdgeInsetsDirectional.symmetric(
      horizontal: alignment.x != 0 ? gap : 0,
      vertical: alignment.y != 0 ? gap : 0,
    );

    final arrowMargin = EdgeInsetsDirectional.fromSTEB(
      alignment.y != 0 ? margin.start : 0,
      alignment.x != 0 ? margin.top : 0,
      alignment.y != 0 ? margin.end : 0,
      alignment.x != 0 ? margin.bottom : 0,
    );

    final effectivePadding = arrowMargin + gapPadding + controlPadding;

    return PortalTarget(
      portalCandidateLabels: const [AppTooltip._arrowPortalLabel],
      anchor: const _MirrorConstraints(),
      portalFollower: _TooltipArrowTransition(
        visible: visible,
        renderController: renderController,
        child: Padding(
          padding: effectivePadding,
          child: CustomPaint(
            size: _arrowSize,
            painter: _TooltipArrowPainter(
              colors: colors,
              type: type,
              alignmentNotifier: renderController.alignment,
            ),
          ),
        ),
      ),
      child: Padding(
        padding: effectivePadding,
        child: SizedBox.fromSize(size: _arrowSize),
      ),
    );
  }
}

/// Data class with focal points used to draw the tooltip arrow. We
/// differentiate between the stroke and the triangle so that the arrow fills
/// nicely with the tooltip balloon and with it's border. A visual
/// representation as to what each points are assigned to can be found in the
/// `/documentation/features/design_system/tooltip/arrow_parameters.png` file.
///
/// ![](https://github.com/leancodepl/blob/master/documentation/features/design_system/tooltip/arrow_parameters.png)
class _TooltipArrowFocalPoints with EquatableMixin {
  const _TooltipArrowFocalPoints({
    required this.bottom,
    required this.topStartStroke,
    required this.topEndStroke,
    required this.topStartTriangle,
    required this.topEndTriangle,
  });

  final Offset bottom;
  final Offset topStartStroke;
  final Offset topEndStroke;
  final Offset topStartTriangle;
  final Offset topEndTriangle;

  /// Rotates the focal points by the given angle around the center which is
  /// useful when the arrow is aligned differently than to the top of the
  /// target.
  _TooltipArrowFocalPoints rotate({
    required double angle,
    required Offset center,
  }) {
    final bottom = rotatePoint(this.bottom, angle, center);
    final topStartStroke = rotatePoint(this.topStartStroke, angle, center);
    final topEndStroke = rotatePoint(this.topEndStroke, angle, center);

    final topStartTriangle = rotatePoint(this.topStartTriangle, angle, center);
    final topEndTriangle = rotatePoint(this.topEndTriangle, angle, center);

    return _TooltipArrowFocalPoints(
      bottom: bottom,
      topStartStroke: topStartStroke,
      topEndStroke: topEndStroke,
      topStartTriangle: topStartTriangle,
      topEndTriangle: topEndTriangle,
    );
  }

  @override
  List<Object?> get props => [
    bottom,
    topStartStroke,
    topEndStroke,
    topStartTriangle,
    topEndTriangle,
  ];
}

class _TooltipArrowPainter extends CustomPainter {
  const _TooltipArrowPainter({
    required this.colors,
    required this.type,
    required this.alignmentNotifier,
  }) : super(repaint: alignmentNotifier);

  final AppColors colors;
  final AppTooltipType type;
  final ValueNotifier<_TooltipAlignment?> alignmentNotifier;

  /// Returns default focal points for the arrow which by default represents
  /// arrow for a tooltip aligned to the top of the target.
  _TooltipArrowFocalPoints _getFocalPoints(Size size) {
    // The arrow triangle is extended beyond its bounds to ensure clean
    // connection with the tooltip balloon's border
    const arrowExtent = 0.5;

    final bottom = Offset(size.width / 2, size.height);
    final topStartStroke = Offset(
      size.width / 2 - size.height - arrowExtent,
      -arrowExtent,
    );
    final topEndStroke = Offset(
      size.width / 2 + size.height + arrowExtent,
      -arrowExtent,
    );

    final topStartTriangle = topStartStroke + const Offset(-2, -2);
    final topEndTriangle = topEndStroke + const Offset(2, -2);

    return _TooltipArrowFocalPoints(
      bottom: bottom,
      topStartStroke: topStartStroke,
      topEndStroke: topEndStroke,
      topStartTriangle: topStartTriangle,
      topEndTriangle: topEndTriangle,
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    final alignment = alignmentNotifier.value;

    if (alignment == null) {
      return;
    }

    final focalPoints = _getFocalPoints(size).rotate(
      angle: alignment.angle,
      center: Offset(size.width / 2, size.height / 2),
    );

    final strokePaint = Paint()
      ..color = type.getBorderColor(colors)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.miter;

    final fillPaint = Paint()
      ..color = type.getBackgroundColor(colors)
      ..strokeWidth = 1
      ..style = PaintingStyle.fill;

    final fillPath = Path()
      ..moveTo(focalPoints.bottom.dx, focalPoints.bottom.dy)
      ..lineTo(focalPoints.topStartTriangle.dx, focalPoints.topStartTriangle.dy)
      ..lineTo(focalPoints.topEndTriangle.dx, focalPoints.topEndTriangle.dy)
      ..lineTo(focalPoints.bottom.dx, focalPoints.bottom.dy);

    canvas
      ..save()
      ..drawPath(fillPath, fillPaint)
      ..restore()
      ..save()
      ..drawLine(focalPoints.topStartStroke, focalPoints.bottom, strokePaint)
      ..drawLine(focalPoints.topEndStroke, focalPoints.bottom, strokePaint)
      ..restore();
  }

  @override
  bool shouldRepaint(_TooltipArrowPainter oldDelegate) =>
      colors != oldDelegate.colors || type != oldDelegate.type;
}
