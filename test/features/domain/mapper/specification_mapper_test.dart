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
        specificationId: "spec001",
        name: "Material",
        nameDisplay: "Material Type",
        value: "Cotton",
        description: "Type of material used",
        sortOrder: 1.0,
        isActive: true,
        htmlContent: "<p>Cotton material specification</p>",
      );

      // Act
      final result = mapper.toEntity(model);

      // Assert
      expect(result.specificationId, model.specificationId);
      expect(result.name, model.name);
      expect(result.nameDisplay, model.nameDisplay);
      expect(result.value, model.value);
      expect(result.description, model.description);
      expect(result.sortOrder, model.sortOrder);
      expect(result.isActive, model.isActive);
      expect(result.htmlContent, model.htmlContent);
      expect(result.parentSpecification, isNull);
      expect(result.specifications, isNull);
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
        isActive: true,
        htmlContent: "<p>Blue color specification</p>",
      );

      // Act
      final result = mapper.toModel(entity);

      // Assert
      expect(result.specificationId, entity.specificationId);
      expect(result.name, entity.name);
      expect(result.nameDisplay, entity.nameDisplay);
      expect(result.value, entity.value);
      expect(result.description, entity.description);
      expect(result.sortOrder, entity.sortOrder);
      expect(result.isActive, entity.isActive);
      expect(result.htmlContent, entity.htmlContent);
      expect(result.parentSpecification, isNull);
      expect(result.specifications, isNull);
    });

    test(
        'should handle nested parentSpecification when mapping to SpecificationEntity',
        () {
      // Arrange
      final parentSpec = Specification(
        specificationId: "parent001",
        name: "Fabric",
        nameDisplay: "Fabric Type",
        value: "Natural",
        description: "Natural fabric category",
        sortOrder: 1.0,
        isActive: true,
      );

      final model = Specification(
        specificationId: "child001",
        name: "Cotton",
        nameDisplay: "Cotton Type",
        value: "Organic Cotton",
        description: "Organic cotton specification",
        sortOrder: 1.1,
        isActive: true,
        parentSpecification: parentSpec,
      );

      // Act
      final result = mapper.toEntity(model);

      // Assert
      expect(result.specificationId, model.specificationId);
      expect(result.name, model.name);
      expect(result.parentSpecification, isNotNull);
      expect(result.parentSpecification?.specificationId,
          parentSpec.specificationId);
      expect(result.parentSpecification?.name, parentSpec.name);
      expect(result.parentSpecification?.value, parentSpec.value);
    });

    test(
        'should handle nested specifications when mapping to SpecificationEntity',
        () {
      // Arrange
      final childSpec = Specification(
        specificationId: "child002",
        name: "Weight",
        nameDisplay: "Fabric Weight",
        value: "200gsm",
        description: "Weight of the fabric",
        sortOrder: 2.1,
        isActive: true,
      );

      final model = Specification(
        specificationId: "parent002",
        name: "Fabric Details",
        nameDisplay: "Detailed Fabric Info",
        value: "Cotton Blend",
        description: "Detailed fabric specifications",
        sortOrder: 2.0,
        isActive: true,
        specifications: childSpec,
      );

      // Act
      final result = mapper.toEntity(model);

      // Assert
      expect(result.specificationId, model.specificationId);
      expect(result.name, model.name);
      expect(result.specifications, isNotNull);
      expect(result.specifications?.specificationId, childSpec.specificationId);
      expect(result.specifications?.name, childSpec.name);
      expect(result.specifications?.value, childSpec.value);
    });

    test(
        'should handle nested parentSpecification when mapping to Specification',
        () {
      // Arrange
      const parentEntity = SpecificationEntity(
        specificationId: "parent003",
        name: "Size Category",
        nameDisplay: "Size Category",
        value: "Standard",
        description: "Standard size category",
        sortOrder: 3.0,
        isActive: true,
      );

      const entity = SpecificationEntity(
        specificationId: "child003",
        name: "Medium",
        nameDisplay: "Medium Size",
        value: "M",
        description: "Medium size specification",
        sortOrder: 3.1,
        isActive: true,
        parentSpecification: parentEntity,
      );

      // Act
      final result = mapper.toModel(entity);

      // Assert
      expect(result.specificationId, entity.specificationId);
      expect(result.name, entity.name);
      expect(result.parentSpecification, isNotNull);
      expect(result.parentSpecification?.specificationId,
          parentEntity.specificationId);
      expect(result.parentSpecification?.name, parentEntity.name);
      expect(result.parentSpecification?.value, parentEntity.value);
    });

    test('should handle nested specifications when mapping to Specification',
        () {
      // Arrange
      const childEntity = SpecificationEntity(
        specificationId: "child004",
        name: "Dimensions",
        nameDisplay: "Product Dimensions",
        value: "10x5x2 cm",
        description: "Physical dimensions",
        sortOrder: 4.1,
        isActive: true,
      );

      const entity = SpecificationEntity(
        specificationId: "parent004",
        name: "Physical Properties",
        nameDisplay: "Physical Properties",
        value: "Compact",
        description: "Physical property specifications",
        sortOrder: 4.0,
        isActive: true,
        specifications: childEntity,
      );

      // Act
      final result = mapper.toModel(entity);

      // Assert
      expect(result.specificationId, entity.specificationId);
      expect(result.name, entity.name);
      expect(result.specifications, isNotNull);
      expect(
          result.specifications?.specificationId, childEntity.specificationId);
      expect(result.specifications?.name, childEntity.name);
      expect(result.specifications?.value, childEntity.value);
    });

    test(
        'should handle null values correctly when mapping to SpecificationEntity',
        () {
      // Arrange
      final model = Specification(
        specificationId: null,
        name: null,
        nameDisplay: null,
        value: null,
        description: null,
        sortOrder: null,
        isActive: null,
        parentSpecification: null,
        htmlContent: null,
        specifications: null,
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
      expect(result.isActive, isNull);
      expect(result.parentSpecification, isNull);
      expect(result.htmlContent, isNull);
      expect(result.specifications, isNull);
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
        isActive: null,
        parentSpecification: null,
        htmlContent: null,
        specifications: null,
      );

      // Act
      final result = mapper.toModel(entity);

      // Assert
      expect(result.specificationId, isNull);
      expect(result.name, isNull);
      expect(result.nameDisplay, isNull);
      expect(result.value, isNull);
      expect(result.description, isNull);
      expect(result.sortOrder, isNull);
      expect(result.isActive, isNull);
      expect(result.parentSpecification, isNull);
      expect(result.htmlContent, isNull);
      expect(result.specifications, isNull);
    });

    test('should maintain data integrity in roundtrip conversion', () {
      // Arrange
      final originalModel = Specification(
        specificationId: "roundtrip001",
        name: "Test Spec",
        nameDisplay: "Test Specification",
        value: "Test Value",
        description: "Test description",
        sortOrder: 5.0,
        isActive: true,
        htmlContent: "<p>Test HTML content</p>",
      );

      // Act
      final entity = mapper.toEntity(originalModel);
      final resultModel = mapper.toModel(entity);

      // Assert
      expect(resultModel.specificationId, originalModel.specificationId);
      expect(resultModel.name, originalModel.name);
      expect(resultModel.nameDisplay, originalModel.nameDisplay);
      expect(resultModel.value, originalModel.value);
      expect(resultModel.description, originalModel.description);
      expect(resultModel.sortOrder, originalModel.sortOrder);
      expect(resultModel.isActive, originalModel.isActive);
      expect(resultModel.htmlContent, originalModel.htmlContent);
    });

    test('should handle deep nested structure correctly', () {
      // Arrange - Create a deep nested structure
      final grandChildSpec = Specification(
        specificationId: "grandchild001",
        name: "Thread Count",
        nameDisplay: "Thread Count",
        value: "300",
        description: "Threads per square inch",
        sortOrder: 1.2,
        isActive: true,
      );

      final childSpec = Specification(
        specificationId: "child005",
        name: "Weave",
        nameDisplay: "Weave Type",
        value: "Percale",
        description: "Type of weave",
        sortOrder: 1.1,
        isActive: true,
        specifications: grandChildSpec,
      );

      final parentSpec = Specification(
        specificationId: "parent005",
        name: "Cotton",
        nameDisplay: "Cotton Type",
        value: "Egyptian Cotton",
        description: "Premium cotton specification",
        sortOrder: 1.0,
        isActive: true,
        specifications: childSpec,
      );

      // Act
      final result = mapper.toEntity(parentSpec);

      // Assert
      expect(result.specifications, isNotNull);
      expect(result.specifications?.specificationId, childSpec.specificationId);
      expect(result.specifications?.specifications, isNotNull);
      expect(result.specifications?.specifications?.specificationId,
          grandChildSpec.specificationId);
      expect(result.specifications?.specifications?.value, "300");
    });

    test('should handle complex nested parentSpecification correctly', () {
      // Arrange
      final grandParentSpec = Specification(
        specificationId: "grandparent001",
        name: "Textiles",
        nameDisplay: "Textile Category",
        value: "Natural Textiles",
        description: "Natural textile category",
        sortOrder: 1.0,
        isActive: true,
      );

      final parentSpec = Specification(
        specificationId: "parent006",
        name: "Cotton",
        nameDisplay: "Cotton Category",
        value: "Organic Cotton",
        description: "Organic cotton category",
        sortOrder: 1.1,
        isActive: true,
        parentSpecification: grandParentSpec,
      );

      final model = Specification(
        specificationId: "child006",
        name: "Percale",
        nameDisplay: "Percale Cotton",
        value: "Premium Percale",
        description: "Premium percale cotton specification",
        sortOrder: 1.2,
        isActive: true,
        parentSpecification: parentSpec,
      );

      // Act
      final result = mapper.toEntity(model);

      // Assert
      expect(result.parentSpecification, isNotNull);
      expect(result.parentSpecification?.specificationId,
          parentSpec.specificationId);
      expect(result.parentSpecification?.parentSpecification, isNotNull);
      expect(result.parentSpecification?.parentSpecification?.specificationId,
          grandParentSpec.specificationId);
      expect(result.parentSpecification?.parentSpecification?.value,
          "Natural Textiles");
    });
  });
}
