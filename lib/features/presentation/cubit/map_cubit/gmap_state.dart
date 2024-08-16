import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class GMapState extends Equatable {}

class GMapInitial extends GMapState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class GMapMarkersUpdated extends GMapState {
  final Set<Marker> markers;
  final Marker focusMarker;
  GMapMarkersUpdated({required this.focusMarker, required this.markers});

  @override
  List<Object?> get props => [focusMarker, markers];
}

class GMapNoMarkerFound extends GMapState {
  @override
  List<Object?> get props => [];
}
