
import 'package:commerce_flutter_sdk/src/features/domain/entity/attribute_type_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/attribute_type_mapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

void main() {
  late AttributeTypeEntityMapper mapper;

  setUp(() {
    mapper = AttributeTypeEntityMapper();
  });

  group('AttributeTypeEntityMapper', () {
    test('should correctly map AttributeType to AttributeTypeEntity', () {
      // Arrange
      final model = AttributeType(
        attributeTypeId: "123",
        name: "Size",
        nameDisplay: "Size Display",
        sort: 1,
        attributeValueFacets: [],
        id: "456",
        label: "Size Label",
        isFilter: true,
        isComparable: false,
        isActive: true,
        sortOrder: 2,
        attributeValues: [],
      );

      // Act
      final result = mapper.toEntity(model);

      // Assert
      expect(result.attributeTypeId, model.attributeTypeId);
      expect(result.name, model.name);
      expect(result.nameDisplay, model.nameDisplay);
      expect(result.sort, model.sort);
      expect(result.attributeValueFacets, isEmpty);
      expect(result.id, model.id);
      expect(result.label, model.label);
      expect(result.isFilter, model.isFilter);
      expect(result.isComparable, model.isComparable);
      expect(result.isActive, model.isActive);
      expect(result.sortOrder, model.sortOrder);
      expect(result.attributeValues, isEmpty);
    });

    test('should correctly map AttributeTypeEntity to AttributeType', () {
      // Arrange
      final entity = AttributeTypeEntity(
        attributeTypeId: "789",
        name: "Color",
        nameDisplay: "Color Display",
        sort: 3,
        attributeValueFacets: [],
        id: "101",
        label: "Color Label",
        isFilter: false,
        isComparable: true,
        isActive: false,
        sortOrder: 4,
        attributeValues: [],
      );

      // Act
      final result = mapper.toModel(entity);

      // Assert
      expect(result.attributeTypeId, entity.attributeTypeId);
      expect(result.name, entity.name);
      expect(result.nameDisplay, entity.nameDisplay);
      expect(result.sort, entity.sort);
      expect(result.attributeValueFacets, isEmpty);
      expect(result.id, entity.id);
      expect(result.label, entity.label);
      expect(result.isFilter, entity.isFilter);
      expect(result.isComparable, entity.isComparable);
      expect(result.isActive, entity.isActive);
      expect(result.sortOrder, entity.sortOrder);
      expect(result.attributeValues, isEmpty);
    });
  });
}
