import 'dart:async';

import 'package:app_settings/app_settings.dart';
import 'package:fts/common/util/transformers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:logging/logging.dart';
import 'package:rxdart/rxdart.dart';

// LeanCode Office
const defaultLocationDTO = LatLng(52.1744599, 21.029375);

class NoGeoCoordinate extends LatLng {
  const NoGeoCoordinate() : super(0, 0);
}

class LocationService {
  LocationService({required this.location}) {
    // Start monitoring location updates when service is created
    _initializeLocationMonitoring();
  }

  static final _logger = Logger('LocationService');

  final _geoCoordinateSubject = BehaviorSubject<LatLng>();
  final _locationServiceEnabledSubject = PublishSubject<bool>();

  final Location location;

  // Cached location
  LatLng? _cachedLocation;
  StreamSubscription<LocationData>? _locationSubscription;

  Stream<LatLng> get locationStream => _geoCoordinateSubject
      .asyncMap(_handlePosition)
      .transform(errorToData(defaultLocationDTO));

  Stream<bool> get locationServiceEnabledStream =>
      _locationServiceEnabledSubject.stream;

  Future<void> _initializeLocationMonitoring() async {
    // Check if we already have permission
    if (await hasLocationPermissionsGranted()) {
      _startLocationUpdates();
    }
  }

  void _startLocationUpdates() {
    // Cancel any existing subscription
    _locationSubscription?.cancel();

    // Subscribe to location updates
    _locationSubscription = location.onLocationChanged.listen(
      (locationData) {
        if (locationData case LocationData(
          :final latitude?,
          :final longitude?,
        )) {
          final newLocation = LatLng(latitude, longitude);
          _cachedLocation = newLocation;
          _geoCoordinateSubject.add(newLocation);
        }
      },
      onError: (Object err, StackTrace st) {
        _logger.warning('Error in location stream', err, st);
      },
    );

    // Also get an initial location to populate the cache
    _fetchInitialLocation();
  }

  Future<void> _fetchInitialLocation() async {
    try {
      final locationData = await location.getLocation();
      if (locationData case LocationData(:final latitude?, :final longitude?)) {
        final newLocation = LatLng(latitude, longitude);
        _cachedLocation = newLocation;
        _geoCoordinateSubject.add(newLocation);
      }
    } catch (err, st) {
      _logger.info("Couldn't fetch initial location", err, st);
    }
  }

  Future<PermissionStatus> requestLocationPermission() async {
    if (!await checkLocationServiceEnabled()) {
      return PermissionStatus.deniedForever;
    }
    final initialPermissionStatus = await checkPermissionStatus();

    switch (initialPermissionStatus) {
      case PermissionStatus.granted:
      case PermissionStatus.grantedLimited:
        await location.changeSettings(accuracy: LocationAccuracy.balanced);
        _startLocationUpdates();
        return initialPermissionStatus;
      case PermissionStatus.denied:
        final status = await location.requestPermission();
        if (status == PermissionStatus.granted) {
          await location.changeSettings(accuracy: LocationAccuracy.balanced);
          _startLocationUpdates();
          await getLocation(status: PermissionStatus.granted);
          return PermissionStatus.granted;
        }
        return status;
      case PermissionStatus.deniedForever:
        return PermissionStatus.deniedForever;
    }
  }

  Future<PermissionStatus> checkPermissionStatus() => location.hasPermission();

  Future<bool> checkLocationServiceEnabled() async {
    final enabled = await location.serviceEnabled();
    _locationServiceEnabledSubject.add(enabled);
    return enabled;
  }

  Future<bool> hasLocationPermissionsGranted() async =>
      await location.hasPermission() == PermissionStatus.granted;

  Future<LatLng> getLocation({PermissionStatus? status}) async {
    LatLng geoCoordinate = const NoGeoCoordinate();
    try {
      if (status == PermissionStatus.granted ||
          await hasLocationPermissionsGranted()) {
        // Return cached location if available
        if (_cachedLocation case final cachedLocation?) {
          geoCoordinate = cachedLocation;
        } else {
          // If no cached location, get current location (only happens initially)
          geoCoordinate = await _getCurrentGeoCoordinate();
        }
      }
    } catch (err, st) {
      _logger.info("Couldn't determine user location", err, st);
    }

    _geoCoordinateSubject.add(geoCoordinate);
    return geoCoordinate;
  }

  Future<LatLng> _getCurrentGeoCoordinate() async {
    final coordinate = await location.getLocation();
    if (coordinate case LocationData(:final latitude?, :final longitude?)) {
      return LatLng(latitude, longitude);
    } else {
      return const NoGeoCoordinate();
    }
  }

  Future<LatLng> _handlePosition(LatLng geoCoordinate) async {
    if (geoCoordinate is NoGeoCoordinate) {
      return defaultLocationDTO;
    }

    return geoCoordinate;
  }

  Future<void> openLocationSettings() =>
      AppSettings.openAppSettings(type: AppSettingsType.location);

  Future<bool> requestLocationService() => location.requestService();

  void dispose() {
    _locationSubscription?.cancel();
    _geoCoordinateSubject.close();
    _locationServiceEnabledSubject.close();
  }
}
