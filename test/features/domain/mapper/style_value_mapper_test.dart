import 'package:commerce_flutter_sdk/src/features/domain/entity/style_value_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/style_value_mapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

void main() {
  group('StyleValueEntityMapper', () {
    test('toEntity should convert model to entity with all properties', () {
      // Arrange
      final model = StyleValue(
        id: 'style-value-123',
        value: 'Red',
        valueDisplay: 'Bright Red',
        sortOrder: 1,
        isDefault: true,
        swatchColorValue: '#FF0000',
        swatchImageValue: '/images/red-swatch.png',
        swatchType: 'Color',
      );

      // Act
      final entity = StyleValueEntityMapper.toEntity(model);

      // Assert
      expect(entity.id, equals(model.id));
      expect(entity.value, equals(model.value));
      expect(entity.valueDisplay, equals(model.valueDisplay));
      expect(entity.sortOrder, equals(model.sortOrder));
      expect(entity.isDefault, equals(model.isDefault));
      expect(entity.swatchColorValue, equals(model.swatchColorValue));
      expect(entity.swatchImageValue, equals(model.swatchImageValue));
      expect(entity.swatchType, equals(model.swatchType));
    });

    test('toEntity should handle null model', () {
      final model = StyleValue(
        id: null,
        value: null,
        valueDisplay: null,
        sortOrder: null,
        isDefault: null,
        swatchColorValue: null,
        swatchImageValue: null,
        swatchType: null,
      );

      // Act
      final entity = StyleValueEntityMapper.toEntity(model);

      // Assert
      expect(entity.id, isNull);
      expect(entity.value, isNull);
      expect(entity.valueDisplay, isNull);
      expect(entity.sortOrder, isNull);
      expect(entity.isDefault, isNull);
      expect(entity.swatchColorValue, isNull);
      expect(entity.swatchImageValue, isNull);
      expect(entity.swatchType, isNull);
    });

    test('toModel should convert entity to model with all properties', () {
      // Arrange
      const entity = StyleValueEntity(
        id: 'style-value-123',
        value: 'Red',
        valueDisplay: 'Bright Red',
        sortOrder: 1,
        isDefault: true,
        swatchColorValue: '#FF0000',
        swatchImageValue: '/images/red-swatch.png',
        swatchType: 'Color',
      );

      // Act
      final model = StyleValueEntityMapper.toModel(entity);

      // Assert
      expect(model.id, equals(entity.id));
      expect(model.value, equals(entity.value));
      expect(model.valueDisplay, equals(entity.valueDisplay));
      expect(model.sortOrder, equals(entity.sortOrder));
      expect(model.isDefault, equals(entity.isDefault));
    });

    test('toModel should handle entity with null properties', () {
      // Arrange
      const entity = StyleValueEntity();

      // Act
      final model = StyleValueEntityMapper.toModel(entity);

      // Assert
      expect(model.id, isNull);
      expect(model.value, isNull);
      expect(model.valueDisplay, isNull);
      expect(model.sortOrder, isNull);
      expect(model.isDefault, isNull);
      expect(model.swatchColorValue, isNull);
      expect(model.swatchImageValue, isNull);
      expect(model.swatchType, isNull);
    });

    test('roundtrip conversion preserves common properties', () {
      // Arrange
      final originalModel = StyleValue(
        id: 'style-value-123',
        value: 'Red',
        valueDisplay: 'Bright Red',
        sortOrder: 1,
        isDefault: true,
        swatchColorValue: '#FF0000',
        swatchImageValue: '/images/red-swatch.png',
        swatchType: 'Color',
      );

      // Act
      final entity = StyleValueEntityMapper.toEntity(originalModel);
      final resultModel = StyleValueEntityMapper.toModel(entity);

      // Assert
      expect(resultModel.id, equals(originalModel.id));
      expect(resultModel.value, equals(originalModel.value));
      expect(resultModel.valueDisplay, equals(originalModel.valueDisplay));
      expect(resultModel.sortOrder, equals(originalModel.sortOrder));
      expect(resultModel.isDefault, equals(originalModel.isDefault));
    });
  });
}
