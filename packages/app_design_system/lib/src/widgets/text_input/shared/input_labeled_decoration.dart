// ignore_for_file: use_design_system_item_AppColors or AppTextStyles, use_design_system_item_AppTextField, use_design_system_item_AppTextSpan, use_design_system_item_AppTextStyle, use_design_system_item_AppDefaultTextStyle

import 'package:app_design_system/src/styleguide/spacing.dart';
import 'package:app_design_system/src/styleguide/typography.dart';
import 'package:app_design_system/src/utils/dry_intrinsic_height.dart';
import 'package:app_design_system/src/widgets/text/text_widget.dart';
import 'package:app_design_system/src/widgets/text_input/shared/input_clear_button.dart';
import 'package:app_design_system/src/widgets/text_input/shared/input_label.dart';
import 'package:app_design_system/src/widgets/text_input/shared/input_placeholder.dart';
import 'package:app_design_system/src/widgets/text_input/shared/normalize_input_baseline.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

@internal
class InputLabeledDecoration extends StatelessWidget {
  const InputLabeledDecoration({
    super.key,
    required this.enabled,
    required this.textField,
    required this.padding,
    required this.focusNode,
    required this.controller,
    required this.textStyle,
    required this.label,
    required this.placeholder,
    required this.help,
    required this.hint,
    required this.error,
    required this.clearable,
    required this.onClear,
  });

  final bool enabled;
  final Widget textField;
  final EdgeInsetsDirectional padding;
  final FocusNode focusNode;
  final TextEditingController controller;
  final AppTextStyle textStyle;
  final String? label;
  final String? placeholder;
  final String? help;
  final String? hint;
  final String? error;
  final bool clearable;
  final VoidCallback? onClear;

  static const _enterCurve = Curves.ease;
  static const _leaveCurve = Interval(0, 0.7, curve: Curves.ease);

  static Curve getVisibilityCurve({required bool visible}) => switch (visible) {
    true => InputLabeledDecoration._enterCurve,
    false => InputLabeledDecoration._leaveCurve,
  };

  bool get _shouldShowClearButton => controller.text.isNotEmpty;

  bool get _placeholderShown =>
      (label == null || focusNode.hasFocus) && controller.text.isEmpty;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Stack(
            fit: StackFit.passthrough,
            children: [
              if (placeholder case final placeholder?)
                ExcludeSemantics(
                  child: IgnoreBaseline(
                    child: ListenableBuilder(
                      listenable: Listenable.merge([focusNode, controller]),
                      builder: (context, child) => IgnorePointer(
                        child: Padding(
                          padding: padding,
                          child: InputPlaceholder(
                            visible: _placeholderShown,
                            enabled: enabled,
                            text: placeholder,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              NormalizeInputBaseline(
                baseline: _getBaseline(context),
                child: DryIntrinsicHeight(child: ClipRect(child: textField)),
              ),
              if (label case final label?)
                IgnorePointer(
                  child: Padding(
                    padding: padding,
                    child: InputInternalLabel(
                      focusNode: focusNode,
                      controller: controller,
                      enabled: enabled,
                      text: label,
                    ),
                  ),
                ),
            ],
          ),
        ),
        if (clearable)
          ExcludeSemantics(
            child: ListenableBuilder(
              listenable: controller,
              builder: (context, child) {
                if (!_shouldShowClearButton) {
                  return const SizedBox.shrink();
                }

                return Padding(
                  padding: AppSpacings.s8.start + padding,
                  child: InputClearButton(
                    enabled: enabled,
                    onTap: () {
                      controller.clear();
                      onClear?.call();
                    },
                  ),
                );
              },
            ),
          ),
      ],
    );
  }

  double _getBaseline(BuildContext context) {
    final text = AppText('Example Text', style: textStyle);
    final painter = text.painterOf(context)..layout();

    return painter.computeDistanceToActualBaseline(TextBaseline.alphabetic) +
        padding.top;
  }
}
