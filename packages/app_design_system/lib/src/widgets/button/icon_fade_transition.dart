import 'package:app_design_system/src/styleguide/motion.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

@internal
class IconFadeTransition extends StatelessWidget {
  const IconFadeTransition({super.key, required this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      curve: AppCurves.fadeInOut,
      duration: AppDurations.fadeInOut,
      child: AnimatedSwitcher(
        switchInCurve: AppCurves.fadeInOut,
        switchOutCurve: AppCurves.fadeInOut,
        duration: AppDurations.fadeInOut,
        transitionBuilder: (child, animation) =>
            FadeTransition(opacity: animation, child: child),
        child: child,
      ),
    );
  }
}
