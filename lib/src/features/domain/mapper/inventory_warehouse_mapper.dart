import 'package:commerce_flutter_sdk/src/features/domain/entity/inventory_warehouse_entity.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class InventoryWarehouseEntityMapper {
  InventoryWarehouseEntity toEntity(InventoryWarehouse model) =>
      InventoryWarehouseEntity(
        messageType: model.messageType,
        message: model.message,
        requiresRealTimeInventory: model.requiresRealTimeInventory,
        id: model.id,
        name: model.name,
        description: model.description,
        qtyAvailable: model.qtyAvailable,
      );

  InventoryWarehouse toModel(InventoryWarehouseEntity entity) =>
      InventoryWarehouse(
        id: entity.id,
        name: entity.name,
        description: entity.description,
        qtyAvailable: entity.qtyAvailable,
      )
        ..messageType = entity.messageType
        ..message = entity.message
        ..requiresRealTimeInventory = entity.requiresRealTimeInventory;
}
