import 'package:commerce_flutter_app/features/domain/entity/inventory_warehouse_entity.dart';
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
}
