import 'package:commerce_flutter_sdk/src/features/domain/entity/product_unit_of_measure_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/product_unit_of_measure_mapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

void main() {
  group('ProductUnitOfMeasureEntityMapper', () {
    test(
        'should correctly map ProductUnitOfMeasure to ProductUnitOfMeasureEntity',
        () {
      // Arrange
      final productUnitOfMeasure = ProductUnitOfMeasure(
        id: 'UOM123',
        unitOfMeasure: 'EA',
        unitOfMeasureDisplay: 'Each',
        description: 'Each unit',
        qtyPerBaseUnitOfMeasure: 1.0,
        roundingRule: 'round',
        isDefault: true,
      );

      // Act
      final result =
          ProductUnitOfMeasureEntityMapper.toEntity(productUnitOfMeasure);

      // Assert
      expect(result.productUnitOfMeasureId, 'UOM123');
      expect(result.unitOfMeasure, 'EA');
      expect(result.unitOfMeasureDisplay, 'Each');
      expect(result.description, 'Each unit');
      expect(result.qtyPerBaseUnitOfMeasure, 1.0);
      expect(result.roundingRule, 'round');
      expect(result.isDefault, true);
    });

    test(
        'should correctly map ProductUnitOfMeasureEntity to ProductUnitOfMeasure',
        () {
      // Arrange
      const productUnitOfMeasureEntity = ProductUnitOfMeasureEntity(
        productUnitOfMeasureId: 'UOM456',
        unitOfMeasure: 'CS',
        unitOfMeasureDisplay: 'Case',
        description: 'Case of 12',
        qtyPerBaseUnitOfMeasure: 12.0,
        roundingRule: 'ceiling',
        isDefault: false,
      );

      // Act
      final result =
          ProductUnitOfMeasureEntityMapper.toModel(productUnitOfMeasureEntity);

      // Assert
      expect(result.id, 'UOM456');
      expect(result.unitOfMeasure, 'CS');
      expect(result.unitOfMeasureDisplay, 'Case');
      expect(result.description, 'Case of 12');
      expect(result.qtyPerBaseUnitOfMeasure, 12.0);
      expect(result.roundingRule, 'ceiling');
      expect(result.isDefault, false);
    });

    test('should handle all null values correctly', () {
      // Arrange
      final productUnitOfMeasure = ProductUnitOfMeasure(
        id: null,
        unitOfMeasure: null,
        unitOfMeasureDisplay: null,
        description: null,
        qtyPerBaseUnitOfMeasure: null,
        roundingRule: null,
        isDefault: null,
      );

      // Act
      final result =
          ProductUnitOfMeasureEntityMapper.toEntity(productUnitOfMeasure);

      // Assert
      expect(result.productUnitOfMeasureId, isNull);
      expect(result.unitOfMeasure, isNull);
      expect(result.unitOfMeasureDisplay, isNull);
      expect(result.description, isNull);
      expect(result.qtyPerBaseUnitOfMeasure, isNull);
      expect(result.roundingRule, isNull);
      expect(result.isDefault, isNull);
    });

    test('should handle empty strings correctly', () {
      // Arrange
      final productUnitOfMeasure = ProductUnitOfMeasure(
        id: '',
        unitOfMeasure: '',
        unitOfMeasureDisplay: '',
        description: '',
        qtyPerBaseUnitOfMeasure: 0.0,
        roundingRule: '',
        isDefault: false,
      );

      // Act
      final result =
          ProductUnitOfMeasureEntityMapper.toEntity(productUnitOfMeasure);

      // Assert
      expect(result.productUnitOfMeasureId, '');
      expect(result.unitOfMeasure, '');
      expect(result.unitOfMeasureDisplay, '');
      expect(result.description, '');
      expect(result.qtyPerBaseUnitOfMeasure, 0.0);
      expect(result.roundingRule, '');
      expect(result.isDefault, false);
    });

    test('should handle decimal quantities correctly', () {
      // Arrange
      final productUnitOfMeasure = ProductUnitOfMeasure(
        id: 'UOM_DECIMAL',
        unitOfMeasure: 'LB',
        unitOfMeasureDisplay: 'Pound',
        description: 'Per pound',
        qtyPerBaseUnitOfMeasure: 2.5,
        roundingRule: 'round',
        isDefault: false,
      );

      // Act
      final result =
          ProductUnitOfMeasureEntityMapper.toEntity(productUnitOfMeasure);

      // Assert
      expect(result.productUnitOfMeasureId, 'UOM_DECIMAL');
      expect(result.unitOfMeasure, 'LB');
      expect(result.unitOfMeasureDisplay, 'Pound');
      expect(result.description, 'Per pound');
      expect(result.qtyPerBaseUnitOfMeasure, 2.5);
      expect(result.roundingRule, 'round');
      expect(result.isDefault, false);
    });

    test('should perform roundtrip conversion correctly', () {
      // Arrange
      final originalProductUnitOfMeasure = ProductUnitOfMeasure(
        id: 'ROUNDTRIP_UOM',
        unitOfMeasure: 'DZ',
        unitOfMeasureDisplay: 'Dozen',
        description: 'Dozen pieces',
        qtyPerBaseUnitOfMeasure: 12.0,
        roundingRule: 'round',
        isDefault: true,
      );

      // Act
      final entity = ProductUnitOfMeasureEntityMapper.toEntity(
          originalProductUnitOfMeasure);
      final convertedBack = ProductUnitOfMeasureEntityMapper.toModel(entity);

      // Assert
      expect(convertedBack.id, originalProductUnitOfMeasure.id);
      expect(convertedBack.unitOfMeasure,
          originalProductUnitOfMeasure.unitOfMeasure);
      expect(convertedBack.unitOfMeasureDisplay,
          originalProductUnitOfMeasure.unitOfMeasureDisplay);
      expect(
          convertedBack.description, originalProductUnitOfMeasure.description);
      expect(convertedBack.qtyPerBaseUnitOfMeasure,
          originalProductUnitOfMeasure.qtyPerBaseUnitOfMeasure);
      expect(convertedBack.roundingRule,
          originalProductUnitOfMeasure.roundingRule);
      expect(convertedBack.isDefault, originalProductUnitOfMeasure.isDefault);
    });

    test('should handle large quantity values', () {
      // Arrange
      final productUnitOfMeasure = ProductUnitOfMeasure(
        id: 'LARGE_QTY_UOM',
        unitOfMeasure: 'PALLET',
        unitOfMeasureDisplay: 'Pallet',
        description: 'Full pallet',
        qtyPerBaseUnitOfMeasure: 1000.0,
        roundingRule: 'round',
        isDefault: false,
      );

      // Act
      final result =
          ProductUnitOfMeasureEntityMapper.toEntity(productUnitOfMeasure);

      // Assert
      expect(result.productUnitOfMeasureId, 'LARGE_QTY_UOM');
      expect(result.unitOfMeasure, 'PALLET');
      expect(result.unitOfMeasureDisplay, 'Pallet');
      expect(result.description, 'Full pallet');
      expect(result.qtyPerBaseUnitOfMeasure, 1000.0);
      expect(result.roundingRule, 'round');
      expect(result.isDefault, false);
    });

    test('should handle Unicode characters in descriptions', () {
      // Arrange
      final productUnitOfMeasure = ProductUnitOfMeasure(
        id: 'UNICODE_UOM',
        unitOfMeasure: 'KG',
        unitOfMeasureDisplay: 'Kilogram',
        description: 'Kilogramme (français)',
        qtyPerBaseUnitOfMeasure: 1.0,
        roundingRule: 'round',
        isDefault: false,
      );

      // Act
      final result =
          ProductUnitOfMeasureEntityMapper.toEntity(productUnitOfMeasure);

      // Assert
      expect(result.productUnitOfMeasureId, 'UNICODE_UOM');
      expect(result.unitOfMeasure, 'KG');
      expect(result.unitOfMeasureDisplay, 'Kilogram');
      expect(result.description, 'Kilogramme (français)');
      expect(result.qtyPerBaseUnitOfMeasure, 1.0);
      expect(result.roundingRule, 'round');
      expect(result.isDefault, false);
    });
  });
}
