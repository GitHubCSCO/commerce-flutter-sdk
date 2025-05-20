import 'package:commerce_flutter_sdk/src/features/domain/entity/warehouse_entity.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class WarehouseEntityMapper {
  static WarehouseEntity toEntity(Warehouse model) => WarehouseEntity(
        messageType: model.messageType,
        message: model.message,
        requiresRealTimeInventory: model.requiresRealTimeInventory,
        id: model.id,
        name: model.name,
        address1: model.address1,
        address2: model.address2,
        city: model.city,
        contactName: model.contactName,
        countryId: model.countryId,
        deactivateOn: model.deactivateOn,
        description: model.description,
        phone: model.phone,
        postalCode: model.postalCode,
        shipSite: model.shipSite,
        state: model.state,
        isDefault: model.isDefault,
        alternateWarehouses: model.alternateWarehouses
            ?.map((warehouse) => WarehouseEntityMapper.toEntity(warehouse))
            .toList(),
        latitude: model.latitude,
        longitude: model.longitude,
        hours: model.hours,
        distance: model.distance,
        allowPickup: model.allowPickup,
        pickupShipViaId: model.pickupShipViaId,
      );

  static Warehouse toModel(WarehouseEntity entity) => Warehouse(
        // messageType: entity.messageType,
        // message: entity.message,
        // requiresRealTimeInventory: entity.requiresRealTimeInventory,
        id: entity.id,
        name: entity.name,
        address1: entity.address1,
        address2: entity.address2,
        city: entity.city,
        contactName: entity.contactName,
        countryId: entity.countryId,
        deactivateOn: entity.deactivateOn,
        description: entity.description,
        phone: entity.phone,
        postalCode: entity.postalCode,
        shipSite: entity.shipSite,
        state: entity.state,
        isDefault: entity.isDefault,
        alternateWarehouses: entity.alternateWarehouses
            ?.map((warehouse) => WarehouseEntityMapper.toModel(warehouse))
            .toList(),
        latitude: entity.latitude,
        longitude: entity.longitude,
        hours: entity.hours,
        distance: entity.distance,
        allowPickup: entity.allowPickup,
        pickupShipViaId: entity.pickupShipViaId,
      );
}
