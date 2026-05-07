import 'package:app_design_system/src/styleguide/colors.dart';
import 'package:app_design_system/src/styleguide/spacing.dart';
import 'package:app_design_system/src/styleguide/typography.dart';
import 'package:app_design_system/src/widgets/icon/icon.dart';
import 'package:app_design_system/src/widgets/text/text.dart';
import 'package:flutter/widgets.dart';

enum AppBadgeType {
  info,
  success,
  warning,
  danger;

  AppColor getForegroundColor(AppColors colors) => switch (this) {
    info => colors.foregroundInfoPrimary,
    success => colors.foregroundSuccessPrimary,
    warning => colors.foregroundWarningPrimary,
    danger => colors.foregroundDangerPrimary,
  };

  AppColor getBackgroundColor(AppColors colors) => switch (this) {
    info => colors.backgroundInfoTertiary,
    success => colors.backgroundSuccessTertiary,
    warning => colors.backgroundWarningTertiary,
    danger => colors.backgroundDangerTertiary,
  };
}

class AppBadge extends StatelessWidget {
  const AppBadge({
    super.key,
    this.leadingIcon,
    required this.caption,
    this.trailingIcon,
    required this.type,
  });

  final AppStandardIconData? leadingIcon;
  final String caption;
  final AppStandardIconData? trailingIcon;
  final AppBadgeType type;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    final foregroundColor = type.getForegroundColor(colors);

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: type.getBackgroundColor(colors),
      ),
      child: Padding(
        padding: AppSpacings.s8.horizontal + AppSpacings.s4.vertical,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (leadingIcon case final icon?) ...[
              AppIcon(
                icon,
                size: AppStandardIconSize.s16,
                color: foregroundColor,
                semanticsLabel: null,
              ),
              AppSpacings.s4.horizontalSpace,
            ],
            Flexible(
              child: AppText(
                caption,
                style: AppTextStyles.captionDefault,
                color: foregroundColor,
                maxLines: 1,
              ),
            ),
            if (trailingIcon case final icon?) ...[
              AppSpacings.s4.horizontalSpace,
              AppIcon(
                icon,
                size: AppStandardIconSize.s16,
                color: foregroundColor,
                semanticsLabel: null,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
