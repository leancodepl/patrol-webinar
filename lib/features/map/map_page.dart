import 'package:app_design_system/app_design_system.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fts/common/keys/analytics_ids.dart';
import 'package:fts/common/services/location_service.dart';
import 'package:fts/common/util/app_platform.dart';
import 'package:fts/common/widgets/map_location_card.dart';
import 'package:fts/data/contracts/contracts.dart';
import 'package:fts/features/error_page/error_page.dart';
import 'package:fts/features/loading_page/loading_page.dart';
import 'package:fts/features/map/map_cubit.dart';
import 'package:fts/features/map/widgets/category_filters.dart';
import 'package:fts/features/map/widgets/dynamic_map.dart';
import 'package:fts/features/widgets/shell_top_bar.dart';
import 'package:fts/resources/strings.dart';
import 'package:fts/widgets/button/app_button.dart';
import 'package:fts/widgets/context_snackbar_padding_extension.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:leancode_cubit_utils/leancode_cubit_utils.dart';
import 'package:leancode_hooks/leancode_hooks.dart';
import 'package:location/location.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MapCubit(context.read())..run(),
      child: const _MapContent(),
    );
  }
}

class _MapContent extends HookWidget {
  const _MapContent();

  @override
  Widget build(BuildContext context) {
    final s = l10n(context);

    final selectedSite = useState<SiteDTO?>(null);
    final selectedCategory = useState(SiteCategoryFilter.all);
    final mapController = useRef<GoogleMapController?>(null);

    return AppScaffold(
      useBodyPadding: false,
      topBar: ShellTopBar(title: s.navBar_map),
      body: RequestCubitBuilder(
        onInitial: (_) => const LoadingPage(),
        onLoading: (_) => const LoadingPage(),
        onError: (_, _, retry) => ErrorPage(onTryAgain: retry),
        cubit: context.read<MapCubit>(),
        onSuccess: (context, state) {
          final visibleSites = state.sites
              .where(
                (e) =>
                    selectedCategory.value == SiteCategoryFilter.all ||
                    selectedCategory.value.toDTOs().contains(e.category),
              )
              .toList();

          return HookBuilder(
            builder: (context) {
              usePostFrameEffect(() {
                if (!context.mounted) {
                  return;
                }

                if (selectedSite.value == null && state.sites.isNotEmpty) {
                  final mainEventSite = state.sites.firstWhereOrNull(
                    (e) => e.category == SiteCategoryDTO.event,
                  );
                  if (mainEventSite != null) {
                    selectedSite.value = mainEventSite;
                  }
                }
              });
              return Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  DynamicMap(
                    visibleSites: visibleSites,
                    initialSite: state.sites.firstWhereOrNull(
                      (e) => e.category == SiteCategoryDTO.event,
                    ),
                    selectedSite: selectedSite.value,
                    onMapCreated: (controller) {
                      mapController.value = controller;
                    },
                    onMarkerTap: (site) {
                      selectedSite.value = site;
                    },
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: CategoryFilters(
                      selectedCategory: selectedCategory.value,
                      onCategorySelected: (category) {
                        selectedCategory.value = category;
                        final site = state.sites.firstWhereOrNull(
                          (e) => category == SiteCategoryFilter.all
                              ? e.category == SiteCategoryDTO.event
                              : category.toDTOs().contains(e.category),
                        );
                        selectedSite.value = site;
                        if (site != null) {
                          _centerMapOnSite(context, mapController.value, site);
                        }
                      },
                    ),
                  ),
                  SizedBox.expand(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding:
                              AppSpacings.s16.horizontal +
                              (selectedSite.value == null
                                  ? AppSpacings.s16.vertical
                                  : AppSpacings.zero.vertical),
                          child: AppButton.icon(
                            analyticsId: AnalyticsIds.centerMapOnUserLocation,
                            type: AppButtonType.secondary,
                            onTap: () => _centerMapOnUserLocation(
                              context,
                              mapController.value,
                            ),
                            icon: AppStandardIcons.target03,
                            semanticsLabel:
                                s.map_centerOnUserLocation_semanticsLabel,
                          ),
                        ),
                        if (selectedSite.value case final site?)
                          Container(
                            padding:
                                AppSpacings.s16.horizontal +
                                AppSpacings.s32.vertical,
                            height: MapLocationCardSize.large.height + 32,
                            child: MapLocationCard(
                              site: site,
                              onCloseTap: () => selectedSite.value = null,
                            ),
                          ),
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

  Future<void> _centerMapOnSite(
    BuildContext context,
    GoogleMapController? mapController,
    SiteDTO site,
  ) async {
    return mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(site.latitude, site.longitude), zoom: 13),
      ),
    );
  }

  Future<void> _centerMapOnUserLocation(
    BuildContext context,
    GoogleMapController? mapController,
  ) async {
    final s = l10n(context);
    final locationService = context.read<LocationService>();
    var userLocation = await locationService.getLocation();
    if (userLocation is NoGeoCoordinate) {
      final status = await locationService.requestLocationPermission();
      if (status == PermissionStatus.granted) {
        userLocation = await locationService.getLocation();
      }
    }
    if (userLocation is NoGeoCoordinate && context.mounted) {
      await context.pushSnackbar(
        AppSnackbar(
          type: AppSnackbarType.info,
          text: s.map_locationServiceSnackBar_caption,
          action: AppPlatform.platform.isAndroid
              ? AppSnackbarAction(
                  caption: s.map_locationServiceSnackBar_action,
                  onTap: locationService.openLocationSettings,
                )
              : null,
          padding: context.snackbarPadding,
        ),
      );
      return;
    }

    await mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(userLocation.latitude, userLocation.longitude),
          zoom: 13,
        ),
      ),
    );
  }
}
