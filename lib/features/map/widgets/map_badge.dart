import 'package:app_design_system/app_design_system.dart';
import 'package:flutter/widgets.dart';
import 'package:fts/data/contracts/contracts.dart';
import 'package:fts/features/map/site_category_extension.dart';

class MapBadge extends StatelessWidget {
  const MapBadge({super.key, required this.category});

  final SiteCategoryDTO category;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSpacings.s8.horizontal + AppSpacings.s4.vertical,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSpacings.s16.value),
        color: category.getBackgroundColor(context),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppIcon(
            category.icon,
            size: AppStandardIconSize.s16,
            color: category.getForegroundColor(context),
            semanticsLabel: null,
          ),
          AppSpacings.s4.horizontalSpace,
          Flexible(
            child: AppText(
              category.displayName(context),
              style: AppTextStyles.captionDefault,
              color: category.getForegroundColor(context),
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}
