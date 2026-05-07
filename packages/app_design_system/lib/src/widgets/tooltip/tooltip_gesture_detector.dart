part of 'tooltip.dart';

class _TooltipGestureDetector extends StatelessWidget {
  const _TooltipGestureDetector({
    required this.tag,
    required this.behavior,
    required this.showByInsideGesture,
    required this.hideByOutsideGesture,
    required this.child,
  });

  final Object tag;
  final AppTooltipBehavior? behavior;
  final bool showByInsideGesture;
  final bool hideByOutsideGesture;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final onTap = switch (behavior) {
      AppTooltipBehavior.tap when showByInsideGesture =>
        (_) => context.toggleTooltip(tag),
      _ => null,
    };

    final onLongPress = switch (behavior) {
      AppTooltipBehavior.longPress when showByInsideGesture =>
        () => context.showTooltip(tag),
      _ => null,
    };

    return TapRegion(
      onTapInside: onTap,
      onTapOutside: switch (hideByOutsideGesture) {
        true => (event) => context.hideTooltip(tag),
        false => null,
      },
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onLongPress: onLongPress,
        child: child,
      ),
    );
  }
}
