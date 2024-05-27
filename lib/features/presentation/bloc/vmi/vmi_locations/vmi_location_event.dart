import 'package:commerce_flutter_app/core/models/lat_long.dart';

abstract class VMILocationEvent {}

class LoadVMILocationsEvent extends VMILocationEvent {}

class LocationSelectEvent extends VMILocationEvent {
  final LatLong selectedLocation;
  LocationSelectEvent({required this.selectedLocation});
}
