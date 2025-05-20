import 'package:commerce_flutter_sdk/src/features/domain/entity/inventory_warehouse_entity.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class InventoryWarehouseEntityMapper {
  InventoryWarehouseEntity toEntity(InventoryWarehouse model) =>
      InventoryWarehouseEntity(
        messageType: model.messageType,
        message: model.message,
        requiresRealTimeInventory: model.requiresRealTimeInventory,
        name: model.name,
        description: model.description,
        qty: model.qty,
      );

  InventoryWarehouse toModel(InventoryWarehouseEntity entity) =>
      InventoryWarehouse(
        // messageType: entity.messageType,
        // message: entity.message,
        // requiresRealTimeInventory: entity.requiresRealTimeInventory,
        name: entity.name,
        description: entity.description,
        qty: entity.qty,
      );
}
