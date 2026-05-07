import 'package:app_design_system/src/styleguide/colors.dart';
import 'package:app_design_system/src/styleguide/spacing.dart';
import 'package:app_design_system/src/styleguide/typography.dart';
import 'package:app_design_system/src/utils/pointer_surface.dart';
import 'package:app_design_system/src/widgets/list_item/list_item_button.dart';
import 'package:app_design_system/src/widgets/list_item/list_item_icon.dart';
import 'package:app_design_system/src/widgets/list_item/list_item_toggle.dart';
import 'package:app_design_system/src/widgets/text/text.dart';
import 'package:flutter/widgets.dart';

export 'list_item_icon.dart';

class AppListItem extends StatelessWidget {
  const AppListItem({
    super.key,
    this.leadingIcon,
    this.overline,
    required this.title,
    this.subtitle,
    this.value,
    this.toggle,
    this.button,
    this.trailingIcon,
    this.onTap,
  });

  final AppListItemIcon? leadingIcon;
  final String? overline;
  final String title;
  final String? subtitle;
  final String? value;
  final AppListItemToggle? toggle;
  final AppListItemButton? button;
  final AppListItemIcon? trailingIcon;
  final VoidCallback? onTap;

  static const _colorChangeDuration = Duration(milliseconds: 250);
  static const _colorChangeCurve = Curves.easeInOut;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return AppPointerSurface(
      enabled: onTap != null,
      onTap: onTap,
      builder: (context, states) {
        final pressed = states.containsPressed;

        return TweenAnimationBuilder(
          duration: _colorChangeDuration,
          curve: _colorChangeCurve,
          tween: AppColorTween(
            end: switch (pressed) {
              true => colors.backgroundDefaultPrimaryPressed,
              false => colors.backgroundDefaultPrimary,
            },
          ),
          builder: (context, color, child) => Container(
            color: color,
            padding: AppSpacings.s16.all,
            child: Row(
              spacing: AppSpacings.s16.value,
              children: [
                ?leadingIcon,
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final maxWidth = constraints.maxWidth;

                      return Row(
                        spacing: AppSpacings.s16.value,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                if (overline case final overline?)
                                  AppText(
                                    overline,
                                    style: AppTextStyles.overline,
                                    color: colors.foregroundDefaultSecondary,
                                  ),
                                AppText(
                                  title,
                                  style: AppTextStyles.bodyDefault,
                                  color: colors.foregroundDefaultPrimary,
                                ),
                                if (subtitle case final subtitle?)
                                  AppText(
                                    subtitle,
                                    style: AppTextStyles.captionDefault,
                                    color: colors.foregroundDefaultSecondary,
                                  ),
                              ],
                            ),
                          ),
                          if (value case final value?)
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: maxWidth * 0.8,
                              ),
                              child: AppText(
                                value,
                                style: AppTextStyles.bodyDefault,
                                color: colors.foregroundDefaultSecondary,
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                ),
                ?toggle,
                ?button,
                ?trailingIcon,
              ],
            ),
          ),
        );
      },
    );
  }
}
