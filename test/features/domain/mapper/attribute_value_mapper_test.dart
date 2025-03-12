import 'package:flutter_test/flutter_test.dart';
import 'package:commerce_flutter_app/features/domain/entity/attribute_value_entity.dart';
import 'package:commerce_flutter_app/features/domain/mapper/attribute_value_mapper.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

void main() {
  late AttributeValueEntityMapper mapper;

  setUp(() {
    mapper = AttributeValueEntityMapper();
  });

  group('AttributeValueEntityMapper', () {
    test('toEntity converts model to entity correctly', () {
      // Arrange
      final model = AttributeValue(
        attributeValueId: '123',
        value: 'red',
        valueDisplay: 'Red',
        sortOrder: 1,
        isActive: true,
        id: '456',
        count: 10,
        selected: false,
      );

      // Act
      final entity = mapper.toEntity(model);

      // Assert
      expect(entity.attributeValueId, equals('123'));
      expect(entity.value, equals('red'));
      expect(entity.valueDisplay, equals('Red'));
      expect(entity.sortOrder, equals(1));
      expect(entity.isActive, isTrue);
      expect(entity.id, equals('456'));
      expect(entity.count, equals(10));
      expect(entity.selected, isFalse);
    });

    test('toModel converts entity to model correctly', () {
      // Arrange
      const entity = AttributeValueEntity(
        attributeValueId: '789',
        value: 'blue',
        valueDisplay: 'Blue',
        sortOrder: 2,
        isActive: false,
        id: '012',
        count: 5,
        selected: true,
      );

      // Act
      final model = mapper.toModel(entity);

      // Assert
      expect(model.attributeValueId, equals('789'));
      expect(model.value, equals('blue'));
      expect(model.valueDisplay, equals('Blue'));
      expect(model.sortOrder, equals(2));
      expect(model.isActive, isFalse);
      expect(model.id, equals('012'));
      expect(model.count, equals(5));
      expect(model.selected, isTrue);
    });

    test(
        'roundtrip conversion from model to entity to model preserves all data',
        () {
      // Arrange
      final originalModel = AttributeValue(
        attributeValueId: '123',
        value: 'green',
        valueDisplay: 'Green',
        sortOrder: 3,
        isActive: true,
        id: '456',
        count: 15,
        selected: true,
      );

      // Act
      final entity = mapper.toEntity(originalModel);
      final resultModel = mapper.toModel(entity);

      // Assert
      expect(
          resultModel.attributeValueId, equals(originalModel.attributeValueId));
      expect(resultModel.value, equals(originalModel.value));
      expect(resultModel.valueDisplay, equals(originalModel.valueDisplay));
      expect(resultModel.sortOrder, equals(originalModel.sortOrder));
      expect(resultModel.isActive, equals(originalModel.isActive));
      expect(resultModel.id, equals(originalModel.id));
      expect(resultModel.count, equals(originalModel.count));
      expect(resultModel.selected, equals(originalModel.selected));
    });

    test(
        'roundtrip conversion from entity to model to entity preserves all data',
        () {
      // Arrange
      const originalEntity = AttributeValueEntity(
        attributeValueId: '789',
        value: 'yellow',
        valueDisplay: 'Yellow',
        sortOrder: 4,
        isActive: false,
        id: '012',
        count: 20,
        selected: false,
      );

      // Act
      final model = mapper.toModel(originalEntity);
      final resultEntity = mapper.toEntity(model);

      // Assert
      expect(resultEntity.attributeValueId,
          equals(originalEntity.attributeValueId));
      expect(resultEntity.value, equals(originalEntity.value));
      expect(resultEntity.valueDisplay, equals(originalEntity.valueDisplay));
      expect(resultEntity.sortOrder, equals(originalEntity.sortOrder));
      expect(resultEntity.isActive, equals(originalEntity.isActive));
      expect(resultEntity.id, equals(originalEntity.id));
      expect(resultEntity.count, equals(originalEntity.count));
      expect(resultEntity.selected, equals(originalEntity.selected));
    });

    test('toEntity handles null properties correctly', () {
      // Arrange
      final model = AttributeValue(
        attributeValueId: null,
        value: null,
        valueDisplay: null,
        sortOrder: null,
        isActive: null,
        id: null,
        count: null,
        selected: null,
      );

      // Act
      final entity = mapper.toEntity(model);

      // Assert
      expect(entity.attributeValueId, isNull);
      expect(entity.value, isNull);
      expect(entity.valueDisplay, isNull);
      expect(entity.sortOrder, isNull);
      expect(entity.isActive, isNull);
      expect(entity.id, isNull);
      expect(entity.count, isNull);
      expect(entity.selected, isNull);
    });

    test('toModel handles null properties correctly', () {
      // Arrange
      const entity = AttributeValueEntity(
        attributeValueId: null,
        value: null,
        valueDisplay: null,
        sortOrder: null,
        isActive: null,
        id: null,
        count: null,
        selected: null,
      );

      // Act
      final model = mapper.toModel(entity);

      // Assert
      expect(model.attributeValueId, isNull);
      expect(model.value, isNull);
      expect(model.valueDisplay, isNull);
      expect(model.sortOrder, isNull);
      expect(model.isActive, isNull);
      expect(model.id, isNull);
      expect(model.count, isNull);
      expect(model.selected, isNull);
    });
  });
}
