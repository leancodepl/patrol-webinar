import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fts/common/hooks/use_map_markers.dart';
import 'package:fts/common/services/location_service.dart';
import 'package:fts/data/contracts/contracts.dart';
import 'package:fts/widgets/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:leancode_hooks/leancode_hooks.dart';

class DynamicMap extends HookWidget {
  const DynamicMap({
    super.key,
    required this.visibleSites,
    required this.initialSite,
    required this.onMarkerTap,
    required this.onMapCreated,
    this.selectedSite,
  });

  final List<SiteDTO> visibleSites;
  final SiteDTO? initialSite;
  final ArgumentCallback<SiteDTO> onMarkerTap;
  final ArgumentCallback<GoogleMapController> onMapCreated;
  final SiteDTO? selectedSite;

  @override
  Widget build(BuildContext context) {
    final mapLoading = useState(true);
    final locationService = context.read<LocationService>();
    useFuture(useMemoized(locationService.checkLocationServiceEnabled));
    useFuture(useMemoized(locationService.requestLocationPermission));

    useOnAppLifecycleStateChange((previous, current) {
      if (current == AppLifecycleState.resumed) {
        locationService.checkLocationServiceEnabled();
      }
    });

    final defaultMarkers = useDefaultMarkers();
    final selectedMarkers = useSelectedMarkers();

    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: CameraPosition(
            zoom: 13,
            target: initialSite != null
                ? LatLng(initialSite!.latitude, initialSite!.longitude)
                : const LatLng(52.1801, 21.0198),
          ),
          onMapCreated: (controller) {
            onMapCreated(controller);
            if (context.mounted) {
              mapLoading.value = false;
            }
          },
          markers: {
            for (final site in visibleSites)
              Marker(
                markerId: MarkerId(site.id),
                position: LatLng(site.latitude, site.longitude),
                zIndexInt: selectedSite?.id == site.id ? 1000 : 0,
                onTap: () => onMarkerTap(site),
                icon:
                    (selectedSite?.id == site.id
                        ? selectedMarkers[site.category]
                        : defaultMarkers[site.category]) ??
                    BitmapDescriptor.defaultMarker,
              ),
          },
          zoomControlsEnabled: false,
          tiltGesturesEnabled: false,
          compassEnabled: false,
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          mapToolbarEnabled: false,
        ),
        // TODO(Dawid): Remove this workaround when Google Maps
        // addresses the issue with black stuttering before map is loaded:
        // https://github.com/flutter/flutter/issues/39797
        // https://github.com/flutter/flutter/issues/26771
        if (mapLoading.value)
          SizedBox.expand(
            child: ColoredBox(color: context.colors.backgroundDefaultPrimary),
          ),
      ],
    );
  }
}
