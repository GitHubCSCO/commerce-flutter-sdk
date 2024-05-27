import 'package:commerce_flutter_app/features/domain/entity/current_location_data_entity.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/map_cubit/gmap_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GMapCubit extends Cubit<GMapState> {
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

    emit(GMapMarkesUpdated(markers: markers));
  }
}
