import 'package:commerce_flutter_sdk/src/core/models/gogole_place.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/warehouse_entity.dart';

abstract class PickUpLocationEvent {}

class LoadPickUpLocationsEvent extends PickUpLocationEvent {
  final WarehouseEntity? selectedPickupWarehouse;
  LoadPickUpLocationsEvent({this.selectedPickupWarehouse});
}

class PickUpLocationSelectEvent extends PickUpLocationEvent {
  final WarehouseEntity selectedWarehouse;
  PickUpLocationSelectEvent({required this.selectedWarehouse});
}

class LoadSearchedPickUpLocationsEvent extends PickUpLocationEvent {
  final GooglePlace? searchedLocation;
  LoadSearchedPickUpLocationsEvent({this.searchedLocation});
}
