import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class GMapState {}

class GMapInitial extends GMapState {}

class GMapMarkesUpdated extends GMapState {
  final Set<Marker> markers;
  GMapMarkesUpdated({required this.markers});
}
