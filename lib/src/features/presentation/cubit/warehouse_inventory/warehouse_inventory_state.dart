import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

abstract class WareHouseInventoryState {}

class WareHouseInventoryInitialState extends WareHouseInventoryState {}

class WareHouseInventoryLoadingState extends WareHouseInventoryState {}

class WareHouseInventoryLoadedState extends WareHouseInventoryState {
  List<InventoryWarehouse> warehouses;
  WareHouseInventoryLoadedState({required this.warehouses});
}

class WareHouseInventoryFailureState extends WareHouseInventoryState {}
