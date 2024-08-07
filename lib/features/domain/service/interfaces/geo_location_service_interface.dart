import 'package:location/location.dart';
import 'package:latlong2/latlong.dart';

abstract class IGeoLocationService {
  Future<LocationData?> getCurrentLocation();
  Future<LocationData?> getLastKnownLocation();
  double getDistanceBetweenPoints(LatLng fromSource, LatLng toDestination);
}
