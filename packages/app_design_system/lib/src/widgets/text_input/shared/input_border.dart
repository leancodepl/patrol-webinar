import 'package:app_design_system/src/styleguide/colors.dart';
import 'package:app_design_system/src/utils/color_tween_builder.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

@internal
class InputBorder extends StatelessWidget {
  const InputBorder({
    super.key,
    required this.focusNode,
    required this.error,
    required this.enabled,
    required this.child,
  });

  final FocusNode focusNode;
  final bool error;
  final bool enabled;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return ListenableBuilder(
      listenable: focusNode,
      builder: (context, _) {
        final focused = focusNode.hasFocus;

        final backgroundColor = switch (enabled) {
          false => colors.backgroundDisabledTertiary,
          true => colors.backgroundDefaultPrimary,
        };

        final outerBorderColor = switch (enabled) {
          false => colors.transparent,
          true => switch (error) {
            true => switch (focused) {
              true => colors.backgroundDangerTertiary,
              false => colors.transparent,
            },
            false => switch (focused) {
              true => colors.backgroundActiveTertiary,
              false => colors.transparent,
            },
          },
        };

        final innerBorderColor = switch (enabled) {
          false => colors.foregroundDisabledTertiary,
          true => switch (error) {
            true => colors.foregroundDangerPrimary,
            false => switch (focused) {
              true => colors.foregroundActivePrimary,
              false => colors.foregroundDefaultQuaternary,
            },
          },
        };

        return ColorTweenBuilder(
          color: backgroundColor,
          builder: (context, backgroundColor, child) => ColorTweenBuilder(
            color: outerBorderColor,
            builder: (context, outerBorderColor, child) => ColorTweenBuilder(
              color: innerBorderColor,
              builder: (context, innerBorderColor, child) => DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    width: 3,
                    color: outerBorderColor,
                    strokeAlign: BorderSide.strokeAlignOutside,
                  ),
                ),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: backgroundColor,
                    border: Border.all(color: innerBorderColor),
                  ),
                  child: child,
                ),
              ),
              child: child,
            ),
            child: child,
          ),
          child: child,
        );
      },
    );
  }
}
