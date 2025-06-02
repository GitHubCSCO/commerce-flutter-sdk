import 'package:commerce_flutter_sdk/src/features/domain/entity/attribute_value_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/attribute_value_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

void main() {
  late AttributeValueEntityMapper mapper;

  setUp(() {
    mapper = AttributeValueEntityMapper();
  });

  group('AttributeValueEntityMapper', () {
    test('should correctly map AttributeValue to AttributeValueEntity', () {
      // Arrange
      final model = AttributeValue(
        attributeValueId: "1001",
        value: "Red",
        valueDisplay: "Red Color",
        sortOrder: 1,
        isActive: true,
        id: "2001",
        count: 5,
        selected: false,
      );

      // Act
      final result = mapper.toEntity(model);

      // Assert
      expect(result.attributeValueId, model.attributeValueId);
      expect(result.value, model.value);
      expect(result.valueDisplay, model.valueDisplay);
      expect(result.sortOrder, model.sortOrder);
      expect(result.isActive, model.isActive);
      expect(result.id, model.id);
      expect(result.count, model.count);
      expect(result.selected, model.selected);
    });

    test('should correctly map AttributeValueEntity to AttributeValue', () {
      // Arrange
      final entity = AttributeValueEntity(
        attributeValueId: "3001",
        value: "Blue",
        valueDisplay: "Blue Color",
        sortOrder: 2,
        isActive: false,
        id: "4001",
        count: 10,
        selected: true,
      );

      // Act
      final result = mapper.toModel(entity);

      // Assert
      expect(result.attributeValueId, entity.attributeValueId);
      expect(result.value, entity.value);
      expect(result.valueDisplay, entity.valueDisplay);
      expect(result.sortOrder, entity.sortOrder);
      expect(result.isActive, entity.isActive);
      expect(result.id, entity.id);
      expect(result.count, entity.count);
      expect(result.selected, entity.selected);
    });
  });
}
