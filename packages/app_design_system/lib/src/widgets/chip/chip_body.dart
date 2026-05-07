import 'package:app_design_system/src/styleguide/colors.dart';
import 'package:app_design_system/src/styleguide/spacing.dart';
import 'package:app_design_system/src/styleguide/typography.dart';
import 'package:app_design_system/src/widgets/chip/chip_colors.dart';
import 'package:app_design_system/src/widgets/chip/chip_remove_icon_button.dart';
import 'package:app_design_system/src/widgets/icon/icon.dart';
import 'package:app_design_system/src/widgets/text/text.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

@internal
class ChipBody extends StatelessWidget {
  const ChipBody({
    super.key,
    required this.enabled,
    required this.label,
    required this.textColor,
    required this.borderColor,
    required this.backgroundColor,
    this.iconColor,
    this.prefixIcon,
    this.prefixIconSemanticsLabel,
    this.suffixIcon,
    this.suffixIconSemanticsLabel,
    this.onCloseTap,
    this.closeButtonKey,
  });

  final bool enabled;
  final String label;
  final AppColor textColor;
  final AppColor borderColor;
  final AppColor backgroundColor;
  final AppColor? iconColor;
  final AppStandardIconData? prefixIcon;
  final String? prefixIconSemanticsLabel;
  final AppStandardIconData? suffixIcon;
  final String? suffixIconSemanticsLabel;
  final VoidCallback? onCloseTap;
  final Key? closeButtonKey;

  static const borderRadius = BorderRadius.all(Radius.circular(12));
  static const iconSize = AppStandardIconSize.s16;

  @override
  Widget build(BuildContext context) {
    final resolvedPadding = _resolvePadding();

    return ChipColorsTween(
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      textColor: textColor,
      iconColor: iconColor,
      builder: (context, backgroundColor, borderColor, textColor, iconColor) {
        // DecoratedBox and Padding are not merged into Container because it would
        // expand Container's padding by border (we don't want that).
        return DecoratedBox(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: borderRadius,
            border: Border.all(color: borderColor),
          ),
          child: Padding(
            padding: resolvedPadding,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (prefixIcon case final prefixIcon?) ...[
                  AppIcon(
                    prefixIcon,
                    size: iconSize,
                    semanticsLabel: prefixIconSemanticsLabel,
                    color: iconColor,
                  ),
                  AppSpacings.s8.horizontalSpace,
                ],
                Flexible(
                  child: AppText(
                    label,
                    style: AppTextStyles.bodyDefault,
                    color: textColor,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                  ),
                ),
                if (onCloseTap case final onCloseTap?)
                  ChipRemoveIconButton(
                    key: closeButtonKey,
                    enabled: enabled,
                    onTap: onCloseTap,
                    size: iconSize,
                  )
                else if (suffixIcon case final suffixIcon?) ...[
                  AppSpacings.s8.horizontalSpace,
                  AppIcon(
                    suffixIcon,
                    size: iconSize,
                    semanticsLabel: suffixIconSemanticsLabel,
                    color: iconColor,
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  EdgeInsetsDirectional _resolvePadding() {
    final startPadding = prefixIcon != null && suffixIcon == null
        ? AppSpacings.s8.start
        : AppSpacings.s16.start;

    final endPadding = suffixIcon != null && prefixIcon == null
        ? AppSpacings.s8.end
        : onCloseTap != null
        ? AppSpacings.zero.end
        : AppSpacings.s16.end;

    final verticalPadding = onCloseTap != null
        ? AppSpacings.zero.vertical
        : AppSpacings.s4.vertical;

    return startPadding + endPadding + verticalPadding;
  }
}
