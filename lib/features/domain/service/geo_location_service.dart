import 'package:commerce_flutter_app/features/domain/service/interfaces/geo_location_service_interface.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class GeoLocationService implements IGeoLocationService {
  Location location = Location();

  @override
  Future<LocationData?> getCurrentLocation() async {
    try {
      bool _serviceEnabled;
      PermissionStatus _permissionGranted;

      _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          return null;
        }
      }

      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          return null;
        }
      }

      var curlocation = await location.getLocation();
      return curlocation;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<LocationData?> getLastKnownLocation() async {
    try {
      return await location.getLocation();
    } catch (e) {
      return null;
    }
  }

  @override
  double getDistanceBetweenPoints(LatLng fromSource, LatLng toDestination) {
    final Distance distance = Distance();
    return distance.as(
      LengthUnit.Meter,
      fromSource,
      toDestination,
    );
  }
}
