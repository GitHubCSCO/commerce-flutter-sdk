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
        styleTraitId: 'color-id',
        styleTraitValueId: 'red-id',
        value: 'red',
        valueDisplay: 'Red',
        sortOrder: 1,
        isDefault: true,
        swatchColorValue: '#FF0000',
        swatchType: 'Color',
      );

      final model = StyleTrait(
        styleTraitId: 'color-trait',
        name: 'Color',
        nameDisplay: 'Product Color',
        unselectedValue: 'Select a color',
        sortOrder: 1,
        displayType: 'Swatch',
        numberOfSwatchesVisible: 5,
        displayTextWithSwatch: true,
        id: 'trait-123',
        styleValues: [styleValue],
        traitValues: [styleValue],
      );

      // Act
      final entity = StyleTraitEntityMapper.toEntity(model);

      // Assert
      expect(entity.styleTraitId, equals(model.styleTraitId));
      expect(entity.name, equals(model.name));
      expect(entity.nameDisplay, equals(model.nameDisplay));
      expect(entity.unselectedValue, equals(model.unselectedValue));
      expect(entity.sortOrder, equals(model.sortOrder));
      expect(entity.displayType, equals(model.displayType));
      expect(entity.numberOfSwatchesVisible,
          equals(model.numberOfSwatchesVisible));
      expect(entity.displayTextWithSwatch, equals(model.displayTextWithSwatch));
      expect(entity.id, equals(model.id));
      expect(entity.styleValues?.length, equals(1));
      expect(entity.styleValues?[0].styleTraitId, equals('color-id'));
      expect(entity.styleValues?[0].value, equals('red'));
      expect(entity.traitValues?.length, equals(1));
      expect(entity.traitValues?[0].styleTraitId, equals('color-id'));
    });

    test('toEntity should handle model with null collections', () {
      // Arrange
      final model = StyleTrait(
        styleTraitId: 'color-trait',
        name: 'Color',
        nameDisplay: 'Product Color',
        styleValues: null,
        traitValues: null,
      );

      // Act
      final entity = StyleTraitEntityMapper.toEntity(model);

      // Assert
      expect(entity.styleTraitId, equals(model.styleTraitId));
      expect(entity.name, equals(model.name));
      expect(entity.nameDisplay, equals(model.nameDisplay));
      expect(entity.styleValues, isNull);
      expect(entity.traitValues, isNull);
    });

    test('toEntity should handle model with empty collections', () {
      // Arrange
      final model = StyleTrait(
        styleTraitId: 'color-trait',
        name: 'Color',
        nameDisplay: 'Product Color',
        styleValues: [],
        traitValues: [],
      );

      // Act
      final entity = StyleTraitEntityMapper.toEntity(model);

      // Assert
      expect(entity.styleTraitId, equals(model.styleTraitId));
      expect(entity.name, equals(model.name));
      expect(entity.nameDisplay, equals(model.nameDisplay));
      expect(entity.styleValues, isEmpty);
      expect(entity.traitValues, isEmpty);
    });

    test('toModel should convert entity to model with all properties', () {
      // Arrange
      const styleValueEntity = StyleValueEntity(
        styleTraitId: 'color-id',
        styleTraitValueId: 'red-id',
        value: 'red',
        valueDisplay: 'Red',
        sortOrder: 1,
        isDefault: true,
        swatchColorValue: '#FF0000',
        swatchType: 'Color',
      );

      const entity = StyleTraitEntity(
        styleTraitId: 'color-trait',
        name: 'Color',
        nameDisplay: 'Product Color',
        unselectedValue: 'Select a color',
        sortOrder: 1,
        displayType: 'Swatch',
        numberOfSwatchesVisible: 5,
        displayTextWithSwatch: true,
        id: 'trait-123',
        styleValues: [styleValueEntity],
        traitValues: [styleValueEntity],
      );

      // Act
      final model = StyleTraitEntityMapper.toModel(entity);

      // Assert
      expect(model.styleTraitId, equals(entity.styleTraitId));
      expect(model.name, equals(entity.name));
      expect(model.nameDisplay, equals(entity.nameDisplay));
      expect(model.unselectedValue, equals(entity.unselectedValue));
      expect(model.sortOrder, equals(entity.sortOrder));
      expect(model.id, equals(entity.id));
      expect(model.styleValues?.length, equals(1));
      expect(model.styleValues?[0].styleTraitId, equals('color-id'));
      expect(model.styleValues?[0].value, equals('red'));
      expect(model.traitValues?.length, equals(1));
      expect(model.traitValues?[0].styleTraitId, equals('color-id'));
    });

    test('toModel should handle entity with null collections', () {
      // Arrange
      const entity = StyleTraitEntity(
        styleTraitId: 'color-trait',
        name: 'Color',
        nameDisplay: 'Product Color',
        styleValues: null,
        traitValues: null,
      );

      // Act
      final model = StyleTraitEntityMapper.toModel(entity);

      // Assert
      expect(model.styleTraitId, equals(entity.styleTraitId));
      expect(model.name, equals(entity.name));
      expect(model.nameDisplay, equals(entity.nameDisplay));
      expect(model.styleValues, isNull);
      expect(model.traitValues, isNull);
    });

    test('toModel should handle entity with empty collections', () {
      // Arrange
      const entity = StyleTraitEntity(
        styleTraitId: 'color-trait',
        name: 'Color',
        nameDisplay: 'Product Color',
        styleValues: [],
        traitValues: [],
      );

      // Act
      final model = StyleTraitEntityMapper.toModel(entity);

      // Assert
      expect(model.styleTraitId, equals(entity.styleTraitId));
      expect(model.name, equals(entity.name));
      expect(model.nameDisplay, equals(entity.nameDisplay));
      expect(model.styleValues, isEmpty);
      expect(model.traitValues, isEmpty);
    });

    test('roundtrip conversion preserves all data', () {
      // Arrange
      final styleValue = StyleValue(
        styleTraitId: 'color-id',
        styleTraitValueId: 'red-id',
        value: 'red',
        valueDisplay: 'Red',
        sortOrder: 1,
        isDefault: true,
        swatchColorValue: '#FF0000',
        swatchType: 'Color',
      );

      final originalModel = StyleTrait(
        styleTraitId: 'color-trait',
        name: 'Color',
        nameDisplay: 'Product Color',
        unselectedValue: 'Select a color',
        sortOrder: 1,
        displayType: 'Swatch',
        numberOfSwatchesVisible: 5,
        displayTextWithSwatch: true,
        id: 'trait-123',
        styleValues: [styleValue],
        traitValues: [styleValue],
      );

      // Act
      final entity = StyleTraitEntityMapper.toEntity(originalModel);
      final resultModel = StyleTraitEntityMapper.toModel(entity);

      // Assert
      expect(resultModel.styleTraitId, equals(originalModel.styleTraitId));
      expect(resultModel.name, equals(originalModel.name));
      expect(resultModel.nameDisplay, equals(originalModel.nameDisplay));
      expect(
          resultModel.unselectedValue, equals(originalModel.unselectedValue));
      expect(resultModel.sortOrder, equals(originalModel.sortOrder));
      expect(resultModel.id, equals(originalModel.id));
      expect(resultModel.styleValues?.length,
          equals(originalModel.styleValues?.length));
      expect(resultModel.styleValues?[0].styleTraitId,
          equals(originalModel.styleValues?[0].styleTraitId));
      expect(resultModel.styleValues?[0].value,
          equals(originalModel.styleValues?[0].value));
      expect(resultModel.traitValues?.length,
          equals(originalModel.traitValues?.length));
      expect(resultModel.traitValues?[0].styleTraitId,
          equals(originalModel.traitValues?[0].styleTraitId));
    });
  });
}
