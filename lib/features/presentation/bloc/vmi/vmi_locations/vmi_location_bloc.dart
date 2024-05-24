import 'dart:io';

import 'package:commerce_flutter_app/core/models/lat_long.dart';
import 'package:commerce_flutter_app/features/domain/entity/current_location_data_entity.dart';
import 'package:commerce_flutter_app/features/domain/usecases/vmi_usecase/vmi_location_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/vmi/vmi_locations/vmi_location_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/vmi/vmi_locations/vmi_location_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class VMILocationBloc extends Bloc<VMILocationEvent, VMILocationState> {
  final VMILocationUseCase _vmiLocationUseCase;

  VMILocationBloc({required VMILocationUseCase vmiLocationUseCase})
      : _vmiLocationUseCase = vmiLocationUseCase,
        super(VMILocationInitialState()) {
    on<LoadVMILocationsEvent>(_onloadVMILocations);
  }

  Future<void> _onloadVMILocations(
      LoadVMILocationsEvent event, Emitter<VMILocationState> emit) async {
    emit(VMILocationLoadingState());

    var response = await _vmiLocationUseCase.getVMILocations();
    switch (response) {
      case Success(value: final data):
        {
          List<CurrentLocationDataEntity> currentLocationDataEntityList = [];
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
            emit(VMILocationLoadedState(
                currentLocationDataEntityList: currentLocationDataEntityList));
          }
        }
      case Failure():
        break;
    }
  }
}
