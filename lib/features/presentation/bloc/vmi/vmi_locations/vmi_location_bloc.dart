import 'package:commerce_flutter_app/core/models/gogole_place.dart';
import 'package:commerce_flutter_app/core/models/lat_long.dart';
import 'package:commerce_flutter_app/features/domain/entity/current_location_data_entity.dart';
import 'package:commerce_flutter_app/features/domain/usecases/vmi_usecase/vmi_location_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/vmi/vmi_locations/vmi_location_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/vmi/vmi_locations/vmi_location_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class VMILocationBloc extends Bloc<VMILocationEvent, VMILocationState> {
  final VMILocationUseCase _vmiLocationUseCase;
  LatLng? currentLocation;
  GooglePlace? seachPlace;
  List<CurrentLocationDataEntity> currentLocationDataEntityList = [];

  VMILocationBloc({required VMILocationUseCase vmiLocationUseCase})
      : _vmiLocationUseCase = vmiLocationUseCase,
        super(VMILocationInitialState()) {
    on<LoadVMILocationsEvent>(_onloadVMILocations);
    on<LocationSelectEvent>(_onLocationSelectEvent);
    on<UpdateSearchPlaceEvent>(_updateSeachPlace);
  }

  Future<void> _onloadVMILocations(
      LoadVMILocationsEvent event, Emitter<VMILocationState> emit) async {
    emit(VMILocationLoadingState());

    var response = await _vmiLocationUseCase.getVMILocations();
    // currentLocation = await _vmiLocationUseCase.getCurrentLocation();
    switch (response) {
      case Success(value: final data):
        {
          for (var vmiLocation in data?.vmiLocations ?? []) {
            LatLong? latLong;
            if (vmiLocation != null) {
              latLong = await _vmiLocationUseCase
                  .getPlaceFromAddresss(vmiLocation.customer);
            }

            var currentLocationDataEntity =
                CurrentLocationDataEntity.fromVmiLocation(vmiLocation);
            currentLocationDataEntity =
                currentLocationDataEntity.copyWith(latLong: latLong);

            currentLocationDataEntityList.add(currentLocationDataEntity);
          }

          if (seachPlace != null) {
            // currentLocationDataEntityList =
            //     currentLocationDataEntityList.where((entity) {
            //   return entity.latLong != null &&
            //       isCloseToLocation(
            //           entity.latLong!.latitude, entity.latLong!.longitude);
            // }).toList();
            emit(VMILocationLoadedState(
              currentLocationDataEntityList: currentLocationDataEntityList,
            ));
          } else {
            emit(VMILocationLoadedState(
                currentLocationDataEntityList: currentLocationDataEntityList,
                selectedLocation: currentLocationDataEntityList.first.latLong));
          }
        }
      case Failure():
        break;
    }
  }

  bool isCloseToLocation(double latitude, double longitude) {
    // if (!this.isUserLocationEnabled) {
    //   return false;
    // }

    var fromSource = LatLng(latitude, longitude);

    var currentLocation =
        LatLng(seachPlace?.latitude ?? 0.0, seachPlace?.longitude ?? 0.0);

    return _vmiLocationUseCase.isCloseToLocation(fromSource, currentLocation);
  }

  Future<void> _onLocationSelectEvent(
      LocationSelectEvent event, Emitter<VMILocationState> emit) async {
    seachPlace = null;
    var selectedItem = currentLocationDataEntityList.firstWhere(
      (location) => location.latLong == event.selectedLocation,
    );
    currentLocationDataEntityList
        .removeWhere((location) => location.latLong == event.selectedLocation);
    selectedItem = selectedItem.copyWith(latLong: event.selectedLocation);
    currentLocationDataEntityList.insert(0, selectedItem);
    emit(VMILocationLoadedState(
        currentLocationDataEntityList: currentLocationDataEntityList,
        selectedLocation: event.selectedLocation));
  }

  Future<void> _updateSeachPlace(
      UpdateSearchPlaceEvent event, Emitter<VMILocationState> emit) async {
    seachPlace = event.seachPlace;
  }
}
