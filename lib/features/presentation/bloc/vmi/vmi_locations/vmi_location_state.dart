// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:commerce_flutter_app/features/domain/entity/current_location_data_entity.dart';

abstract class VMILocationState {}

class VMILocationInitialState extends VMILocationState {}

class VMILocationLoadingState extends VMILocationState {}

class VMILocationLoadedState extends VMILocationState {
  List<CurrentLocationDataEntity> currentLocationDataEntityList;
  VMILocationLoadedState({
    required this.currentLocationDataEntityList,
  });
}

class VMILocationFailureState extends VMILocationState {}
