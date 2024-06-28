import 'package:collection/collection.dart';
import 'package:commerce_flutter_app/core/models/lat_long.dart';
import 'package:commerce_flutter_app/features/domain/entity/current_location_data_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/warehouse_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

abstract class PickUpLocationState extends Equatable {}

class PickUpLocationInitialState extends PickUpLocationState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class PickUpLocationLoadingState extends PickUpLocationState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
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
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class PickUpSeachPlaceLocationUpdatedState extends PickUpLocationState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
