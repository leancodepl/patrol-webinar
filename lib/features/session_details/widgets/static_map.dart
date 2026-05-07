import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fts/common/hooks/use_map_markers.dart';
import 'package:fts/common/widgets/map_location_card.dart';
import 'package:fts/data/contracts/contracts.dart';
import 'package:fts/widgets/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:leancode_hooks/leancode_hooks.dart';

class StaticMap extends HookWidget {
  const StaticMap({super.key, required this.site});

  final SiteDTO site;

  @override
  Widget build(BuildContext context) {
    final mapLoading = useState(true);
    final mapController = useRef<GoogleMapController?>(null);
    final selectedMarkers = useSelectedMarkers();

    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: CameraPosition(
            zoom: 13,
            target: LatLng(site.latitude, site.longitude),
          ),
          onMapCreated: (controller) {
            if (context.mounted) {
              mapController.value = controller;
              mapLoading.value = false;
            }
          },
          markers: {
            Marker(
              markerId: MarkerId(site.id),
              position: LatLng(site.latitude, site.longitude),
              icon:
                  selectedMarkers[site.category] ??
                  BitmapDescriptor.defaultMarker,
            ),
          },
          zoomControlsEnabled: false,
          tiltGesturesEnabled: false,
          compassEnabled: false,
          myLocationButtonEnabled: false,
          mapToolbarEnabled: false,
          rotateGesturesEnabled: false,
        ),
        Positioned.fill(
          child: Padding(
            padding: AppSpacings.s8.all,
            child: Align(
              alignment: Alignment.bottomCenter,
              // Move camera to the initial site when the card is tapped
              child: GestureDetector(
                onTap: () => mapController.value?.animateCamera(
                  CameraUpdate.newLatLngZoom(
                    LatLng(site.latitude, site.longitude),
                    13,
                  ),
                ),
                child: MapLocationCard(
                  site: site,
                  size: MapLocationCardSize.small,
                ),
              ),
            ),
          ),
        ),
        // TODO(Dawid): Remove this workaround when Google Maps
        // addresses the issue with black stuttering before map is loaded:
        // https://github.com/flutter/flutter/issues/39797
        // https://github.com/flutter/flutter/issues/26771
        if (mapLoading.value)
          SizedBox.expand(
            child: ColoredBox(
              color: context.colors.backgroundDefaultPrimary,
              child: const Center(child: CircularProgressIndicator()),
            ),
          ),
      ],
    );
  }
}
