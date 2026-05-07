import 'package:app_design_system/src/styleguide/colors.dart';
import 'package:app_design_system/src/styleguide/typography.dart';
import 'package:app_design_system/src/utils/color_tween_builder.dart';
import 'package:app_design_system/src/widgets/text/text_widget.dart';
import 'package:app_design_system/src/widgets/text_input/shared/input_labeled_decoration.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

@internal
class InputPlaceholder extends StatelessWidget {
  const InputPlaceholder({
    super.key,
    required this.visible,
    required this.enabled,
    required this.text,
  });

  final bool visible;
  final bool enabled;
  final String text;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    final color = switch (visible) {
      false => colors.transparent,
      true => switch (enabled) {
        false => colors.foregroundDefaultTertiary,
        true => colors.foregroundDisabledTertiary,
      },
    };

    final curve = InputLabeledDecoration.getVisibilityCurve(visible: visible);

    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: ColorTweenBuilder(
        color: color,
        curve: curve,
        builder: (context, color, _) => AppText(
          text,
          style: AppTextStyles.bodyDefault,
          maxLines: 1,
          color: color,
        ),
      ),
    );
  }
}
