import 'package:app_design_system/src/styleguide/colors.dart';
import 'package:app_design_system/src/styleguide/spacing.dart';
import 'package:app_design_system/src/styleguide/typography.dart';
import 'package:app_design_system/src/utils/pointer_surface.dart';
import 'package:app_design_system/src/widgets/selection_control/widgets/checkbox_body.dart';
import 'package:app_design_system/src/widgets/selection_control_field/widgets/colors.dart';
import 'package:app_design_system/src/widgets/selection_control_field/widgets/required_asterisk.dart';
import 'package:app_design_system/src/widgets/text/text.dart';
import 'package:flutter/widgets.dart';

typedef LabelBuilder =
    Widget Function(BuildContext context, AppColor labelColor);

class AppCheckboxField extends StatelessWidget {
  AppCheckboxField({
    super.key,
    this.checkboxBodyKey,
    this.enabled = true,
    this.required = false,
    required String label,
    this.description,
    this.error,
    this.value,
    required bool this.checkboxValue,
    required this.onChanged,
  }) : labelBuilder = ((context, labelColor) =>
           AppText(label, style: AppTextStyles.bodyDefault, color: labelColor));

  AppCheckboxField.tristate({
    super.key,
    this.checkboxBodyKey,
    this.enabled = true,
    this.required = false,
    required String label,
    this.description,
    this.error,
    this.value,
    required this.checkboxValue,
    required this.onChanged,
  }) : labelBuilder = ((context, labelColor) =>
           AppText(label, style: AppTextStyles.bodyDefault, color: labelColor));

  const AppCheckboxField.customTitle({
    super.key,
    this.checkboxBodyKey,
    this.enabled = true,
    this.required = false,
    required this.labelBuilder,
    this.description,
    this.error,
    this.value,
    required bool this.checkboxValue,
    required this.onChanged,
  });

  final Key? checkboxBodyKey;
  final bool enabled;
  final bool required;
  final LabelBuilder labelBuilder;
  final String? description;
  final String? error;
  final String? value;
  final bool? checkboxValue;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    final checked = switch (checkboxValue) {
      true => true,
      false || null => false,
    };

    final mixed = switch (checkboxValue) {
      null => true,
      false || true => false,
    };

    return Semantics(
      enabled: enabled,
      checked: checked,
      mixed: mixed,
      child: AppPointerSurface(
        enabled: enabled,
        onTap: () => onChanged.call(!checked),
        builder: (context, states) => SelectionControlFieldColorsTween(
          colors: colors,
          enabled: enabled,
          builder:
              (
                context,
                asteriskColor,
                descriptionColor,
                valueColor,
                labelColor,
              ) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CheckboxBody(
                      key: checkboxBodyKey,
                      enabled: enabled,
                      checked: checked,
                      mixed: mixed,
                      hasError: error != null,
                      pressed: states.containsPressed,
                    ),
                    if (required)
                      RequiredAsterisk(color: asteriskColor)
                    else
                      AppSpacings.s8.horizontalSpace,
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: labelBuilder(context, labelColor),
                              ),
                              if (value case final value?) ...[
                                AppSpacings.s8.horizontalSpace,
                                AppText(
                                  value,
                                  style: AppTextStyles.bodyDefault,
                                  color: valueColor,
                                ),
                              ],
                            ],
                          ),
                          if (description case final description?) ...[
                            AppSpacings.s4.verticalSpace,
                            AppText(
                              description,
                              style: AppTextStyles.captionDefault,
                              color: descriptionColor,
                            ),
                          ],
                          if (error case final error? when enabled) ...[
                            AppSpacings.s4.verticalSpace,
                            AppText(
                              error,
                              style: AppTextStyles.captionDefault,
                              color: colors.foregroundDangerPrimary,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                );
              },
        ),
      ),
    );
  }
}
