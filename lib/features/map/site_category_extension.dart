import 'package:app_design_system/app_design_system.dart';
import 'package:flutter/widgets.dart';
import 'package:fts/data/contracts/contracts.dart';
import 'package:fts/resources/strings.dart';

extension SiteCategoryExtension on SiteCategoryDTO {
  String displayName(BuildContext context) {
    final s = l10n(context);
    return switch (this) {
      SiteCategoryDTO.event => s.map_categoryFilter_event,
      SiteCategoryDTO.afterParty => s.map_categoryFilter_afterParty,
      SiteCategoryDTO.beforeParty => s.map_categoryFilter_beforeParty,
      SiteCategoryDTO.leanCodeOffice => s.map_categoryFilter_leanCodeOffice,
      SiteCategoryDTO.cultural => s.map_categoryFilter_cultural,
      SiteCategoryDTO.museum => s.map_categoryFilter_museum,
      SiteCategoryDTO.park => s.map_categoryFilter_park,
      SiteCategoryDTO.bar => s.map_categoryFilter_bar,
      SiteCategoryDTO.food => s.map_categoryFilter_food,
      SiteCategoryDTO.other => s.map_categoryFilter_other,
    };
  }

  AppColor getBackgroundColor(BuildContext context) {
    final colors = context.colors;
    return switch (this) {
      SiteCategoryDTO.event => colors.backgroundMapMainEventBadge,
      SiteCategoryDTO.afterParty => colors.backgroundMapSideEventBadge,
      SiteCategoryDTO.beforeParty => colors.backgroundMapSideEventBadge,
      SiteCategoryDTO.leanCodeOffice => colors.backgroundMapLeancodeBadge,
      SiteCategoryDTO.cultural => colors.backgroundMapCulturalBadge,
      SiteCategoryDTO.museum => colors.backgroundMapMuseumBadge,
      SiteCategoryDTO.park => colors.backgroundMapParkBadge,
      SiteCategoryDTO.bar => colors.backgroundMapBarBadge,
      SiteCategoryDTO.food => colors.backgroundMapFoodBadge,
      SiteCategoryDTO.other => colors.backgroundMapOtherBadge,
    };
  }

  AppColor getForegroundColor(BuildContext context) {
    final colors = context.colors;
    return switch (this) {
      SiteCategoryDTO.event => colors.foregroundMapMainEvent,
      SiteCategoryDTO.afterParty => colors.foregroundMapSideEvent,
      SiteCategoryDTO.beforeParty => colors.foregroundMapSideEvent,
      SiteCategoryDTO.leanCodeOffice => colors.foregroundMapLeancode,
      SiteCategoryDTO.cultural => colors.foregroundMapCultural,
      SiteCategoryDTO.museum => colors.foregroundMapMuseum,
      SiteCategoryDTO.park => colors.foregroundMapPark,
      SiteCategoryDTO.bar => colors.foregroundMapBar,
      SiteCategoryDTO.food => colors.foregroundMapFood,
      SiteCategoryDTO.other => colors.foregroundMapOther,
    };
  }

  AppStandardIconData get icon => switch (this) {
    SiteCategoryDTO.event => AppStandardIcons.homeLine,
    SiteCategoryDTO.afterParty => AppStandardIcons.musicNote02,
    SiteCategoryDTO.beforeParty => AppStandardIcons.musicNote02,
    SiteCategoryDTO.leanCodeOffice => AppStandardIcons.leancode,
    SiteCategoryDTO.cultural => AppStandardIcons.stars01,
    SiteCategoryDTO.museum => AppStandardIcons.building07,
    SiteCategoryDTO.park => AppStandardIcons.sun,
    SiteCategoryDTO.bar => AppStandardIcons.musicNote01,
    SiteCategoryDTO.food => AppStandardIcons.layoutAlt02,
    SiteCategoryDTO.other => AppStandardIcons.asterisk02,
  };
}
