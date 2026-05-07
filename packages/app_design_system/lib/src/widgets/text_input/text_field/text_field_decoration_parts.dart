import 'package:app_design_system/src/styleguide/colors.dart';
import 'package:app_design_system/src/styleguide/spacing.dart';
import 'package:app_design_system/src/styleguide/typography.dart';
import 'package:app_design_system/src/utils/color_tween_builder.dart';
import 'package:app_design_system/src/widgets/icon/icon.dart';
import 'package:app_design_system/src/widgets/text/text_widget.dart';
import 'package:app_design_system/src/widgets/text_input/shared/input_button.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

@internal
class TextFieldAffixText extends StatelessWidget {
  const TextFieldAffixText({
    super.key,
    required this.text,
    required this.enabled,
  });

  final String text;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    final color = switch (enabled) {
      true => colors.foregroundDefaultSecondary,
      false => colors.foregroundDisabledSecondary,
    };

    return ColorTweenBuilder(
      color: color,
      builder: (context, color, _) => AppText(
        text,
        style: AppTextStyles.bodyDefault,
        color: color,
        maxLines: 1,
      ),
    );
  }
}

@internal
class TextFieldOption extends StatelessWidget {
  const TextFieldOption({
    super.key,
    required this.enabled,
    required this.selected,
    required this.text,
    required this.onTap,
  });

  final bool enabled;
  final bool selected;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InputButton(
      spacing: AppSpacings.zero,
      enabled: enabled,
      type: InputButtonType.brand,
      variant: InputButtonCaption(
        caption: text,
        trailingIcon: switch (selected) {
          true => AppStandardIcons.chevronUp,
          false => AppStandardIcons.chevronDown,
        },
      ),
      onTap: onTap,
    );
  }
}

@internal
class TextFieldAction extends StatelessWidget {
  const TextFieldAction({
    super.key,
    required this.enabled,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  final bool enabled;
  final AppStandardIconData? icon;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InputButton(
      spacing: AppSpacings.s4,
      enabled: enabled,
      type: InputButtonType.brand,
      variant: InputButtonCaption(caption: text, leadingIcon: icon),
      onTap: onTap,
    );
  }
}
