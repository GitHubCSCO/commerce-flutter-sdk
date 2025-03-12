import 'package:flutter_test/flutter_test.dart';
import 'package:commerce_flutter_app/features/domain/mapper/availability_mapper.dart';
import 'package:commerce_flutter_app/features/domain/entity/availability_entity.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

void main() {
  group('AvailabilityEntityMapper', () {
    test('toEntity should convert model to entity with all properties', () {
      // Arrange
      final model = Availability(
        messageType: 1,
        message: 'In Stock',
        requiresRealTimeInventory: true,
      );

      // Act
      final entity = AvailabilityEntityMapper.toEntity(model);

      // Assert
      expect(entity.messageType, model.messageType);
      expect(entity.message, model.message);
      expect(entity.requiresRealTimeInventory, model.requiresRealTimeInventory);
    });

    test('toEntity should handle null model', () {
      // Act
      final entity = AvailabilityEntityMapper.toEntity(null);

      // Assert
      expect(entity.messageType, null);
      expect(entity.message, null);
      expect(entity.requiresRealTimeInventory, null);
    });

    test('toEntity should handle model with null properties', () {
      // Arrange
      final model = Availability(
        messageType: null,
        message: null,
        requiresRealTimeInventory: null,
      );

      // Act
      final entity = AvailabilityEntityMapper.toEntity(model);

      // Assert
      expect(entity.messageType, null);
      expect(entity.message, null);
      expect(entity.requiresRealTimeInventory, null);
    });

    test('toModel should convert entity to model with all properties', () {
      // Arrange
      const entity = AvailabilityEntity(
        messageType: 2,
        message: 'Out of Stock',
        requiresRealTimeInventory: false,
      );

      // Act
      final model = AvailabilityEntityMapper.toModel(entity);

      // Assert
      expect(model.messageType, entity.messageType);
      expect(model.message, entity.message);
      expect(model.requiresRealTimeInventory, entity.requiresRealTimeInventory);
    });

    test('toModel should handle entity with null properties', () {
      // Arrange
      const entity = AvailabilityEntity();

      // Act
      final model = AvailabilityEntityMapper.toModel(entity);

      // Assert
      expect(model.messageType, null);
      expect(model.message, null);
      expect(model.requiresRealTimeInventory, null);
    });

    test('roundtrip conversion preserves all data', () {
      // Arrange
      final originalModel = Availability(
        messageType: 3,
        message: 'Pre-order Available',
        requiresRealTimeInventory: true,
      );

      // Act
      final entity = AvailabilityEntityMapper.toEntity(originalModel);
      final resultModel = AvailabilityEntityMapper.toModel(entity);

      // Assert
      expect(resultModel.messageType, equals(originalModel.messageType));
      expect(resultModel.message, equals(originalModel.message));
      expect(resultModel.requiresRealTimeInventory,
          equals(originalModel.requiresRealTimeInventory));
    });
  });
}
