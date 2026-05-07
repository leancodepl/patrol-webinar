// import 'package:fts/common/services/location_service.dart';
// import 'package:fts/data/contracts/contracts.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:location/location.dart';
// import 'package:mocktail/mocktail.dart';

// class MockLocation extends Mock implements Location {}

// void main() {
//   TestWidgetsFlutterBinding.ensureInitialized();
//   late MockLocation location;

//   setUp(() {
//     location = MockLocation();
//   });

//   LocationService create() => LocationService(location: location);

//   group('LocationService', () {
//     test('ensure LocationService creates', () {
//       final service = create();

//       expect(service, isNotNull);
//     });

//     group('checkPermissionStatus', () {
//       test(
//         'when requestLocationPermission called and permissions are granted, ensure getLocation is called',
//         () async {
//           when(
//             () => location.hasPermission(),
//           ).thenAnswer((_) async => PermissionStatus.denied);
//           when(
//             () => location.requestPermission(),
//           ).thenAnswer((_) async => PermissionStatus.granted);
//           when(() => location.serviceEnabled()).thenAnswer((_) async => true);

//           final service = create();

//           await service.requestLocationPermission();

//           await pumpEventQueue();

//           verify(location.hasPermission);
//           verify(location.requestPermission);
//           verify(location.getLocation);
//         },
//       );

//       test(
//         'when requestLocationPermission called and permissions are PermissionStatus.denied, ensure getLocation is never called',
//         () async {
//           when(
//             () => location.hasPermission(),
//           ).thenAnswer((_) async => PermissionStatus.denied);
//           when(
//             () => location.requestPermission(),
//           ).thenAnswer((_) async => PermissionStatus.deniedForever);
//           when(() => location.serviceEnabled()).thenAnswer((_) async => true);

//           final service = create();

//           await service.requestLocationPermission();

//           verify(location.hasPermission);
//           verify(location.requestPermission);
//           verifyNever(location.getLocation);
//         },
//       );

//       test(
//         'when requestLocationPermission called and location services are disabled, no other calls are made',
//         () async {
//           when(
//             () => location.hasPermission(),
//           ).thenAnswer((_) async => PermissionStatus.denied);
//           when(
//             () => location.requestPermission(),
//           ).thenAnswer((_) async => PermissionStatus.granted);
//           when(() => location.serviceEnabled()).thenAnswer((_) async => false);

//           final service = create();

//           await service.requestLocationPermission();

//           await pumpEventQueue();

//           verifyNever(location.hasPermission);
//           verifyNever(location.requestPermission);
//           verifyNever(location.getLocation);
//         },
//       );
//     });

//     group('checkPermissionStatus', () {
//       test(
//         'when checkPermissionStatus called, return permission status',
//         () async {
//           when(
//             () => location.hasPermission(),
//           ).thenAnswer((_) async => PermissionStatus.granted);

//           final service = create();

//           final result = await service.checkPermissionStatus();

//           expect(result, PermissionStatus.granted);
//         },
//       );
//     });

//     group('requestLocationService', () {
//       test(
//         'when requestLocationService called, return request location service',
//         () async {
//           when(() => location.requestService()).thenAnswer((_) async => true);

//           final service = create();

//           await service.requestLocationService();

//           verify(() => location.requestService());
//         },
//       );
//     });

//     group('checkLocationServiceEnabled', () {
//       test(
//         'when checkLocationServiceEnabled called, return location service status, add value to stream',
//         () async {
//           when(() => location.serviceEnabled()).thenAnswer((_) async => true);

//           final service = create();

//           final subscribe = service.locationServiceEnabledStream.first;

//           final result = await service.checkLocationServiceEnabled();
//           await pumpEventQueue();
//           expect(result, isTrue);

//           final streamValue = await subscribe;
//           await pumpEventQueue();

//           expect(streamValue, isTrue);
//         },
//       );
//     });

//     group('hasLocationPermissionsGranted', () {
//       test(
//         'when hasLocationPermissionsGranted called and permissions are PermissionStatus.granted, return true',
//         () async {
//           when(
//             () => location.hasPermission(),
//           ).thenAnswer((_) async => PermissionStatus.granted);

//           final service = create();

//           final result = await service.hasLocationPermissionsGranted();

//           expect(result, isTrue);
//         },
//       );

//       test(
//         'when hasLocationPermissionsGranted called and permissions are PermissionStatus.grantedLimited, return false',
//         () async {
//           when(
//             () => location.hasPermission(),
//           ).thenAnswer((_) async => PermissionStatus.grantedLimited);

//           final service = create();

//           final result = await service.hasLocationPermissionsGranted();

//           expect(result, isFalse);
//         },
//       );

//       test(
//         'when hasLocationPermissionsGranted called and permissions are PermissionStatus.denied, return false',
//         () async {
//           when(
//             () => location.hasPermission(),
//           ).thenAnswer((_) async => PermissionStatus.denied);

//           final service = create();

//           final result = await service.hasLocationPermissionsGranted();

//           expect(result, isFalse);
//         },
//       );

//       test(
//         'when hasLocationPermissionsGranted called and permissions are PermissionStatus.deniedForever, return false',
//         () async {
//           when(
//             () => location.hasPermission(),
//           ).thenAnswer((_) async => PermissionStatus.deniedForever);

//           final service = create();

//           final result = await service.hasLocationPermissionsGranted();

//           expect(result, isFalse);
//         },
//       );
//     });

//     group('getLocation', () {
//       test('when getLocation called, locationStream emits data', () async {
//         when(
//           () => location.hasPermission(),
//         ).thenAnswer((_) async => PermissionStatus.granted);

//         when(() => location.getLocation()).thenAnswer(
//           (_) async => LocationData.fromMap({
//             'latitude': 52.4007215,
//             'longitude': 16.7368427,
//           }),
//         );

//         final service = create();

//         await service.getLocation();

//         final userLocation = await service.locationStream.first;

//         expect(
//           userLocation,
//           LocationDTO(latitude: 52.4007215, longitude: 16.7368427),
//         );
//       });

//       test(
//         'when getLocation called, but location data returned no location, return no coordinates',
//         () async {
//           when(
//             () => location.hasPermission(),
//           ).thenAnswer((_) async => PermissionStatus.granted);

//           when(
//             () => location.getLocation(),
//           ).thenAnswer((_) async => LocationData.fromMap({}));

//           final service = create();

//           final result = await service.getLocation();

//           expect(result, isA<NoGeoCoordinate>());
//           expect(result.latitude, 0.0);
//           expect(result.longitude, 0.0);

//           final streamValue = await service.locationStream.first;
//           await pumpEventQueue();

//           expect(streamValue.latitude, 52.1744599);
//           expect(streamValue.longitude, 21.029375);
//         },
//       );

//       test('when getLocation failed, return no coordinates', () async {
//         when(
//           () => location.hasPermission(),
//         ).thenAnswer((_) async => PermissionStatus.granted);

//         when(() => location.getLocation()).thenAnswer((_) => Future.error({}));

//         final service = create();

//         final result = await service.getLocation();

//         expect(result, isA<NoGeoCoordinate>());
//         expect(result.latitude, 0.0);
//         expect(result.longitude, 0.0);

//         final streamValue = await service.locationStream.first;
//         await pumpEventQueue();

//         expect(streamValue.latitude, 52.1744599);
//         expect(streamValue.longitude, 21.029375);
//       });

//       test(
//         'when getLocation throws exception, return no coordinates, stream returns default location',
//         () async {
//           when(
//             () => location.hasPermission(),
//           ).thenAnswer((_) async => PermissionStatus.granted);

//           when(
//             () => location.getLocation(),
//           ).thenThrow((_) async => Exception());

//           final service = create();

//           final result = await service.getLocation();
//           await pumpEventQueue();

//           expect(result, isA<NoGeoCoordinate>());
//           expect(result.latitude, 0.0);
//           expect(result.longitude, 0.0);

//           final streamValue = await service.locationStream.first;
//           await pumpEventQueue();

//           expect(streamValue.latitude, 52.1744599);
//           expect(streamValue.longitude, 21.029375);
//         },
//       );
//     });
//   });
// }
