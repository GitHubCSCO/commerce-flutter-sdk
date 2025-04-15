import 'package:commerce_flutter_app/features/domain/mapper/availability_mapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:commerce_flutter_app/features/domain/entity/availability_entity.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

void main() {
  group('AvailabilityEntityMapper', () {
    test('should correctly map Availability to AvailabilityEntity', () {
      // Arrange
      final model = Availability(
        messageType: 1,
        message: "In Stock",
        requiresRealTimeInventory: true,
      );

      // Act
      final result = AvailabilityEntityMapper.toEntity(model);

      // Assert
      expect(result.messageType, model.messageType);
      expect(result.message, model.message);
      expect(result.requiresRealTimeInventory, model.requiresRealTimeInventory);
    });

    test('should correctly map AvailabilityEntity to Availability', () {
      // Arrange
      final entity = AvailabilityEntity(
        messageType: 2,
        message: "Out of Stock",
        requiresRealTimeInventory: false,
      );

      // Act
      final result = AvailabilityEntityMapper.toModel(entity);

      // Assert
      expect(result.messageType, entity.messageType);
      expect(result.message, entity.message);
      expect(
          result.requiresRealTimeInventory, entity.requiresRealTimeInventory);
    });

    test('should handle null Availability model correctly', () {
      // Act
      final result = AvailabilityEntityMapper.toEntity(null);

      // Assert
      expect(result.messageType, isNull);
      expect(result.message, isNull);
      expect(result.requiresRealTimeInventory, isNull);
    });
  });
}
