import 'package:commerce_flutter_sdk/features/domain/entity/current_location_data_entity.dart';
import 'package:commerce_flutter_sdk/features/domain/entity/warehouse_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'location_search_handler_state.dart';

class LocationSearchHandlerCubit extends Cubit<LocationSearchHandlerState> {
  LocationSearchHandlerCubit()
      : super(
          const LocationSearchHandlerState(),
        );

  void setLocationData(CurrentLocationDataEntity locationData) {
    emit(LocationSearchHandlerState(
      locationData: locationData,
      warehouseData: state.warehouseData,
    ));
  }

  void setWarehouseData(WarehouseEntity warehouseData) {
    emit(LocationSearchHandlerState(
      warehouseData: warehouseData,
      locationData: state.locationData,
    ));
  }

  void clearLocationData() {
    emit(LocationSearchHandlerState(
      locationData: null,
      warehouseData: state.warehouseData,
    ));
  }

  void clearWarehouseData() {
    emit(LocationSearchHandlerState(
      warehouseData: null,
      locationData: state.locationData,
    ));
  }

  void clearAllData() {
    // ignore: prefer_const_constructors
    emit(LocationSearchHandlerState());
  }
}
