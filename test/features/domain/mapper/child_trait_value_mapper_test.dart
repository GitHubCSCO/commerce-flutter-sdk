import 'package:flutter_test/flutter_test.dart';
import 'package:commerce_flutter_app/features/domain/entity/child_trait_value_entity.dart';
import 'package:commerce_flutter_app/features/domain/mapper/child_trait_value_mapper.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

void main() {
  group('ChildTraitValueEntityMapper', () {
    test('should correctly map ChildTraitValue to ChildTraitValueEntity', () {
      // Arrange
      final childTraitValue = ChildTraitValue(
        id: "123",
        styleTraitId: "ST-001",
        value: "red",
        valueDisplay: "Red",
      );

      // Act
      final result = ChildTraitValueEntityMapper.toEntity(childTraitValue);

      // Assert
      expect(result.id, childTraitValue.id);
      expect(result.styleTraitId, childTraitValue.styleTraitId);
      expect(result.value, childTraitValue.value);
      expect(result.valueDisplay, childTraitValue.valueDisplay);
    });

    test('should correctly map ChildTraitValueEntity to ChildTraitValue', () {
      // Arrange
      final childTraitValueEntity = ChildTraitValueEntity(
        id: "123",
        styleTraitId: "ST-001",
        value: "red",
        valueDisplay: "Red",
      );

      // Act
      final result = ChildTraitValueEntityMapper.toModel(childTraitValueEntity);

      // Assert
      expect(result.id, childTraitValueEntity.id);
      expect(result.styleTraitId, childTraitValueEntity.styleTraitId);
      expect(result.value, childTraitValueEntity.value);
      expect(result.valueDisplay, childTraitValueEntity.valueDisplay);
    });
  });
}
