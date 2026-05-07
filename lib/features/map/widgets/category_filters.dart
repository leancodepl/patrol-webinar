import 'package:flutter/material.dart';
import 'package:fts/data/contracts/contracts.dart';
import 'package:fts/resources/strings.dart';
import 'package:fts/widgets/widgets.dart';

class CategoryFilters extends StatelessWidget {
  const CategoryFilters({
    super.key,
    this.selectedCategory,
    required this.onCategorySelected,
  });

  final SiteCategoryFilter? selectedCategory;
  final ValueChanged<SiteCategoryFilter> onCategorySelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacings.s12.vertical,
      child: SizedBox(
        height: AppSpacings.s32.value,
        child: ListView.separated(
          padding: AppSpacings.s16.horizontal,
          scrollDirection: Axis.horizontal,
          itemCount: SiteCategoryFilter.values.length,
          separatorBuilder: (context, index) => AppSpacings.s8.horizontalSpace,
          itemBuilder: (context, index) {
            final filter = SiteCategoryFilter.values[index];
            return AppChoiceChip(
              label: filter.displayName(context),
              selected: selectedCategory == filter,
              onTap: () => onCategorySelected(filter),
            );
          },
        ),
      ),
    );
  }
}

enum SiteCategoryFilter {
  all,
  event,
  sideEvent,
  leanCodeOffice,
  cultural,
  museum,
  park,
  bar,
  food,
  other;

  List<SiteCategoryDTO> toDTOs() => switch (this) {
    all => [],
    event => [SiteCategoryDTO.event],
    sideEvent => [SiteCategoryDTO.afterParty, SiteCategoryDTO.beforeParty],
    leanCodeOffice => [SiteCategoryDTO.leanCodeOffice],
    cultural => [SiteCategoryDTO.cultural],
    museum => [SiteCategoryDTO.museum],
    park => [SiteCategoryDTO.park],
    bar => [SiteCategoryDTO.bar],
    food => [SiteCategoryDTO.food],
    other => [SiteCategoryDTO.other],
  };

  String displayName(BuildContext context) {
    final s = l10n(context);
    return switch (this) {
      all => s.map_categoryFilter_all,
      event => s.map_categoryFilter_event,
      sideEvent => s.map_categoryFilter_sideEvent,
      leanCodeOffice => s.map_categoryFilter_leanCodeOffice,
      cultural => s.map_categoryFilter_cultural,
      museum => s.map_categoryFilter_museum,
      park => s.map_categoryFilter_park,
      bar => s.map_categoryFilter_bar,
      food => s.map_categoryFilter_food,
      other => s.map_categoryFilter_other,
    };
  }
}
