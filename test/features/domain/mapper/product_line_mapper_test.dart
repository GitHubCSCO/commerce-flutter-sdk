import 'package:commerce_flutter_sdk/src/features/domain/entity/product_line_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/product_line_mapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

void main() {
  group('ProductLineEntityMapper', () {
    test('toEntity should convert model to entity with all properties', () {
      // Arrange
      final model = ProductLine(
        id: 'line123',
        name: 'Test Product Line',
      );

      // Act
      final entity = ProductLineEntityMapper.toEntity(model);

      // Assert
      expect(entity.id, equals(model.id));
      expect(entity.name, equals(model.name));
    });

    test('toEntity should handle null model', () {
      // Act
      final entity = ProductLineEntityMapper.toEntity(null);

      // Assert
      expect(entity.id, isNull);
      expect(entity.name, isNull);
    });

    test('toEntity should handle model with null properties', () {
      // Arrange
      final model = ProductLine(
        id: null,
        name: null,
      );

      // Act
      final entity = ProductLineEntityMapper.toEntity(model);

      // Assert
      expect(entity.id, isNull);
      expect(entity.name, isNull);
    });

    test('toModel should convert entity to model with all properties', () {
      // Arrange
      const entity = ProductLineEntity(
        id: 'line456',
        name: 'Another Product Line',
      );

      // Act
      final model = ProductLineEntityMapper.toModel(entity);

      // Assert
      expect(model?.id, equals(entity.id));
      expect(model?.name, equals(entity.name));
    });

    test('toModel should handle entity with null properties', () {
      // Arrange
      const entity = ProductLineEntity(
        id: null,
        name: null,
      );

      // Act
      final model = ProductLineEntityMapper.toModel(entity);

      // Assert
      expect(model?.id, isNull);
      expect(model?.name, isNull);
    });

    test('roundtrip conversion preserves all data', () {
      // Arrange
      final originalModel = ProductLine(
        id: 'line789',
        name: 'Premium Product Line',
      );

      // Act
      final entity = ProductLineEntityMapper.toEntity(originalModel);
      final resultModel = ProductLineEntityMapper.toModel(entity);

      // Assert
      expect(resultModel?.id, equals(originalModel.id));
      expect(resultModel?.name, equals(originalModel.name));
    });
  });
}
