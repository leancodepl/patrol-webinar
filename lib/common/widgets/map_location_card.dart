import 'package:app_design_system/app_design_system.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart' show Card;
import 'package:flutter/widgets.dart';
import 'package:fts/common/keys/analytics_ids.dart';
import 'package:fts/data/contracts/contracts.dart';
import 'package:fts/features/map/widgets/map_badge.dart';
import 'package:fts/resources/strings.dart';
import 'package:fts/widgets/button/app_button.dart';
import 'package:fts/widgets/button/app_text_button.dart';
import 'package:url_launcher/url_launcher.dart';

enum MapLocationCardSize {
  small(height: 120, showCardHeader: false, maxTitleLines: 1),
  large(height: 200, showCardHeader: true, maxTitleLines: 2);

  const MapLocationCardSize({
    required this.height,
    required this.showCardHeader,
    required this.maxTitleLines,
  });

  final double height;
  final bool showCardHeader;
  final int maxTitleLines;
}

class MapLocationCard extends StatelessWidget {
  const MapLocationCard({
    super.key,
    required this.site,
    this.size = MapLocationCardSize.large,
    this.onCloseTap,
  });

  final SiteDTO site;
  final MapLocationCardSize size;
  final VoidCallback? onCloseTap;

  static const _cardMinWidth = 280.0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Card(
          elevation: 0,
          clipBehavior: Clip.antiAlias,
          color: context.colors.backgroundDefaultPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacings.s16.value),
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: _cardMinWidth,
              maxWidth: constraints.maxWidth,
              minHeight: size.height,
              maxHeight: size.height,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: constraints.maxWidth * 0.33,
                  decoration: BoxDecoration(
                    image: switch (site.photoUrl) {
                      null => null,
                      final url => DecorationImage(
                        image: CachedNetworkImageProvider(url),
                        fit: BoxFit.cover,
                      ),
                    },
                  ),
                ),
                Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (size.showCardHeader)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding:
                                  AppSpacings.s16.horizontal +
                                  AppSpacings.s16.top,
                              child: MapBadge(category: site.category),
                            ),
                            AppButton.icon(
                              analyticsId: AnalyticsIds.mapCardClose,
                              type: AppButtonType.tertiary,
                              onTap: () => onCloseTap?.call(),
                              icon: AppStandardIcons.xClose,
                              semanticsLabel: l10n(context).map_card_close,
                            ),
                          ],
                        ),
                      Expanded(
                        child: Padding(
                          padding: size.showCardHeader
                              ? AppSpacings.s16.horizontal +
                                    AppSpacings.s16.bottom
                              : AppSpacings.s16.all,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(
                                site.name,
                                maxLines: size.maxTitleLines,
                                style: AppTextStyles.headlineSmall,
                                color: context.colors.backgroundActivePrimary,
                              ),
                              AppSpacings.s4.verticalSpace,
                              AppText(
                                site.address,
                                maxLines: 1,
                                style: AppTextStyles.captionDefault,
                              ),
                              const Spacer(),
                              AppTextButton(
                                analyticsId: AnalyticsIds.mapCardNavigate,
                                type: AppTextButtonType.base,
                                semanticsLabel: l10n(context).map_card_navigate,
                                caption: l10n(context).map_card_navigate,
                                trailingIcon: AppStandardIcons.arrowNarrowRight,
                                onTap: _navigateToSite,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _navigateToSite() async {
    final googleMapsUrl = Uri(
      scheme: 'https',
      host: 'www.google.com',
      path: '/maps/search/',
      queryParameters: {
        'api': '1',
        'query': '${site.latitude},${site.longitude}',
        'query_place_id': site.gmapsPlaceId,
      },
    );
    await launchUrl(googleMapsUrl);
  }
}
