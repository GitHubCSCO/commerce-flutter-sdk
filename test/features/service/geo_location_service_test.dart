import 'package:flutter_test/flutter_test.dart';
import 'package:location/location.dart';
import 'package:latlong2/latlong.dart';
import 'package:mocktail/mocktail.dart';

import 'package:commerce_flutter_sdk/src/features/domain/service/geo_location_service.dart';

class MockLocation extends Mock implements Location {}

void main() {
  late GeoLocationService geoService;
  late MockLocation mockLocation;

  setUp(() {
    mockLocation = MockLocation();
    geoService = GeoLocationService();
    geoService.location = mockLocation;

    // Register fallback values for LocationData and PermissionStatus
    registerFallbackValue(LocationData.fromMap({
      'latitude': 0.0,
      'longitude': 0.0,
    }));
    registerFallbackValue(PermissionStatus.denied);
  });

  group('GeoLocationService', () {
    test(
        'getCurrentLocation returns location when service and permission granted',
        () async {
      final mockLocationData = LocationData.fromMap({
        'latitude': 10.0,
        'longitude': 20.0,
      });

      when(() => mockLocation.serviceEnabled()).thenAnswer((_) async => true);
      when(() => mockLocation.hasPermission())
          .thenAnswer((_) async => PermissionStatus.granted);
      when(() => mockLocation.getLocation())
          .thenAnswer((_) async => mockLocationData);

      final result = await geoService.getCurrentLocation();

      expect(result, isNotNull);
      expect(result!.latitude, 10.0);
      expect(result.longitude, 20.0);
    });

    test('getCurrentLocation returns null when service is not enabled',
        () async {
      when(() => mockLocation.serviceEnabled()).thenAnswer((_) async => false);
      when(() => mockLocation.requestService()).thenAnswer((_) async => false);

      final result = await geoService.getCurrentLocation();

      expect(result, isNull);
    });

    test('getLastKnownLocation returns location data', () async {
      final mockLocationData = LocationData.fromMap({
        'latitude': 15.0,
        'longitude': 25.0,
      });

      when(() => mockLocation.getLocation())
          .thenAnswer((_) async => mockLocationData);

      final result = await geoService.getLastKnownLocation();

      expect(result, isNotNull);
      expect(result!.latitude, 15.0);
      expect(result.longitude, 25.0);
    });

    test('getDistanceBetweenPoints returns correct distance in meters', () {
      final from = LatLng(10.0, 20.0);
      final to = LatLng(11.0, 21.0);

      final distance = geoService.getDistanceBetweenPoints(from, to);

      // It should be a positive number roughly ~157 km
      expect(distance, greaterThan(150000));
      expect(distance, lessThan(160000));
    });
  });
}
