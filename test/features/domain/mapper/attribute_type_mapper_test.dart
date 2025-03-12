import 'package:commerce_flutter_app/features/domain/entity/attribute_type_entity.dart';
import 'package:commerce_flutter_app/features/domain/mapper/attribute_type_mapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

void main() {
  late AttributeTypeEntityMapper mapper;

  setUp(() {
    mapper = AttributeTypeEntityMapper();
  });

  group('AttributeTypeEntityMapper', () {
    test('toEntity converts model to entity correctly', () {
      // Arrange
      final model = AttributeType(
        attributeTypeId: '123',
        name: 'Color',
        nameDisplay: 'Product Color',
        sort: 1,
        id: '456',
        label: 'color_label',
        isFilter: true,
        isComparable: false,
        isActive: true,
        sortOrder: 10,
        attributeValueFacets: [],
        attributeValues: [],
      );

      // Act
      final entity = mapper.toEntity(model);

      // Assert
      expect(entity.attributeTypeId, equals('123'));
      expect(entity.name, equals('Color'));
      expect(entity.nameDisplay, equals('Product Color'));
      expect(entity.sort, equals(1));
      expect(entity.id, equals('456'));
      expect(entity.label, equals('color_label'));
      expect(entity.isFilter, isTrue);
      expect(entity.isComparable, isFalse);
      expect(entity.isActive, isTrue);
      expect(entity.sortOrder, equals(10));
      expect(entity.attributeValueFacets, isEmpty);
      expect(entity.attributeValues, isEmpty);
    });

    test('toModel converts entity to model correctly', () {
      // Arrange
      const entity = AttributeTypeEntity(
        attributeTypeId: '123',
        name: 'Color',
        nameDisplay: 'Product Color',
        sort: 1,
        id: '456',
        label: 'color_label',
        isFilter: true,
        isComparable: false,
        isActive: true,
        sortOrder: 10,
        attributeValueFacets: [],
        attributeValues: [],
      );

      // Act
      final model = mapper.toModel(entity);

      // Assert
      expect(model.attributeTypeId, equals('123'));
      expect(model.name, equals('Color'));
      expect(model.nameDisplay, equals('Product Color'));
      expect(model.sort, equals(1));
      expect(model.id, equals('456'));
      expect(model.label, equals('color_label'));
      expect(model.isFilter, isTrue);
      expect(model.isComparable, isFalse);
      expect(model.isActive, isTrue);
      expect(model.sortOrder, equals(10));
      expect(model.attributeValueFacets, isEmpty);
      expect(model.attributeValues, isEmpty);
    });

    test('toEntity handles null attributeValues and attributeValueFacets', () {
      // Arrange
      final model = AttributeType(
        attributeTypeId: '123',
        name: 'Color',
        attributeValues: null,
        attributeValueFacets: null,
      );

      // Act
      final entity = mapper.toEntity(model);

      // Assert
      expect(entity.attributeValues, isNull);
      expect(entity.attributeValueFacets, isNull);
    });

    test('toModel handles null attributeValues and attributeValueFacets', () {
      // Arrange
      const entity = AttributeTypeEntity(
        attributeTypeId: '123',
        name: 'Color',
        attributeValues: null,
        attributeValueFacets: null,
      );

      // Act
      final model = mapper.toModel(entity);

      // Assert
      expect(model.attributeValues, isNull);
      expect(model.attributeValueFacets, isNull);
    });

    test('roundtrip conversion preserves all data', () {
      // Arrange
      final originalModel = AttributeType(
        attributeTypeId: '123',
        name: 'Color',
        nameDisplay: 'Product Color',
        sort: 1,
        id: '456',
        label: 'color_label',
        isFilter: true,
        isComparable: false,
        isActive: true,
        sortOrder: 10,
        attributeValueFacets: [],
        attributeValues: [],
      );

      // Act
      final entity = mapper.toEntity(originalModel);
      final resultModel = mapper.toModel(entity);

      // Assert
      expect(
          resultModel.attributeTypeId, equals(originalModel.attributeTypeId));
      expect(resultModel.name, equals(originalModel.name));
      expect(resultModel.nameDisplay, equals(originalModel.nameDisplay));
      expect(resultModel.sort, equals(originalModel.sort));
      expect(resultModel.id, equals(originalModel.id));
      expect(resultModel.label, equals(originalModel.label));
      expect(resultModel.isFilter, equals(originalModel.isFilter));
      expect(resultModel.isComparable, equals(originalModel.isComparable));
      expect(resultModel.isActive, equals(originalModel.isActive));
      expect(resultModel.sortOrder, equals(originalModel.sortOrder));
    });
  });
}
