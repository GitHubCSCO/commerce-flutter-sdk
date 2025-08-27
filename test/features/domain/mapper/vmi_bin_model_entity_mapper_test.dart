import 'package:commerce_flutter_sdk/src/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/vmi_bin_model_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/vmi_bin_model_entity_mapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

void main() {
  group('VmiBinModelEntityMapper', () {
    test('should correctly map VmiBinModel to VmiBinModelEntity', () {
      // Arrange
      final model = VmiBinModel(
        id: "bin001",
        vmiLocationId: "location001",
        binNumber: "A-001",
        productId: "product123",
        minimumQty: 10.0,
        maximumQty: 100.0,
        lastCountDate: DateTime(2025, 1, 15),
        lastCountQty: 25.0,
        lastCountUserName: "john.doe",
        previousCountDate: DateTime(2025, 1, 1),
        previousCountQty: 30.0,
        previousCountUserName: "jane.smith",
        lastOrderDate: DateTime(2025, 1, 10),
        product: Product(
          id: "product123",
          name: "Test Product",
          productNumber: "P123",
        ),
      );

      // Act
      final result = VmiBinModelEntityMapper.toEntity(model);

      // Assert
      expect(result.id, model.id);
      expect(result.vmiLocationId, model.vmiLocationId);
      expect(result.binNumber, model.binNumber);
      expect(result.productId, model.productId);
      expect(result.minimumQty, model.minimumQty);
      expect(result.maximumQty, model.maximumQty);
      expect(result.lastCountDate, model.lastCountDate);
      expect(result.lastCountQty, model.lastCountQty);
      expect(result.lastCountUserName, model.lastCountUserName);
      expect(result.previousCountDate, model.previousCountDate);
      expect(result.previousCountQty, model.previousCountQty);
      expect(result.previousCountUserName, model.previousCountUserName);
      expect(result.lastOrderDate, model.lastOrderDate);
      expect(result.productEntity, isNotNull);
      expect(result.productEntity?.id, model.product?.id);
      expect(result.productEntity?.name, model.product?.name);
      expect(result.productEntity?.productNumber, model.product?.productNumber);
    });

    test('should correctly map VmiBinModelEntity to VmiBinModel', () {
      // Arrange
      final entity = VmiBinModelEntity(
        id: "bin002",
        vmiLocationId: "location002",
        binNumber: "B-002",
        productId: "product456",
        minimumQty: 5.0,
        maximumQty: 50.0,
        lastCountDate: DateTime(2025, 2, 1),
        lastCountQty: 12.0,
        lastCountUserName: "alice.brown",
        previousCountDate: DateTime(2025, 1, 20),
        previousCountQty: 15.0,
        previousCountUserName: "bob.wilson",
        lastOrderDate: DateTime(2025, 1, 25),
        productEntity: ProductEntity(
          id: "product456",
          name: "Another Product",
          productNumber: "P456",
        ),
      );

      // Act
      final result = VmiBinModelEntityMapper.toModel(entity);

      // Assert
      expect(result.id, entity.id);
      expect(result.vmiLocationId, entity.vmiLocationId);
      expect(result.binNumber, entity.binNumber);
      expect(result.productId, entity.productId);
      expect(result.minimumQty, entity.minimumQty);
      expect(result.maximumQty, entity.maximumQty);
      expect(result.lastCountDate, entity.lastCountDate);
      expect(result.lastCountQty, entity.lastCountQty);
      expect(result.lastCountUserName, entity.lastCountUserName);
      expect(result.previousCountDate, entity.previousCountDate);
      expect(result.previousCountQty, entity.previousCountQty);
      expect(result.previousCountUserName, entity.previousCountUserName);
      expect(result.lastOrderDate, entity.lastOrderDate);
      expect(result.product, isNotNull);
      expect(result.product?.id, entity.productEntity?.id);
      expect(result.product?.name, entity.productEntity?.name);
      expect(
          result.product?.productNumber, entity.productEntity?.productNumber);
    });

    test('should handle null product when mapping to VmiBinModelEntity', () {
      // Arrange
      final model = VmiBinModel(
        id: "bin003",
        vmiLocationId: "location003",
        binNumber: "C-003",
        product: null,
      );

      // Act
      final result = VmiBinModelEntityMapper.toEntity(model);

      // Assert
      expect(result.id, model.id);
      expect(result.vmiLocationId, model.vmiLocationId);
      expect(result.binNumber, model.binNumber);
      expect(result.productEntity, isNull);
    });

    test('should handle null productEntity when mapping to VmiBinModel', () {
      // Arrange
      final entity = VmiBinModelEntity(
        id: "bin004",
        vmiLocationId: "location004",
        binNumber: "D-004",
        productEntity: null,
      );

      // Act
      final result = VmiBinModelEntityMapper.toModel(entity);

      // Assert
      expect(result.id, entity.id);
      expect(result.vmiLocationId, entity.vmiLocationId);
      expect(result.binNumber, entity.binNumber);
      expect(result.product, isNull);
    });

    test(
        'should handle null values correctly when mapping to VmiBinModelEntity',
        () {
      // Arrange
      final model = VmiBinModel(
        id: "bin005",
        vmiLocationId: "location005",
        binNumber: "",
        productId: null,
        minimumQty: null,
        maximumQty: null,
        lastCountDate: null,
        lastCountQty: null,
        lastCountUserName: null,
        previousCountDate: null,
        previousCountQty: null,
        previousCountUserName: null,
        lastOrderDate: null,
        product: null,
      );

      // Act
      final result = VmiBinModelEntityMapper.toEntity(model);

      // Assert
      expect(result.id, model.id);
      expect(result.vmiLocationId, model.vmiLocationId);
      expect(result.binNumber, model.binNumber);
      expect(result.productId, isNull);
      expect(result.minimumQty, isNull);
      expect(result.maximumQty, isNull);
      expect(result.lastCountDate, isNull);
      expect(result.lastCountQty, isNull);
      expect(result.lastCountUserName, isNull);
      expect(result.previousCountDate, isNull);
      expect(result.previousCountQty, isNull);
      expect(result.previousCountUserName, isNull);
      expect(result.lastOrderDate, isNull);
      expect(result.productEntity, isNull);
    });

    test('should handle null values correctly when mapping to VmiBinModel', () {
      // Arrange
      final entity = VmiBinModelEntity(
        id: "bin006",
        vmiLocationId: "location006",
        binNumber: "",
        productId: null,
        minimumQty: null,
        maximumQty: null,
        lastCountDate: null,
        lastCountQty: null,
        lastCountUserName: null,
        previousCountDate: null,
        previousCountQty: null,
        previousCountUserName: null,
        lastOrderDate: null,
        productEntity: null,
      );

      // Act
      final result = VmiBinModelEntityMapper.toModel(entity);

      // Assert
      expect(result.id, entity.id);
      expect(result.vmiLocationId, entity.vmiLocationId);
      expect(result.binNumber, entity.binNumber);
      expect(result.productId, isNull);
      expect(result.minimumQty, isNull);
      expect(result.maximumQty, isNull);
      expect(result.lastCountDate, isNull);
      expect(result.lastCountQty, isNull);
      expect(result.lastCountUserName, isNull);
      expect(result.previousCountDate, isNull);
      expect(result.previousCountQty, isNull);
      expect(result.previousCountUserName, isNull);
      expect(result.lastOrderDate, isNull);
      expect(result.product, isNull);
    });

    test('should handle default binNumber when mapping to VmiBinModelEntity',
        () {
      // Arrange
      final model = VmiBinModel(
        id: "bin007",
        vmiLocationId: "location007",
        // binNumber defaults to empty string in model
      );

      // Act
      final result = VmiBinModelEntityMapper.toEntity(model);

      // Assert
      expect(result.id, model.id);
      expect(result.vmiLocationId, model.vmiLocationId);
      expect(result.binNumber, ""); // Default value
    });

    test('should maintain data integrity in roundtrip conversion', () {
      // Arrange
      final originalModel = VmiBinModel(
        id: "bin999",
        vmiLocationId: "location999",
        binNumber: "Z-999",
        productId: "product999",
        minimumQty: 20.0,
        maximumQty: 200.0,
        lastCountDate: DateTime(2025, 3, 1),
        lastCountQty: 50.0,
        lastCountUserName: "test.user",
        previousCountDate: DateTime(2025, 2, 15),
        previousCountQty: 45.0,
        previousCountUserName: "another.user",
        lastOrderDate: DateTime(2025, 2, 20),
        product: Product(
          id: "product999",
          name: "Roundtrip Product",
          productNumber: "P999",
        ),
      );

      // Act
      final entity = VmiBinModelEntityMapper.toEntity(originalModel);
      final resultModel = VmiBinModelEntityMapper.toModel(entity);

      // Assert
      expect(resultModel.id, originalModel.id);
      expect(resultModel.vmiLocationId, originalModel.vmiLocationId);
      expect(resultModel.binNumber, originalModel.binNumber);
      expect(resultModel.productId, originalModel.productId);
      expect(resultModel.minimumQty, originalModel.minimumQty);
      expect(resultModel.maximumQty, originalModel.maximumQty);
      expect(resultModel.lastCountDate, originalModel.lastCountDate);
      expect(resultModel.lastCountQty, originalModel.lastCountQty);
      expect(resultModel.lastCountUserName, originalModel.lastCountUserName);
      expect(resultModel.previousCountDate, originalModel.previousCountDate);
      expect(resultModel.previousCountQty, originalModel.previousCountQty);
      expect(resultModel.previousCountUserName,
          originalModel.previousCountUserName);
      expect(resultModel.lastOrderDate, originalModel.lastOrderDate);
      expect(resultModel.product?.id, originalModel.product?.id);
      expect(resultModel.product?.name, originalModel.product?.name);
      expect(resultModel.product?.productNumber,
          originalModel.product?.productNumber);
    });

    test('should handle complex Product mapping correctly', () {
      // Arrange
      final productWithComplexData = Product(
        id: "complex123",
        name: "Complex Product",
        productNumber: "CP123",
        sku: "SKU123",
        shortDescription: "A complex product for testing",
        unitOfMeasure: "EA",
      );

      final model = VmiBinModel(
        id: "bin_complex",
        vmiLocationId: "location_complex",
        binNumber: "COMPLEX-001",
        product: productWithComplexData,
      );

      // Act - Test toEntity
      final entity = VmiBinModelEntityMapper.toEntity(model);

      // Assert - Entity mapping
      expect(entity.productEntity, isNotNull);
      expect(entity.productEntity?.id, productWithComplexData.id);
      expect(entity.productEntity?.name, productWithComplexData.name);
      expect(entity.productEntity?.productNumber,
          productWithComplexData.productNumber);

      // Act - Test toModel
      final resultModel = VmiBinModelEntityMapper.toModel(entity);

      // Assert - Model mapping
      expect(resultModel.product, isNotNull);
      expect(resultModel.product?.id, productWithComplexData.id);
      expect(resultModel.product?.name, productWithComplexData.name);
      expect(resultModel.product?.productNumber,
          productWithComplexData.productNumber);
    });
  });
}
