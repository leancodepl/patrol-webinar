part of 'tooltip.dart';

const _borderWidth = 1.0;

class _TooltipBalloon extends StatelessWidget {
  const _TooltipBalloon({
    required this.tag,
    required this.text,
    required this.type,
    required this.margin,
    required this.tooltipAlignment,
    required this.gap,
    required this.renderController,
    required this.visible,
    required this.hideByOutsideTap,
  });

  final Object tag;
  final String text;
  final AppTooltipType type;
  final EdgeInsetsDirectional margin;
  final _TooltipAlignment tooltipAlignment;
  final double gap;
  final _TooltipRenderController renderController;
  final bool visible;
  final bool hideByOutsideTap;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: renderController.alignment,
      builder: (context, child) {
        final textDirection = Directionality.of(context);
        final colors = context.colors;

        final effectivePadding =
            (AppSpacings.s8.horizontal + AppSpacings.s4.vertical).resolve(
              textDirection,
            );

        final alignment = (renderController.alignment.value ?? tooltipAlignment)
            .toAlignment();

        final edgeInsetScalars = EdgeInsets.only(
          left: max<double>(0, alignment.x).abs(),
          top: max<double>(0, alignment.y).abs(),
          right: min<double>(0, alignment.x).abs(),
          bottom: min<double>(0, alignment.y).abs(),
        );

        final margin = this.margin.resolve(textDirection);

        final targetMargin = EdgeInsets.only(
          left: (gap + _arrowSize.width) * edgeInsetScalars.left,
          top: (gap + _arrowSize.height) * edgeInsetScalars.top,
          right: (gap + _arrowSize.width) * edgeInsetScalars.right,
          bottom: (gap + _arrowSize.height) * edgeInsetScalars.bottom,
        );

        final portalMargin = EdgeInsets.only(
          left: margin.left * (1 - edgeInsetScalars.left),
          top: margin.top * (1 - edgeInsetScalars.top),
          right: margin.right * (1 - edgeInsetScalars.right),
          bottom: margin.bottom * (1 - edgeInsetScalars.bottom),
        );

        final balloonMargin = targetMargin + portalMargin;

        final placeholderPadding =
            balloonMargin +
            effectivePadding +
            const EdgeInsets.all(_borderWidth);

        const constraints = BoxConstraints(
          minWidth: 2 * _controlGap,
          minHeight: 2 * _controlGap,
        );

        return PortalTarget(
          anchor: const _MirrorConstraints(),
          portalCandidateLabels: const [AppTooltip._balloonPortalLabel],
          portalFollower: _TooltipBalloonTransition(
            visible: visible,
            renderController: renderController,
            child: ConstrainedBox(
              constraints: constraints,
              child: Container(
                decoration: BoxDecoration(
                  color: type.getBackgroundColor(colors),
                  border: Border.all(
                    color: type.getBorderColor(colors),
                    // Value under `_borderWidth` variable can change depending
                    // on project therefore it does not need to be redundant.
                    // ignore: avoid_redundant_argument_values
                    width: _borderWidth,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                margin: balloonMargin,
                child: Padding(
                  padding: effectivePadding,
                  child: AppText(
                    text,
                    style: AppTextStyles.bodyDefault,
                    color: type.getTextColor(colors),
                    textAlign: TextAlign.center,
                    textWidthBasis: TextWidthBasis.longestLine,
                  ),
                ),
              ),
            ),
          ),
          child: ExcludeSemantics(
            child: Opacity(
              opacity: 0,
              child: ConstrainedBox(
                constraints: constraints,
                child: Padding(
                  padding: placeholderPadding,
                  child: Container(
                    constraints: const BoxConstraints(
                      minWidth: 2 * _controlGap,
                    ),
                    child: AppText(
                      text,
                      style: AppTextStyles.bodyDefault,
                      textAlign: TextAlign.center,
                      textWidthBasis: TextWidthBasis.longestLine,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
