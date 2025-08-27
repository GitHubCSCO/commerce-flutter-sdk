import 'package:commerce_flutter_sdk/src/features/domain/entity/availability_entity.dart';
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
        productUnitOfMeasureId: 'UOM123',
        unitOfMeasure: 'EA',
        unitOfMeasureDisplay: 'Each',
        description: 'Each unit',
        qtyPerBaseUnitOfMeasure: 1.0,
        roundingRule: 'round',
        isDefault: true,
        availability: Availability(
          messageType: 1,
          message: 'In Stock',
        ),
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
      expect(result.availability, isNotNull);
      expect(result.availability?.messageType, 1);
      expect(result.availability?.message, 'In Stock');
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
        availability: AvailabilityEntity(
          messageType: 2,
          message: 'Out of Stock',
        ),
      );

      // Act
      final result =
          ProductUnitOfMeasureEntityMapper.toModel(productUnitOfMeasureEntity);

      // Assert
      expect(result.productUnitOfMeasureId, 'UOM456');
      expect(result.unitOfMeasure, 'CS');
      expect(result.unitOfMeasureDisplay, 'Case');
      expect(result.description, 'Case of 12');
      expect(result.qtyPerBaseUnitOfMeasure, 12.0);
      expect(result.roundingRule, 'ceiling');
      expect(result.isDefault, false);
      expect(result.availability, isNotNull);
      expect(result.availability?.messageType, 2);
      expect(result.availability?.message, 'Out of Stock');
    });

    test('should handle null availability in ProductUnitOfMeasure', () {
      // Arrange
      final productUnitOfMeasure = ProductUnitOfMeasure(
        productUnitOfMeasureId: 'UOM789',
        unitOfMeasure: 'BX',
        unitOfMeasureDisplay: 'Box',
        description: 'Box of 24',
        qtyPerBaseUnitOfMeasure: 24.0,
        roundingRule: 'floor',
        isDefault: false,
        availability: null,
      );

      // Act
      final result =
          ProductUnitOfMeasureEntityMapper.toEntity(productUnitOfMeasure);

      // Assert
      expect(result.productUnitOfMeasureId, 'UOM789');
      expect(result.unitOfMeasure, 'BX');
      expect(result.unitOfMeasureDisplay, 'Box');
      expect(result.description, 'Box of 24');
      expect(result.qtyPerBaseUnitOfMeasure, 24.0);
      expect(result.roundingRule, 'floor');
      expect(result.isDefault, false);
      expect(
          result.availability, isNotNull); // Should create default Availability
    });

    test('should handle null availability in ProductUnitOfMeasureEntity', () {
      // Arrange
      const productUnitOfMeasureEntity = ProductUnitOfMeasureEntity(
        productUnitOfMeasureId: 'UOM999',
        unitOfMeasure: 'PK',
        unitOfMeasureDisplay: 'Pack',
        description: 'Pack of 6',
        qtyPerBaseUnitOfMeasure: 6.0,
        roundingRule: 'truncate',
        isDefault: true,
        availability: null,
      );

      // Act
      final result =
          ProductUnitOfMeasureEntityMapper.toModel(productUnitOfMeasureEntity);

      // Assert
      expect(result.productUnitOfMeasureId, 'UOM999');
      expect(result.unitOfMeasure, 'PK');
      expect(result.unitOfMeasureDisplay, 'Pack');
      expect(result.description, 'Pack of 6');
      expect(result.qtyPerBaseUnitOfMeasure, 6.0);
      expect(result.roundingRule, 'truncate');
      expect(result.isDefault, true);
      expect(result.availability,
          isNotNull); // Should create default AvailabilityEntity
    });

    test('should handle all null values correctly', () {
      // Arrange
      final productUnitOfMeasure = ProductUnitOfMeasure(
        productUnitOfMeasureId: null,
        unitOfMeasure: null,
        unitOfMeasureDisplay: null,
        description: null,
        qtyPerBaseUnitOfMeasure: null,
        roundingRule: null,
        isDefault: null,
        availability: null,
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
      expect(result.availability,
          isNotNull); // Should still create default availability
    });

    test('should handle empty strings correctly', () {
      // Arrange
      final productUnitOfMeasure = ProductUnitOfMeasure(
        productUnitOfMeasureId: '',
        unitOfMeasure: '',
        unitOfMeasureDisplay: '',
        description: '',
        qtyPerBaseUnitOfMeasure: 0.0,
        roundingRule: '',
        isDefault: false,
        availability: Availability(
          messageType: 0,
          message: '',
        ),
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
      expect(result.availability, isNotNull);
      expect(result.availability?.messageType, 0);
      expect(result.availability?.message, '');
    });

    test('should handle decimal quantities correctly', () {
      // Arrange
      final productUnitOfMeasure = ProductUnitOfMeasure(
        productUnitOfMeasureId: 'UOM_DECIMAL',
        unitOfMeasure: 'LB',
        unitOfMeasureDisplay: 'Pound',
        description: 'Per pound',
        qtyPerBaseUnitOfMeasure: 2.5,
        roundingRule: 'round',
        isDefault: false,
        availability: Availability(
          messageType: 1,
          message: 'Available',
        ),
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
      expect(result.availability, isNotNull);
    });

    test('should perform roundtrip conversion correctly', () {
      // Arrange
      final originalProductUnitOfMeasure = ProductUnitOfMeasure(
        productUnitOfMeasureId: 'ROUNDTRIP_UOM',
        unitOfMeasure: 'DZ',
        unitOfMeasureDisplay: 'Dozen',
        description: 'Dozen pieces',
        qtyPerBaseUnitOfMeasure: 12.0,
        roundingRule: 'round',
        isDefault: true,
        availability: Availability(
          messageType: 1,
          message: 'In Stock',
        ),
      );

      // Act
      final entity = ProductUnitOfMeasureEntityMapper.toEntity(
          originalProductUnitOfMeasure);
      final convertedBack = ProductUnitOfMeasureEntityMapper.toModel(entity);

      // Assert
      expect(convertedBack.productUnitOfMeasureId,
          originalProductUnitOfMeasure.productUnitOfMeasureId);
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
      expect(convertedBack.availability?.messageType,
          originalProductUnitOfMeasure.availability?.messageType);
      expect(convertedBack.availability?.message,
          originalProductUnitOfMeasure.availability?.message);
    });

    test('should handle complex availability scenarios', () {
      // Arrange
      final productUnitOfMeasure = ProductUnitOfMeasure(
        productUnitOfMeasureId: 'COMPLEX_UOM',
        unitOfMeasure: 'M',
        unitOfMeasureDisplay: 'Meter',
        description: 'Linear meter',
        qtyPerBaseUnitOfMeasure: 1.0,
        roundingRule: 'round',
        isDefault: false,
        availability: Availability(
          messageType: 3,
          message: 'Backordered - Ships in 2 weeks',
        ),
      );

      // Act
      final result =
          ProductUnitOfMeasureEntityMapper.toEntity(productUnitOfMeasure);

      // Assert
      expect(result.productUnitOfMeasureId, 'COMPLEX_UOM');
      expect(result.unitOfMeasure, 'M');
      expect(result.unitOfMeasureDisplay, 'Meter');
      expect(result.description, 'Linear meter');
      expect(result.qtyPerBaseUnitOfMeasure, 1.0);
      expect(result.roundingRule, 'round');
      expect(result.isDefault, false);
      expect(result.availability, isNotNull);
      expect(result.availability?.messageType, 3);
      expect(result.availability?.message, 'Backordered - Ships in 2 weeks');
    });

    test('should handle large quantity values', () {
      // Arrange
      final productUnitOfMeasure = ProductUnitOfMeasure(
        productUnitOfMeasureId: 'LARGE_QTY_UOM',
        unitOfMeasure: 'PALLET',
        unitOfMeasureDisplay: 'Pallet',
        description: 'Full pallet',
        qtyPerBaseUnitOfMeasure: 1000.0,
        roundingRule: 'round',
        isDefault: false,
        availability: Availability(
          messageType: 1,
          message: 'Special order',
        ),
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
      expect(result.availability, isNotNull);
      expect(result.availability?.messageType, 1);
      expect(result.availability?.message, 'Special order');
    });

    test('should handle Unicode characters in descriptions', () {
      // Arrange
      final productUnitOfMeasure = ProductUnitOfMeasure(
        productUnitOfMeasureId: 'UNICODE_UOM',
        unitOfMeasure: 'KG',
        unitOfMeasureDisplay: 'Kilogram',
        description: 'Kilogramme (français) 🏷️',
        qtyPerBaseUnitOfMeasure: 1.0,
        roundingRule: 'round',
        isDefault: false,
        availability: Availability(
          messageType: 1,
          message: 'Disponible immédiatement ✅',
        ),
      );

      // Act
      final result =
          ProductUnitOfMeasureEntityMapper.toEntity(productUnitOfMeasure);

      // Assert
      expect(result.productUnitOfMeasureId, 'UNICODE_UOM');
      expect(result.unitOfMeasure, 'KG');
      expect(result.unitOfMeasureDisplay, 'Kilogram');
      expect(result.description, 'Kilogramme (français) 🏷️');
      expect(result.qtyPerBaseUnitOfMeasure, 1.0);
      expect(result.roundingRule, 'round');
      expect(result.isDefault, false);
      expect(result.availability, isNotNull);
      expect(result.availability?.messageType, 1);
      expect(result.availability?.message, 'Disponible immédiatement ✅');
    });
  });
}
