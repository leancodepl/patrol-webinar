import 'package:app_design_system/src/styleguide/colors.dart';
import 'package:app_design_system/src/styleguide/spacing.dart';
import 'package:app_design_system/src/styleguide/typography.dart';
import 'package:app_design_system/src/utils/pointer_surface.dart';
import 'package:app_design_system/src/widgets/selection_control/widgets/radio_body.dart';
import 'package:app_design_system/src/widgets/selection_control_field/widgets/colors.dart';
import 'package:app_design_system/src/widgets/selection_control_field/widgets/required_asterisk.dart';
import 'package:app_design_system/src/widgets/text/text.dart';
import 'package:flutter/widgets.dart';

class AppRadioField<T> extends StatelessWidget {
  const AppRadioField({
    super.key,
    this.enabled = true,
    this.required = false,
    required this.label,
    this.description,
    this.error,
    this.value,
    required this.radioValue,
    required this.radioGroupValue,
    required this.onChanged,
  });

  final bool enabled;
  final bool required;
  final String label;
  final String? description;
  final String? error;
  final String? value;
  final T radioValue;
  final T radioGroupValue;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Semantics(
      enabled: enabled,
      selected: radioValue == radioGroupValue,
      inMutuallyExclusiveGroup: true,
      child: AppPointerSurface(
        enabled: enabled,
        onTap: () => onChanged(radioValue),
        builder: (context, states) {
          return SelectionControlFieldColorsTween(
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
                      RadioBody(
                        enabled: enabled,
                        selected: radioValue == radioGroupValue,
                        danger: error != null,
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
                                  child: AppText(
                                    label,
                                    style: AppTextStyles.bodyDefault,
                                    color: labelColor,
                                  ),
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
          );
        },
      ),
    );
  }
}
