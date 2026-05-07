part of 'tooltip.dart';

const _duration = Duration(milliseconds: 250);
const _curve = Curves.ease;

class _TooltipBalloonTransition extends StatelessWidget {
  const _TooltipBalloonTransition({
    required this.visible,
    required this.renderController,
    required this.child,
  });

  final bool visible;
  final _TooltipRenderController renderController;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return _TooltipTransition(
      visible: visible,
      animationAlignmentNotifier: renderController.balloonAnimationAlignment,
      outOfBoundsNotifier: renderController.outOfBounds,
      child: child,
    );
  }
}

class _TooltipArrowTransition extends StatelessWidget {
  const _TooltipArrowTransition({
    required this.visible,
    required this.renderController,
    required this.child,
  });

  final bool visible;
  final _TooltipRenderController renderController;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return _TooltipTransition(
      visible: visible,
      animationAlignmentNotifier: renderController.arrowAnimationAlignment,
      outOfBoundsNotifier: renderController.outOfBounds,
      child: child,
    );
  }
}

class _TooltipTransition extends StatelessWidget {
  const _TooltipTransition({
    required this.visible,
    required this.animationAlignmentNotifier,
    required this.outOfBoundsNotifier,
    required this.child,
  });

  final bool visible;
  final ValueNotifier<Alignment?> animationAlignmentNotifier;
  final ValueNotifier<bool> outOfBoundsNotifier;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([
        animationAlignmentNotifier,
        outOfBoundsNotifier,
      ]),
      builder: (context, child) {
        final state = switch (visible) {
          true => switch (outOfBoundsNotifier.value) {
            true => 0.0,
            false => 1.0,
          },
          false => 0.0,
        };

        return AnimatedScale(
          scale: state,
          duration: _duration,
          curve: _curve,
          alignment: animationAlignmentNotifier.value ?? Alignment.center,
          child: AnimatedOpacity(
            opacity: state,
            duration: _duration,
            curve: _curve,
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
