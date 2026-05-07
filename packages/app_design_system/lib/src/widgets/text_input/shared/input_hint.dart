import 'package:app_design_system/src/styleguide/colors.dart';
import 'package:app_design_system/src/styleguide/typography.dart';
import 'package:app_design_system/src/utils/color_tween_builder.dart';
import 'package:app_design_system/src/widgets/text/text_widget.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

@internal
class InputHint extends StatelessWidget {
  const InputHint({super.key, required this.enabled, required this.text});

  final bool enabled;
  final String text;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    final color = switch (enabled) {
      false => colors.foregroundDisabledSecondary,
      true => colors.foregroundDefaultSecondary,
    };

    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: ColorTweenBuilder(
        color: color,
        builder: (context, color, child) =>
            AppText(text, style: AppTextStyles.captionDefault, color: color),
      ),
    );
  }
}
