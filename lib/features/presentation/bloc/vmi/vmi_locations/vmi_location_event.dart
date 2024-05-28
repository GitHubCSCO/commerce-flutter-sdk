import 'package:commerce_flutter_app/core/models/gogole_place.dart';
import 'package:commerce_flutter_app/core/models/lat_long.dart';

abstract class VMILocationEvent {}

class LoadVMILocationsEvent extends VMILocationEvent {}

class LocationSelectEvent extends VMILocationEvent {
  final LatLong selectedLocation;
  LocationSelectEvent({required this.selectedLocation});
}

class UpdateSearchPlaceEvent extends VMILocationEvent {
  final GooglePlace? seachPlace;
  UpdateSearchPlaceEvent({required this.seachPlace});
}
