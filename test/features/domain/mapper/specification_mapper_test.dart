import 'package:commerce_flutter_sdk/src/features/domain/entity/specification_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/specification_mapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

void main() {
  late SpecificationEntityMapper mapper;

  setUp(() {
    mapper = SpecificationEntityMapper();
  });

  group('SpecificationEntityMapper', () {
    test('should correctly map Specification to SpecificationEntity', () {
      // Arrange
      final model = Specification(
        id: "spec001",
        name: "Material",
        nameDisplay: "Material Type",
        value: "Cotton",
        description: "Type of material used",
        sortOrder: 1.0,
        htmlContent: "<p>Cotton material specification</p>",
      );

      // Act
      final result = mapper.toEntity(model);

      // Assert
      expect(result.specificationId, model.id);
      expect(result.name, model.name);
      expect(result.nameDisplay, model.nameDisplay);
      expect(result.value, model.value);
      expect(result.description, model.description);
      expect(result.sortOrder, model.sortOrder);
      expect(result.htmlContent, model.htmlContent);
    });

    test('should correctly map SpecificationEntity to Specification', () {
      // Arrange
      const entity = SpecificationEntity(
        specificationId: "spec002",
        name: "Color",
        nameDisplay: "Product Color",
        value: "Blue",
        description: "Color of the product",
        sortOrder: 2.0,
        htmlContent: "<p>Blue color specification</p>",
      );

      // Act
      final result = mapper.toModel(entity);

      // Assert
      expect(result.id, entity.specificationId);
      expect(result.name, entity.name);
      expect(result.nameDisplay, entity.nameDisplay);
      expect(result.value, entity.value);
      expect(result.description, entity.description);
      expect(result.sortOrder, entity.sortOrder);
      expect(result.htmlContent, entity.htmlContent);
    });

    test(
        'should handle null values correctly when mapping to SpecificationEntity',
        () {
      // Arrange
      final model = Specification(
        id: null,
        name: null,
        nameDisplay: null,
        value: null,
        description: null,
        sortOrder: null,
        htmlContent: null,
      );

      // Act
      final result = mapper.toEntity(model);

      // Assert
      expect(result.specificationId, isNull);
      expect(result.name, isNull);
      expect(result.nameDisplay, isNull);
      expect(result.value, isNull);
      expect(result.description, isNull);
      expect(result.sortOrder, isNull);
      expect(result.htmlContent, isNull);
    });

    test('should handle null values correctly when mapping to Specification',
        () {
      // Arrange
      const entity = SpecificationEntity(
        specificationId: null,
        name: null,
        nameDisplay: null,
        value: null,
        description: null,
        sortOrder: null,
        htmlContent: null,
      );

      // Act
      final result = mapper.toModel(entity);

      // Assert
      expect(result.id, isNull);
      expect(result.name, isNull);
      expect(result.nameDisplay, isNull);
      expect(result.value, isNull);
      expect(result.description, isNull);
      expect(result.sortOrder, isNull);
      expect(result.htmlContent, isNull);
    });

    test('should maintain data integrity in roundtrip conversion', () {
      // Arrange
      final originalModel = Specification(
        id: "roundtrip001",
        name: "Test Spec",
        nameDisplay: "Test Specification",
        value: "Test Value",
        description: "Test description",
        sortOrder: 5.0,
        htmlContent: "<p>Test HTML content</p>",
      );

      // Act
      final entity = mapper.toEntity(originalModel);
      final resultModel = mapper.toModel(entity);

      // Assert
      expect(resultModel.id, originalModel.id);
      expect(resultModel.name, originalModel.name);
      expect(resultModel.nameDisplay, originalModel.nameDisplay);
      expect(resultModel.value, originalModel.value);
      expect(resultModel.description, originalModel.description);
      expect(resultModel.sortOrder, originalModel.sortOrder);
      expect(resultModel.htmlContent, originalModel.htmlContent);
    });
  });
}
