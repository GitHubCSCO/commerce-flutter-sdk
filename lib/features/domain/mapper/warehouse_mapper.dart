import 'package:commerce_flutter_app/features/domain/entity/warehouse_entity.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class WarehouseEntityMapper {
  WarehouseEntity toEntity(Warehouse model) => WarehouseEntity(
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
            ?.map((warehouse) => WarehouseEntityMapper().toEntity(warehouse))
            .toList(),
        latitude: model.latitude,
        longitude: model.longitude,
        hours: model.hours,
        distance: model.distance,
        allowPickup: model.allowPickup,
        pickupShipViaId: model.pickupShipViaId,
      );
}
