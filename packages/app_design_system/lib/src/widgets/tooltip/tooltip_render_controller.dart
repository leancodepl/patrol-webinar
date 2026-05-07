part of 'tooltip.dart';

class _TooltipRenderController {
  final alignment = ValueNotifier<_TooltipAlignment?>(null);
  final arrowAnimationAlignment = ValueNotifier<Alignment?>(null);
  final balloonAnimationAlignment = ValueNotifier<Alignment?>(null);
  final outOfBounds = ValueNotifier<bool>(false);

  Listenable get listenable => Listenable.merge([
    alignment,
    arrowAnimationAlignment,
    balloonAnimationAlignment,
    outOfBounds,
  ]);

  void updateAlignment(_TooltipAlignment? alignment) {
    this.alignment.value = alignment;
  }

  void updateBalloonAlignment(Alignment? alignment) {
    balloonAnimationAlignment.value = alignment;
  }

  void updateArrowAlignment(Alignment? alignment) {
    arrowAnimationAlignment.value = alignment;
  }

  void updateOutOfBounds(bool outOfBounds) {
    this.outOfBounds.value = outOfBounds;
  }

  void dispose() {
    alignment.dispose();
    arrowAnimationAlignment.dispose();
    balloonAnimationAlignment.dispose();
    outOfBounds.dispose();
  }
}
