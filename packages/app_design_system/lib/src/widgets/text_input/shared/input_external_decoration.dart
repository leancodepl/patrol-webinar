// We need Material Theme here
// ignore_for_file: app_lint/use_design_system_item_AppColors_or_AppTextStyles

import 'package:app_design_system/src/styleguide/spacing.dart';
import 'package:app_design_system/src/widgets/text_input/shared/input_error.dart';
import 'package:app_design_system/src/widgets/text_input/shared/input_hint.dart';
import 'package:app_design_system/src/widgets/text_input/shared/input_label.dart';
import 'package:flutter/material.dart'
    show Material, MaterialType, Theme, VisualDensity;
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

@internal
class InputExternalDecoration extends StatelessWidget {
  const InputExternalDecoration({
    super.key,
    required this.enabled,
    required this.label,
    required this.hint,
    required this.error,
    required this.controller,
    required this.focusNode,
    required this.child,
  });

  final bool enabled;
  final String? label;
  final String? hint;
  final String? error;
  final TextEditingController controller;
  final FocusNode focusNode;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Theme(
        data: Theme.of(context).copyWith(visualDensity: VisualDensity.standard),
        child: Semantics(
          explicitChildNodes: true,
          label: label,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (label case final label?)
                ExcludeSemantics(
                  child: InputExternalLabel(
                    focusNode: focusNode,
                    controller: controller,
                    enabled: enabled,
                    error: error != null,
                    text: label,
                  ),
                ),
              AppSpacings.s4.verticalSpace,
              child,
              if (hint case final hint?) ...[
                AppSpacings.s4.verticalSpace,
                InputHint(enabled: enabled, text: hint),
              ],
              if (error case final error?) ...[
                AppSpacings.s4.verticalSpace,
                InputError(text: error),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
