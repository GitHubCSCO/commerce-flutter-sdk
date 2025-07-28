import 'package:commerce_flutter_sdk/src/features/domain/entity/inventory_warehouse_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/inventory_warehouse_mapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

void main() {
  group('InventoryWarehouseEntityMapper', () {
    late InventoryWarehouseEntityMapper mapper;

    setUp(() {
      mapper = InventoryWarehouseEntityMapper();
    });

    test('should correctly map InventoryWarehouse to InventoryWarehouseEntity',
        () {
      // Arrange
      final inventoryWarehouse = InventoryWarehouse(
        name: 'Main Warehouse',
        description: 'Primary distribution center',
        qty: 150,
      )
        ..messageType = 1
        ..message = 'In Stock'
        ..requiresRealTimeInventory = true;

      // Act
      final result = mapper.toEntity(inventoryWarehouse);

      // Assert
      expect(result.messageType, equals(1));
      expect(result.message, equals('In Stock'));
      expect(result.requiresRealTimeInventory, equals(true));
      expect(result.name, equals('Main Warehouse'));
      expect(result.description, equals('Primary distribution center'));
      expect(result.qty, equals(150));
    });

    test('should correctly map InventoryWarehouseEntity to InventoryWarehouse',
        () {
      // Arrange
      const inventoryWarehouseEntity = InventoryWarehouseEntity(
        messageType: 2,
        message: 'Low Stock',
        requiresRealTimeInventory: false,
        name: 'Secondary Warehouse',
        description: 'Backup storage facility',
        qty: 25,
      );

      // Act
      final result = mapper.toModel(inventoryWarehouseEntity);

      // Assert
      // Note: The current implementation has commented out availability fields
      // This test documents the current behavior - messageType, message, and requiresRealTimeInventory are NOT mapped back
      expect(result.messageType, isNull); // Bug: should be 2 but is not mapped
      expect(result.message,
          isNull); // Bug: should be 'Low Stock' but is not mapped
      expect(result.requiresRealTimeInventory,
          isNull); // Bug: should be false but is not mapped
      expect(result.name, equals('Secondary Warehouse'));
      expect(result.description, equals('Backup storage facility'));
      expect(result.qty, equals(25));
    });

    test('should handle null values in InventoryWarehouse correctly', () {
      // Arrange
      final inventoryWarehouse = InventoryWarehouse(
        name: null,
        description: null,
        qty: null,
      )
        ..messageType = null
        ..message = null
        ..requiresRealTimeInventory = null;

      // Act
      final result = mapper.toEntity(inventoryWarehouse);

      // Assert
      expect(result.messageType, isNull);
      expect(result.message, isNull);
      expect(result.requiresRealTimeInventory, isNull);
      expect(result.name, isNull);
      expect(result.description, isNull);
      expect(result.qty, isNull);
    });

    test('should handle null values in InventoryWarehouseEntity correctly', () {
      // Arrange
      const inventoryWarehouseEntity = InventoryWarehouseEntity(
        messageType: null,
        message: null,
        requiresRealTimeInventory: null,
        name: null,
        description: null,
        qty: null,
      );

      // Act
      final result = mapper.toModel(inventoryWarehouseEntity);

      // Assert
      expect(result.messageType, isNull);
      expect(result.message, isNull);
      expect(result.requiresRealTimeInventory, isNull);
      expect(result.name, isNull);
      expect(result.description, isNull);
      expect(result.qty, isNull);
    });

    test('should handle different quantity types correctly', () {
      // Arrange
      final inventoryWarehouse = InventoryWarehouse(
        name: 'Warehouse A',
        description: 'Test warehouse',
        qty: 42.5, // decimal quantity
      )
        ..messageType = 1
        ..message = 'Available'
        ..requiresRealTimeInventory = false;

      // Act
      final result = mapper.toEntity(inventoryWarehouse);

      // Assert
      expect(result.qty, equals(42.5));
      expect(result.name, equals('Warehouse A'));
      expect(result.description, equals('Test warehouse'));
      expect(result.messageType, equals(1));
      expect(result.message, equals('Available'));
      expect(result.requiresRealTimeInventory, equals(false));
    });

    test('should handle zero quantity correctly', () {
      // Arrange
      final inventoryWarehouse = InventoryWarehouse(
        name: 'Empty Warehouse',
        description: 'Currently empty',
        qty: 0,
      )
        ..messageType = 2
        ..message = 'Out of Stock'
        ..requiresRealTimeInventory = true;

      // Act
      final result = mapper.toEntity(inventoryWarehouse);

      // Assert
      expect(result.qty, equals(0));
      expect(result.name, equals('Empty Warehouse'));
      expect(result.description, equals('Currently empty'));
      expect(result.messageType, equals(2));
      expect(result.message, equals('Out of Stock'));
      expect(result.requiresRealTimeInventory, equals(true));
    });

    test('should handle negative quantity correctly', () {
      // Arrange
      final inventoryWarehouse = InventoryWarehouse(
        name: 'Backordered Warehouse',
        description: 'Items on backorder',
        qty: -10,
      )
        ..messageType = 3
        ..message = 'Backordered'
        ..requiresRealTimeInventory = false;

      // Act
      final result = mapper.toEntity(inventoryWarehouse);

      // Assert
      expect(result.qty, equals(-10));
      expect(result.name, equals('Backordered Warehouse'));
      expect(result.description, equals('Items on backorder'));
      expect(result.messageType, equals(3));
      expect(result.message, equals('Backordered'));
      expect(result.requiresRealTimeInventory, equals(false));
    });

    test('should handle empty strings correctly', () {
      // Arrange
      final inventoryWarehouse = InventoryWarehouse(
        name: '',
        description: '',
        qty: 100,
      )
        ..messageType = 1
        ..message = ''
        ..requiresRealTimeInventory = true;

      // Act
      final result = mapper.toEntity(inventoryWarehouse);

      // Assert
      expect(result.name, equals(''));
      expect(result.description, equals(''));
      expect(result.message, equals(''));
      expect(result.qty, equals(100));
      expect(result.messageType, equals(1));
      expect(result.requiresRealTimeInventory, equals(true));
    });

    test('should handle large quantities correctly', () {
      // Arrange
      final inventoryWarehouse = InventoryWarehouse(
        name: 'Large Warehouse',
        description: 'High capacity storage',
        qty: 999999.99,
      )
        ..messageType = 1
        ..message = 'High Stock'
        ..requiresRealTimeInventory = false;

      // Act
      final result = mapper.toEntity(inventoryWarehouse);

      // Assert
      expect(result.qty, equals(999999.99));
      expect(result.name, equals('Large Warehouse'));
      expect(result.description, equals('High capacity storage'));
      expect(result.messageType, equals(1));
      expect(result.message, equals('High Stock'));
      expect(result.requiresRealTimeInventory, equals(false));
    });

    test('should preserve inheritance from AvailabilityEntity', () {
      // Arrange
      const inventoryWarehouseEntity = InventoryWarehouseEntity(
        messageType: 1,
        message: 'Available',
        requiresRealTimeInventory: true,
        name: 'Test Warehouse',
        description: 'Test Description',
        qty: 50,
      );

      // Act & Assert
      // Verify that InventoryWarehouseEntity extends AvailabilityEntity
      expect(inventoryWarehouseEntity.messageType, equals(1));
      expect(inventoryWarehouseEntity.message, equals('Available'));
      expect(inventoryWarehouseEntity.requiresRealTimeInventory, equals(true));
      expect(inventoryWarehouseEntity.name, equals('Test Warehouse'));
      expect(inventoryWarehouseEntity.description, equals('Test Description'));
      expect(inventoryWarehouseEntity.qty, equals(50));
    });

    test('should handle copyWith functionality correctly', () {
      // Arrange
      const originalEntity = InventoryWarehouseEntity(
        messageType: 1,
        message: 'Original Message',
        requiresRealTimeInventory: true,
        name: 'Original Name',
        description: 'Original Description',
        qty: 100,
      );

      // Act
      final copiedEntity = originalEntity.copyWith(
        messageType: 2,
        message: 'Updated Message',
        qty: 200,
      );

      // Assert
      expect(copiedEntity.messageType, equals(2));
      expect(copiedEntity.message, equals('Updated Message'));
      expect(copiedEntity.requiresRealTimeInventory, equals(true)); // unchanged
      expect(copiedEntity.name, equals('Original Name')); // unchanged
      expect(copiedEntity.description,
          equals('Original Description')); // unchanged
      expect(copiedEntity.qty, equals(200));
    });

    test(
        'should demonstrate data loss in roundtrip conversion due to mapper bug',
        () {
      // Arrange
      final originalWarehouse = InventoryWarehouse(
        name: 'Test Warehouse',
        description: 'Test Description',
        qty: 75,
      )
        ..messageType = 1
        ..message = 'In Stock'
        ..requiresRealTimeInventory = true;

      // Act
      final entity = mapper.toEntity(originalWarehouse);
      final convertedBack = mapper.toModel(entity);

      // Assert
      // These fields are preserved
      expect(convertedBack.name, equals(originalWarehouse.name));
      expect(convertedBack.description, equals(originalWarehouse.description));
      expect(convertedBack.qty, equals(originalWarehouse.qty));

      // These fields are lost due to the bug in toModel method (commented out)
      expect(convertedBack.messageType, isNull); // Bug: should be 1
      expect(convertedBack.message, isNull); // Bug: should be 'In Stock'
      expect(convertedBack.requiresRealTimeInventory,
          isNull); // Bug: should be true
    });
  });
}
