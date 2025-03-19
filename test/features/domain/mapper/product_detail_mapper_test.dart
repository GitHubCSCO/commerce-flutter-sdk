import 'package:commerce_flutter_app/features/domain/entity/product_detail_entity.dart';
import 'package:commerce_flutter_app/features/domain/mapper/product_detail_mapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

void main() {
  group('ProductDetailEntityMapper', () {
    test('toEntity should map ProductDetail to ProductDetailEntity', () {
      // Arrange
      final model = ProductDetail(
        name: 'Test Product',
        modelNumber: 'MODEL123',
        sku: 'SKU123',
        upcCode: 'UPC123',
        unspsc: 'UNSPSC123',
        productCode: 'PROD123',
        priceCode: 'PRICE123',
        sortOrder: 1,
        multipleSaleQty: 5,
        canBackOrder: true,
        roundingRule: 'ROUND',
        replacementProductId: 'REPL123',
        isHazardousGood: true,
        hasMsds: true,
        isSpecialOrder: false,
        isGiftCard: false,
        allowAnyGiftCardAmount: false,
        taxCode1: 'TAX1',
        taxCode2: 'TAX2',
        taxCategory: 'TAXCAT',
        vatCodeId: 'VAT123',
        shippingClassification: 'SHIP-CLASS',
        shippingLength: 10.5,
        shippingWidth: 5.5,
        shippingHeight: 3.5,
        shippingWeight: 2.5,
        configuration: LegacyConfiguration(),
      );

      // Act
      final entity = ProductDetailEntityMapper.toEntity(model);

      // Assert
      expect(entity.name, equals(model.name));
      expect(entity.modelNumber, equals(model.modelNumber));
      expect(entity.sku, equals(model.sku));
      expect(entity.upcCode, equals(model.upcCode));
      expect(entity.unspsc, equals(model.unspsc));
      expect(entity.productCode, equals(model.productCode));
      expect(entity.priceCode, equals(model.priceCode));
      expect(entity.sortOrder, equals(model.sortOrder));
      expect(entity.multipleSaleQty, equals(model.multipleSaleQty));
      expect(entity.canBackOrder, equals(model.canBackOrder));
      expect(entity.roundingRule, equals(model.roundingRule));
      expect(entity.replacementProductId, equals(model.replacementProductId));
      expect(entity.isHazardousGood, equals(model.isHazardousGood));
      expect(entity.hasMsds, equals(model.hasMsds));
      expect(entity.isSpecialOrder, equals(model.isSpecialOrder));
      expect(entity.isGiftCard, equals(model.isGiftCard));
      expect(
          entity.allowAnyGiftCardAmount, equals(model.allowAnyGiftCardAmount));
      expect(entity.taxCode1, equals(model.taxCode1));
      expect(entity.taxCode2, equals(model.taxCode2));
      expect(entity.taxCategory, equals(model.taxCategory));
      expect(entity.vatCodeId, equals(model.vatCodeId));
      expect(
          entity.shippingClassification, equals(model.shippingClassification));
      expect(entity.shippingLength, equals(model.shippingLength));
      expect(entity.shippingWidth, equals(model.shippingWidth));
      expect(entity.shippingHeight, equals(model.shippingHeight));
      expect(entity.shippingWeight, equals(model.shippingWeight));
      expect(entity.configuration, isNotNull);
    });

    test('toEntity should handle null ProductDetail', () {
      // Act
      final entity = ProductDetailEntityMapper.toEntity(null);

      // Assert
      expect(entity.name, isNull);
      expect(entity.modelNumber, isNull);
      expect(entity.sku, isNull);
      expect(entity.upcCode, isNull);
      expect(entity.unspsc, isNull);
      expect(entity.configuration,
          isNotNull); // Default LegacyConfiguration is created
    });

    test('toEntity should handle ProductDetail with null properties', () {
      // Arrange
      final model = ProductDetail();

      // Act
      final entity = ProductDetailEntityMapper.toEntity(model);

      // Assert
      expect(entity.name, isNull);
      expect(entity.modelNumber, isNull);
      expect(entity.sku, isNull);
      expect(entity.upcCode, isNull);
      expect(entity.unspsc, isNull);
      expect(entity.productCode, isNull);
      expect(entity.priceCode, isNull);
      expect(entity.sortOrder, isNull);
      expect(entity.multipleSaleQty, isNull);
      expect(entity.canBackOrder, isNull);
      expect(entity.roundingRule, isNull);
      expect(entity.replacementProductId, isNull);
      expect(entity.isHazardousGood, isNull);
      expect(entity.hasMsds, isNull);
      expect(entity.isSpecialOrder, isNull);
      expect(entity.isGiftCard, isNull);
      expect(entity.allowAnyGiftCardAmount, isNull);
      expect(entity.taxCode1, isNull);
      expect(entity.taxCode2, isNull);
      expect(entity.taxCategory, isNull);
      expect(entity.vatCodeId, isNull);
      expect(entity.shippingClassification, isNull);
      expect(entity.shippingLength, isNull);
      expect(entity.shippingWidth, isNull);
      expect(entity.shippingHeight, isNull);
      expect(entity.shippingWeight, isNull);
      expect(entity.configuration,
          isNotNull); // Default LegacyConfiguration is created
    });

    test('toModel should map ProductDetailEntity to ProductDetail', () {
      // Arrange
      const entity = ProductDetailEntity(
        name: 'Test Product',
        modelNumber: 'MODEL123',
        sku: 'SKU123',
        upcCode: 'UPC123',
        unspsc: 'UNSPSC123',
        productCode: 'PROD123',
        priceCode: 'PRICE123',
        sortOrder: 1,
        multipleSaleQty: 5,
        canBackOrder: true,
        roundingRule: 'ROUND',
        replacementProductId: 'REPL123',
        isHazardousGood: true,
        hasMsds: true,
        isSpecialOrder: false,
        isGiftCard: false,
        allowAnyGiftCardAmount: false,
        taxCode1: 'TAX1',
        taxCode2: 'TAX2',
        taxCategory: 'TAXCAT',
        vatCodeId: 'VAT123',
        shippingClassification: 'SHIP-CLASS',
        shippingLength: 10.5,
        shippingWidth: 5.5,
        shippingHeight: 3.5,
        shippingWeight: 2.5,
      );

      // Act
      final model = ProductDetailEntityMapper.toModel(entity);

      // Assert
      expect(model?.name, equals(entity.name));
      expect(model?.modelNumber, equals(entity.modelNumber));
      expect(model?.sku, equals(entity.sku));
      expect(model?.upcCode, equals(entity.upcCode));
      expect(model?.unspsc, equals(entity.unspsc));
      expect(model?.productCode, equals(entity.productCode));
      expect(model?.priceCode, equals(entity.priceCode));
      expect(model?.sortOrder, equals(entity.sortOrder));
      expect(model?.multipleSaleQty, equals(entity.multipleSaleQty));
      expect(model?.canBackOrder, equals(entity.canBackOrder));
      expect(model?.roundingRule, equals(entity.roundingRule));
      expect(model?.replacementProductId, equals(entity.replacementProductId));
      expect(model?.isHazardousGood, equals(entity.isHazardousGood));
      expect(model?.hasMsds, equals(entity.hasMsds));
      expect(model?.isSpecialOrder, equals(entity.isSpecialOrder));
      expect(model?.isGiftCard, equals(entity.isGiftCard));
      expect(
          model?.allowAnyGiftCardAmount, equals(entity.allowAnyGiftCardAmount));
      expect(model?.taxCode1, equals(entity.taxCode1));
      expect(model?.taxCode2, equals(entity.taxCode2));
      expect(model?.taxCategory, equals(entity.taxCategory));
      expect(model?.vatCodeId, equals(entity.vatCodeId));
      expect(
          model?.shippingClassification, equals(entity.shippingClassification));
      expect(model?.shippingLength, equals(entity.shippingLength));
      expect(model?.shippingWidth, equals(entity.shippingWidth));
      expect(model?.shippingHeight, equals(entity.shippingHeight));
      expect(model?.shippingWeight, equals(entity.shippingWeight));
    });

    test('toModel should handle ProductDetailEntity with null properties', () {
      // Arrange
      const entity = ProductDetailEntity();

      // Act
      final model = ProductDetailEntityMapper.toModel(entity);

      // Assert
      expect(model?.name, isNull);
      expect(model?.modelNumber, isNull);
      expect(model?.sku, isNull);
      expect(model?.upcCode, isNull);
      expect(model?.unspsc, isNull);
      expect(model?.productCode, isNull);
      expect(model?.priceCode, isNull);
      expect(model?.sortOrder, isNull);
      expect(model?.multipleSaleQty, isNull);
      expect(model?.canBackOrder, isNull);
      expect(model?.roundingRule, isNull);
      expect(model?.replacementProductId, isNull);
      expect(model?.isHazardousGood, isNull);
      expect(model?.hasMsds, isNull);
      expect(model?.isSpecialOrder, isNull);
      expect(model?.isGiftCard, isNull);
      expect(model?.allowAnyGiftCardAmount, isNull);
      expect(model?.taxCode1, isNull);
      expect(model?.taxCode2, isNull);
      expect(model?.taxCategory, isNull);
      expect(model?.vatCodeId, isNull);
      expect(model?.shippingClassification, isNull);
      expect(model?.shippingLength, isNull);
      expect(model?.shippingWidth, isNull);
      expect(model?.shippingHeight, isNull);
      expect(model?.shippingWeight, isNull);
    });

    test('roundtrip conversion preserves all data', () {
      // Arrange
      final originalModel = ProductDetail(
        name: 'Test Product',
        modelNumber: 'MODEL123',
        sku: 'SKU123',
        upcCode: 'UPC123',
        unspsc: 'UNSPSC123',
        productCode: 'PROD123',
        priceCode: 'PRICE123',
        sortOrder: 1,
        multipleSaleQty: 5,
        canBackOrder: true,
        roundingRule: 'ROUND',
        replacementProductId: 'REPL123',
        isHazardousGood: true,
        hasMsds: true,
        isSpecialOrder: false,
        isGiftCard: false,
        allowAnyGiftCardAmount: false,
        taxCode1: 'TAX1',
        taxCode2: 'TAX2',
        taxCategory: 'TAXCAT',
        vatCodeId: 'VAT123',
        shippingClassification: 'SHIP-CLASS',
        shippingLength: 10.5,
        shippingWidth: 5.5,
        shippingHeight: 3.5,
        shippingWeight: 2.5,
        configuration: LegacyConfiguration(),
      );

      // Act
      final entity = ProductDetailEntityMapper.toEntity(originalModel);
      final resultModel = ProductDetailEntityMapper.toModel(entity);

      // Assert
      expect(resultModel?.name, equals(originalModel.name));
      expect(resultModel?.modelNumber, equals(originalModel.modelNumber));
      expect(resultModel?.sku, equals(originalModel.sku));
      expect(resultModel?.upcCode, equals(originalModel.upcCode));
      expect(resultModel?.unspsc, equals(originalModel.unspsc));
      expect(resultModel?.productCode, equals(originalModel.productCode));
      expect(resultModel?.priceCode, equals(originalModel.priceCode));
      expect(resultModel?.sortOrder, equals(originalModel.sortOrder));
      expect(
          resultModel?.multipleSaleQty, equals(originalModel.multipleSaleQty));
      expect(resultModel?.canBackOrder, equals(originalModel.canBackOrder));
      expect(resultModel?.roundingRule, equals(originalModel.roundingRule));
      expect(resultModel?.replacementProductId,
          equals(originalModel.replacementProductId));
      expect(
          resultModel?.isHazardousGood, equals(originalModel.isHazardousGood));
      expect(resultModel?.hasMsds, equals(originalModel.hasMsds));
      expect(resultModel?.isSpecialOrder, equals(originalModel.isSpecialOrder));
      expect(resultModel?.isGiftCard, equals(originalModel.isGiftCard));
      expect(resultModel?.allowAnyGiftCardAmount,
          equals(originalModel.allowAnyGiftCardAmount));
      expect(resultModel?.taxCode1, equals(originalModel.taxCode1));
      expect(resultModel?.taxCode2, equals(originalModel.taxCode2));
      expect(resultModel?.taxCategory, equals(originalModel.taxCategory));
      expect(resultModel?.vatCodeId, equals(originalModel.vatCodeId));
      expect(resultModel?.shippingClassification,
          equals(originalModel.shippingClassification));
      expect(resultModel?.shippingLength, equals(originalModel.shippingLength));
      expect(resultModel?.shippingWidth, equals(originalModel.shippingWidth));
      expect(resultModel?.shippingHeight, equals(originalModel.shippingHeight));
      expect(resultModel?.shippingWeight, equals(originalModel.shippingWeight));
    });
  });
}
