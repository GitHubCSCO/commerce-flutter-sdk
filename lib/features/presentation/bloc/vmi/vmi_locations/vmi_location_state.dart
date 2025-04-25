// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:commerce_flutter_sdk/features/domain/entity/current_location_data_entity.dart';
import 'package:commerce_flutter_sdk/features/domain/enums/vmi_location_list_status.dart';

abstract class VMILocationState extends Equatable {}

class VMILocationInitialState extends VMILocationState {
  @override
  List<Object?> get props => [];
}

class VMILocationLoadingState extends VMILocationState {
  @override
  List<Object?> get props => [];
}

class VMILocationLoadedState extends VMILocationState {
  List<CurrentLocationDataEntity> currentLocationDataEntityList;
  CurrentLocationDataEntity? selectedLocation;
  VmiLocationListStatus status;
  VMILocationLoadedState(
      {required this.currentLocationDataEntityList,
      this.selectedLocation,
      required this.status});

  @override
  List<Object?> get props =>
      [currentLocationDataEntityList, selectedLocation, status];

  VMILocationLoadedState copyWith({
    List<CurrentLocationDataEntity>? currentLocationDataEntityList,
    CurrentLocationDataEntity? selectedLocation,
    VmiLocationListStatus? status,
  }) {
    return VMILocationLoadedState(
      currentLocationDataEntityList:
          currentLocationDataEntityList ?? this.currentLocationDataEntityList,
      selectedLocation: selectedLocation ?? this.selectedLocation,
      status: status ?? this.status,
    );
  }
}

class VMILocationFailureState extends VMILocationState {
  @override
  List<Object?> get props => [];
}

class VMISeachPlaceLocationUpdatedState extends VMILocationState {
  @override
  List<Object?> get props => [];
}
