// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:commerce_flutter_sdk/features/domain/entity/current_location_data_entity.dart';

abstract class CurrentLocationState {}

class CurrentLocationInitialState extends CurrentLocationState {}

class CurrentLocationLoadingState extends CurrentLocationState {}

class CurrentLocationLoadedState extends CurrentLocationState {
  final CurrentLocationDataEntity currentLocationDataEntity;

  CurrentLocationLoadedState({
    required this.currentLocationDataEntity,
  });
}

class CurrentLocationFailureState extends CurrentLocationState {}
