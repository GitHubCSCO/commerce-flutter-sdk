import 'package:commerce_flutter_app/features/domain/entity/current_location_data_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/warehouse_entity.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

abstract class PickUpLocationEvent {}

class LoadPickUpLocationsEvent extends PickUpLocationEvent {}

class PickUpLocationSelectEvent extends PickUpLocationEvent {
  final WarehouseEntity selectedWarehouse;
  PickUpLocationSelectEvent({required this.selectedWarehouse});
}

class GooglePlace extends PickUpLocationEvent {
  final GooglePlace? seachPlace;
  GooglePlace({required this.seachPlace});
}
