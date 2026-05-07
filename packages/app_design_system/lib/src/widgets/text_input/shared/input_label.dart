import 'package:app_design_system/src/styleguide/colors.dart';
import 'package:app_design_system/src/styleguide/typography.dart';
import 'package:app_design_system/src/utils/color_tween_builder.dart';
import 'package:app_design_system/src/widgets/text/text_widget.dart';
import 'package:app_design_system/src/widgets/text_input/shared/input_label_position.dart';
import 'package:app_design_system/src/widgets/text_input/shared/input_labeled_decoration.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

@internal
class InputExternalLabel extends StatelessWidget {
  const InputExternalLabel({
    super.key,
    required this.focusNode,
    required this.controller,
    required this.enabled,
    required this.error,
    required this.text,
  });

  final FocusNode focusNode;
  final TextEditingController controller;
  final bool enabled;
  final bool error;
  final String text;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return ListenableBuilder(
      listenable: Listenable.merge([focusNode, controller]),
      builder: (context, child) {
        final visible = InputLabelPosition.resolve(
          focusNode,
          controller,
        ).isExternal;

        final color = switch (visible) {
          false => colors.transparent,
          true => switch (enabled) {
            false => colors.foregroundDisabledSecondary,
            true => switch (error) {
              true => colors.foregroundDangerPrimary,
              false => colors.foregroundDefaultSecondary,
            },
          },
        };

        return Align(
          alignment: AlignmentDirectional.centerStart,
          child: ColorTweenBuilder(
            color: color,
            builder: (context, color, child) => AppText(
              text,
              style: AppTextStyles.captionDefault,
              color: color,
            ),
          ),
        );
      },
    );
  }
}

@internal
class InputInternalLabel extends StatelessWidget {
  const InputInternalLabel({
    super.key,
    required this.focusNode,
    required this.controller,
    required this.enabled,
    required this.text,
  });

  final FocusNode focusNode;
  final TextEditingController controller;
  final bool enabled;
  final String text;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return ListenableBuilder(
      listenable: Listenable.merge([focusNode, controller]),
      builder: (context, child) {
        final visible = InputLabelPosition.resolve(
          focusNode,
          controller,
        ).isInternal;

        final color = switch (visible) {
          false => colors.transparent,
          true => switch (enabled) {
            false => colors.foregroundDisabledSecondary,
            true => colors.foregroundDefaultSecondary,
          },
        };

        final curve = InputLabeledDecoration.getVisibilityCurve(
          visible: visible,
        );

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
      },
    );
  }
}
