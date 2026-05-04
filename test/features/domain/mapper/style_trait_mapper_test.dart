import 'package:commerce_flutter_sdk/src/features/domain/entity/style_trait_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/style_value_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/style_trait_mapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

void main() {
  group('StyleTraitEntityMapper', () {
    test('toEntity should convert model to entity with all properties', () {
      // Arrange
      final styleValue = StyleValue(
        id: 'red-id',
        value: 'red',
        valueDisplay: 'Red',
        sortOrder: 1,
        isDefault: true,
        swatchColorValue: '#FF0000',
        swatchType: 'Color',
      );

      final model = StyleTrait(
        id: 'trait-123',
        name: 'Color',
        nameDisplay: 'Product Color',
        unselectedValue: 'Select a color',
        sortOrder: 1,
        displayType: 'Swatch',
        numberOfSwatchesVisible: 5,
        displayTextWithSwatch: true,
        traitValues: [styleValue],
      );

      // Act
      final entity = StyleTraitEntityMapper.toEntity(model);

      // Assert
      expect(entity.id, equals(model.id));
      expect(entity.name, equals(model.name));
      expect(entity.nameDisplay, equals(model.nameDisplay));
      expect(entity.unselectedValue, equals(model.unselectedValue));
      expect(entity.sortOrder, equals(model.sortOrder));
      expect(entity.displayType, equals(model.displayType));
      expect(entity.numberOfSwatchesVisible,
          equals(model.numberOfSwatchesVisible));
      expect(entity.displayTextWithSwatch, equals(model.displayTextWithSwatch));
      expect(entity.traitValues?.length, equals(1));
      expect(entity.traitValues?[0].value, equals('red'));
    });

    test('toEntity should handle model with null collections', () {
      // Arrange
      final model = StyleTrait(
        id: 'color-trait',
        name: 'Color',
        nameDisplay: 'Product Color',
        traitValues: null,
      );

      // Act
      final entity = StyleTraitEntityMapper.toEntity(model);

      // Assert
      expect(entity.id, equals(model.id));
      expect(entity.name, equals(model.name));
      expect(entity.nameDisplay, equals(model.nameDisplay));
      expect(entity.traitValues, isNull);
    });

    test('toEntity should handle model with empty collections', () {
      // Arrange
      final model = StyleTrait(
        id: 'color-trait',
        name: 'Color',
        nameDisplay: 'Product Color',
        traitValues: [],
      );

      // Act
      final entity = StyleTraitEntityMapper.toEntity(model);

      // Assert
      expect(entity.id, equals(model.id));
      expect(entity.name, equals(model.name));
      expect(entity.nameDisplay, equals(model.nameDisplay));
      expect(entity.traitValues, isEmpty);
    });

    test('toModel should convert entity to model with all properties', () {
      // Arrange
      const styleValueEntity = StyleValueEntity(
        id: 'red-id',
        value: 'red',
        valueDisplay: 'Red',
        sortOrder: 1,
        isDefault: true,
        swatchColorValue: '#FF0000',
        swatchType: 'Color',
      );

      const entity = StyleTraitEntity(
        id: 'trait-123',
        name: 'Color',
        nameDisplay: 'Product Color',
        unselectedValue: 'Select a color',
        sortOrder: 1,
        displayType: 'Swatch',
        numberOfSwatchesVisible: 5,
        displayTextWithSwatch: true,
        traitValues: [styleValueEntity],
      );

      // Act
      final model = StyleTraitEntityMapper.toModel(entity);

      // Assert
      expect(model.id, equals(entity.id));
      expect(model.name, equals(entity.name));
      expect(model.nameDisplay, equals(entity.nameDisplay));
      expect(model.unselectedValue, equals(entity.unselectedValue));
      expect(model.sortOrder, equals(entity.sortOrder));
      expect(model.traitValues?.length, equals(1));
      expect(model.traitValues?[0].value, equals('red'));
    });

    test('toModel should handle entity with null collections', () {
      // Arrange
      const entity = StyleTraitEntity(
        id: 'color-trait',
        name: 'Color',
        nameDisplay: 'Product Color',
        traitValues: null,
      );

      // Act
      final model = StyleTraitEntityMapper.toModel(entity);

      // Assert
      expect(model.id, equals(entity.id));
      expect(model.name, equals(entity.name));
      expect(model.nameDisplay, equals(entity.nameDisplay));
      expect(model.traitValues, isNull);
    });

    test('toModel should handle entity with empty collections', () {
      // Arrange
      const entity = StyleTraitEntity(
        id: 'color-trait',
        name: 'Color',
        nameDisplay: 'Product Color',
        traitValues: [],
      );

      // Act
      final model = StyleTraitEntityMapper.toModel(entity);

      // Assert
      expect(model.id, equals(entity.id));
      expect(model.name, equals(entity.name));
      expect(model.nameDisplay, equals(entity.nameDisplay));
      expect(model.traitValues, isEmpty);
    });

    test('roundtrip conversion preserves all data', () {
      // Arrange
      final styleValue = StyleValue(
        id: 'red-id',
        value: 'red',
        valueDisplay: 'Red',
        sortOrder: 1,
        isDefault: true,
        swatchColorValue: '#FF0000',
        swatchType: 'Color',
      );

      final originalModel = StyleTrait(
        id: 'trait-123',
        name: 'Color',
        nameDisplay: 'Product Color',
        unselectedValue: 'Select a color',
        sortOrder: 1,
        displayType: 'Swatch',
        numberOfSwatchesVisible: 5,
        displayTextWithSwatch: true,
        traitValues: [styleValue],
      );

      // Act
      final entity = StyleTraitEntityMapper.toEntity(originalModel);
      final resultModel = StyleTraitEntityMapper.toModel(entity);

      // Assert
      expect(resultModel.id, equals(originalModel.id));
      expect(resultModel.name, equals(originalModel.name));
      expect(resultModel.nameDisplay, equals(originalModel.nameDisplay));
      expect(
          resultModel.unselectedValue, equals(originalModel.unselectedValue));
      expect(resultModel.sortOrder, equals(originalModel.sortOrder));
      expect(resultModel.traitValues?.length,
          equals(originalModel.traitValues?.length));
      expect(resultModel.traitValues?[0].value,
          equals(originalModel.traitValues?[0].value));
    });
  });
}
