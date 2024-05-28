import 'package:commerce_flutter_app/core/models/gogole_place.dart';
import 'package:commerce_flutter_app/features/domain/entity/current_location_data_entity.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/map_cubit/gmap_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GMapCubit extends Cubit<GMapState> {
  late Set<Marker> markers;
  GMapCubit() : super(GMapInitial());

  Future<void> updateMarkersFromVMI(
      List<CurrentLocationDataEntity> currentLocationDataEntity) async {
    final Set<Marker> markers = {};
    for (var location in currentLocationDataEntity) {
      markers.add(Marker(
          position: LatLng(location.latLong?.latitude ?? 0.0,
              location.latLong?.longitude ?? 0.0),
          markerId: MarkerId(location.locationName ?? "")));
    }
    this.markers = markers;
    emit(GMapMarkesUpdated(markers: markers, focusMarker: markers.first));
  }

  Future<void> onSeachPlaceMarked(GooglePlace? searchedLocation) async {
    emit(GMapMarkesUpdated(
        markers: markers,
        focusMarker: Marker(
            markerId: MarkerId(searchedLocation?.formattedName ?? ""),
            position: LatLng(searchedLocation?.latitude ?? 0.0,
                searchedLocation?.longitude ?? 0.0))));
  }
}
