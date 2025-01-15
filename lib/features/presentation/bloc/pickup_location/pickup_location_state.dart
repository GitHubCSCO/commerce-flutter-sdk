import 'package:commerce_flutter_app/features/domain/entity/warehouse_entity.dart';
import 'package:equatable/equatable.dart';

abstract class PickUpLocationState extends Equatable {}

class PickUpLocationInitialState extends PickUpLocationState {
  @override
  List<Object?> get props => [];
}

class PickUpLocationLoadingState extends PickUpLocationState {
  @override
  List<Object?> get props => [];
}

class PickUpLocationLoadedState extends PickUpLocationState {
  List<WarehouseEntity> wareHouselist;
  WarehouseEntity? selectedWarehouse;
  PickUpLocationLoadedState({
    required this.wareHouselist,
    this.selectedWarehouse,
  });

  @override
  List<Object?> get props => [wareHouselist, selectedWarehouse];
}

class PickUpLocationFailureState extends PickUpLocationState {
  @override
  List<Object?> get props => [];
}

class PickUpSeachPlaceLocationUpdatedState extends PickUpLocationState {
  @override
  List<Object?> get props => [];
}
