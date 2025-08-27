import 'package:commerce_flutter_sdk/src/features/domain/entity/warehouse_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/warehouse_mapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

void main() {
  group('WarehouseEntityMapper', () {
    test('should correctly map Warehouse to WarehouseEntity', () {
      // Arrange
      final model = Warehouse(
        id: "WH001",
        name: "Main Warehouse",
        address1: "123 Main Street",
        address2: "Suite 100",
        city: "New York",
        contactName: "John Smith",
        countryId: "US",
        deactivateOn: DateTime(2025, 12, 31),
        description: "Primary distribution center",
        phone: "+1-555-0123",
        postalCode: "10001",
        shipSite: "MAIN_SHIP",
        state: "NY",
        isDefault: true,
        alternateWarehouses: [
          Warehouse(
            id: "WH002",
            name: "Secondary Warehouse",
            city: "Boston",
            state: "MA",
          )
        ],
        latitude: 40.7128,
        longitude: -74.0060,
        hours: "Mon-Fri: 9AM-6PM",
        distance: 2.5,
        allowPickup: true,
        pickupShipViaId: "PICKUP_001",
      );

      // Act
      final result = WarehouseEntityMapper.toEntity(model);

      // Assert
      expect(result.messageType, model.messageType);
      expect(result.message, model.message);
      expect(result.requiresRealTimeInventory, model.requiresRealTimeInventory);
      expect(result.id, model.id);
      expect(result.name, model.name);
      expect(result.address1, model.address1);
      expect(result.address2, model.address2);
      expect(result.city, model.city);
      expect(result.contactName, model.contactName);
      expect(result.countryId, model.countryId);
      expect(result.deactivateOn, model.deactivateOn);
      expect(result.description, model.description);
      expect(result.phone, model.phone);
      expect(result.postalCode, model.postalCode);
      expect(result.shipSite, model.shipSite);
      expect(result.state, model.state);
      expect(result.isDefault, model.isDefault);
      expect(result.alternateWarehouses?.length, 1);
      expect(result.alternateWarehouses?.first.id, "WH002");
      expect(result.alternateWarehouses?.first.name, "Secondary Warehouse");
      expect(result.latitude, model.latitude);
      expect(result.longitude, model.longitude);
      expect(result.hours, model.hours);
      expect(result.distance, model.distance);
      expect(result.allowPickup, model.allowPickup);
      expect(result.pickupShipViaId, model.pickupShipViaId);
    });

    test('should correctly map WarehouseEntity to Warehouse', () {
      // Arrange
      final entity = WarehouseEntity(
        messageType: 2,
        message: "Out of Stock",
        requiresRealTimeInventory: false,
        id: "WH003",
        name: "West Coast Warehouse",
        address1: "456 Pacific Ave",
        address2: "Floor 2",
        city: "Los Angeles",
        contactName: "Jane Doe",
        countryId: "US",
        deactivateOn: DateTime(2026, 6, 30),
        description: "West coast distribution hub",
        phone: "+1-555-0456",
        postalCode: "90210",
        shipSite: "WEST_SHIP",
        state: "CA",
        isDefault: false,
        alternateWarehouses: const [
          WarehouseEntity(
            id: "WH004",
            name: "Backup Warehouse",
            city: "San Francisco",
            state: "CA",
          )
        ],
        latitude: 34.0522,
        longitude: -118.2437,
        hours: "24/7",
        distance: 15.3,
        allowPickup: false,
        pickupShipViaId: "PICKUP_002",
      );

      // Act
      final result = WarehouseEntityMapper.toModel(entity);

      // Assert
      // Note: Based on the mapper, messageType, message, and requiresRealTimeInventory are commented out in toModel
      expect(result.id, entity.id);
      expect(result.name, entity.name);
      expect(result.address1, entity.address1);
      expect(result.address2, entity.address2);
      expect(result.city, entity.city);
      expect(result.contactName, entity.contactName);
      expect(result.countryId, entity.countryId);
      expect(result.deactivateOn, entity.deactivateOn);
      expect(result.description, entity.description);
      expect(result.phone, entity.phone);
      expect(result.postalCode, entity.postalCode);
      expect(result.shipSite, entity.shipSite);
      expect(result.state, entity.state);
      expect(result.isDefault, entity.isDefault);
      expect(result.alternateWarehouses?.length, 1);
      expect(result.alternateWarehouses?.first.id, "WH004");
      expect(result.alternateWarehouses?.first.name, "Backup Warehouse");
      expect(result.latitude, entity.latitude);
      expect(result.longitude, entity.longitude);
      expect(result.hours, entity.hours);
      expect(result.distance, entity.distance);
      expect(result.allowPickup, entity.allowPickup);
      expect(result.pickupShipViaId, entity.pickupShipViaId);
    });

    test('should handle null values correctly when mapping to WarehouseEntity',
        () {
      // Arrange
      final model = Warehouse(
        id: null,
        name: null,
        address1: null,
        address2: null,
        city: null,
        contactName: null,
        countryId: null,
        deactivateOn: null,
        description: null,
        phone: null,
        postalCode: null,
        shipSite: null,
        state: null,
        isDefault: null,
        alternateWarehouses: null,
        latitude: null,
        longitude: null,
        hours: null,
        distance: null,
        allowPickup: null,
        pickupShipViaId: null,
      );

      // Act
      final result = WarehouseEntityMapper.toEntity(model);

      // Assert
      expect(result.messageType, isNull);
      expect(result.message, isNull);
      expect(result.requiresRealTimeInventory, isNull);
      expect(result.id, isNull);
      expect(result.name, isNull);
      expect(result.address1, isNull);
      expect(result.address2, isNull);
      expect(result.city, isNull);
      expect(result.contactName, isNull);
      expect(result.countryId, isNull);
      expect(result.deactivateOn, isNull);
      expect(result.description, isNull);
      expect(result.phone, isNull);
      expect(result.postalCode, isNull);
      expect(result.shipSite, isNull);
      expect(result.state, isNull);
      expect(result.isDefault, isNull);
      expect(result.alternateWarehouses, isNull);
      expect(result.latitude, isNull);
      expect(result.longitude, isNull);
      expect(result.hours, isNull);
      expect(result.distance, isNull);
      expect(result.allowPickup, isNull);
      expect(result.pickupShipViaId, isNull);
    });

    test('should handle null values correctly when mapping to Warehouse', () {
      // Arrange
      const entity = WarehouseEntity(
        messageType: null,
        message: null,
        requiresRealTimeInventory: null,
        id: null,
        name: null,
        address1: null,
        address2: null,
        city: null,
        contactName: null,
        countryId: null,
        deactivateOn: null,
        description: null,
        phone: null,
        postalCode: null,
        shipSite: null,
        state: null,
        isDefault: null,
        alternateWarehouses: null,
        latitude: null,
        longitude: null,
        hours: null,
        distance: null,
        allowPickup: null,
        pickupShipViaId: null,
      );

      // Act
      final result = WarehouseEntityMapper.toModel(entity);

      // Assert
      expect(result.id, isNull);
      expect(result.name, isNull);
      expect(result.address1, isNull);
      expect(result.address2, isNull);
      expect(result.city, isNull);
      expect(result.contactName, isNull);
      expect(result.countryId, isNull);
      expect(result.deactivateOn, isNull);
      expect(result.description, isNull);
      expect(result.phone, isNull);
      expect(result.postalCode, isNull);
      expect(result.shipSite, isNull);
      expect(result.state, isNull);
      expect(result.isDefault, isNull);
      expect(result.alternateWarehouses, isNull);
      expect(result.latitude, isNull);
      expect(result.longitude, isNull);
      expect(result.hours, isNull);
      expect(result.distance, isNull);
      expect(result.allowPickup, isNull);
      expect(result.pickupShipViaId, isNull);
    });

    test('should handle empty alternateWarehouses list', () {
      // Arrange
      final model = Warehouse(
        id: "WH005",
        name: "Solo Warehouse",
        alternateWarehouses: [],
      );

      // Act
      final result = WarehouseEntityMapper.toEntity(model);

      // Assert
      expect(result.id, "WH005");
      expect(result.name, "Solo Warehouse");
      expect(result.alternateWarehouses, isEmpty);
    });

    test('should maintain data integrity in roundtrip conversion', () {
      // Arrange
      final originalModel = Warehouse(
        id: "WH999",
        name: "Test Warehouse",
        address1: "789 Test St",
        city: "Test City",
        state: "TX",
        latitude: 32.7767,
        longitude: -96.7970,
        allowPickup: true,
        isDefault: false,
      );

      // Act
      final entity = WarehouseEntityMapper.toEntity(originalModel);
      final resultModel = WarehouseEntityMapper.toModel(entity);

      // Assert - Only test properties that are mapped in both directions
      expect(resultModel.id, originalModel.id);
      expect(resultModel.name, originalModel.name);
      expect(resultModel.address1, originalModel.address1);
      expect(resultModel.city, originalModel.city);
      expect(resultModel.state, originalModel.state);
      expect(resultModel.latitude, originalModel.latitude);
      expect(resultModel.longitude, originalModel.longitude);
      expect(resultModel.allowPickup, originalModel.allowPickup);
      expect(resultModel.isDefault, originalModel.isDefault);
    });
  });
}
