import 'package:commerce_flutter_app/features/domain/entity/break_price_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_price_entity.dart';
import 'package:commerce_flutter_app/features/domain/mapper/product_price_mapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

void main() {
  group('ProductPriceEntityMapper', () {
    test('toEntity should convert model to entity with all properties', () {
      // Arrange
      final model = ProductPrice(
        productId: 'product123',
        isOnSale: true,
        requiresRealTimePrice: false,
        quoteRequired: false,
        additionalResults: {'discountType': 'holiday'},
        unitCost: 10.50,
        unitCostDisplay: '\$10.50',
        unitListPrice: 19.99,
        unitListPriceDisplay: '\$19.99',
        extendedUnitListPrice: 99.95,
        extendedUnitListPriceDisplay: '\$99.95',
        unitRegularPrice: 15.99,
        unitRegularPriceDisplay: '\$15.99',
        extendedUnitRegularPrice: 79.95,
        extendedUnitRegularPriceDisplay: '\$79.95',
        unitNetPrice: 14.99,
        unitNetPriceDisplay: '\$14.99',
        extendedUnitNetPrice: 74.95,
        extendedUnitNetPriceDisplay: '\$74.95',
        unitOfMeasure: 'EA',
        vatRate: 0.20,
        vatAmount: 2.99,
        vatAmountDisplay: '\$2.99',
        unitListBreakPrices: [
          BreakPriceDto(
              breakQty: 10, breakPrice: 18.99, breakPriceDisplay: '\$18.99')
        ],
        unitRegularBreakPrices: [
          BreakPriceDto(
              breakQty: 10, breakPrice: 14.99, breakPriceDisplay: '\$14.99')
        ],
        regularPrice: 15.99,
        regularPriceDisplay: '\$15.99',
        extendedRegularPrice: 79.95,
        extendedRegularPriceDisplay: '\$79.95',
        actualPrice: 14.99,
        actualPriceDisplay: '\$14.99',
        extendedActualPrice: 74.95,
        extendedActualPriceDisplay: '\$74.95',
        regularBreakPrices: [
          BreakPriceDto(
              breakQty: 10, breakPrice: 14.99, breakPriceDisplay: '\$14.99')
        ],
        actualBreakPrices: [
          BreakPriceDto(
              breakQty: 10, breakPrice: 13.99, breakPriceDisplay: '\$13.99')
        ],
      );

      // Act
      final entity = ProductPriceEntityMapper.toEntity(model);

      // Assert
      expect(entity.productId, equals(model.productId));
      expect(entity.isOnSale, equals(model.isOnSale));
      expect(entity.requiresRealTimePrice, equals(model.requiresRealTimePrice));
      expect(entity.quoteRequired, equals(model.quoteRequired));
      expect(entity.additionalResults, equals(model.additionalResults));
      expect(entity.unitCost, equals(model.unitCost));
      expect(entity.unitCostDisplay, equals(model.unitCostDisplay));
      expect(entity.unitListPrice, equals(model.unitListPrice));
      expect(entity.unitListPriceDisplay, equals(model.unitListPriceDisplay));
      expect(entity.extendedUnitListPrice, equals(model.extendedUnitListPrice));
      expect(entity.extendedUnitListPriceDisplay,
          equals(model.extendedUnitListPriceDisplay));
      expect(entity.unitRegularPrice, equals(model.unitRegularPrice));
      expect(entity.unitRegularPriceDisplay,
          equals(model.unitRegularPriceDisplay));
      expect(entity.extendedUnitRegularPrice,
          equals(model.extendedUnitRegularPrice));
      expect(entity.extendedUnitRegularPriceDisplay,
          equals(model.extendedUnitRegularPriceDisplay));
      expect(entity.unitNetPrice, equals(model.unitNetPrice));
      expect(entity.unitNetPriceDisplay, equals(model.unitNetPriceDisplay));
      expect(entity.extendedUnitNetPrice, equals(model.extendedUnitNetPrice));
      expect(entity.extendedUnitNetPriceDisplay,
          equals(model.extendedUnitNetPriceDisplay));
      expect(entity.unitOfMeasure, equals(model.unitOfMeasure));
      expect(entity.vatRate, equals(model.vatRate));
      expect(entity.vatAmount, equals(model.vatAmount));
      expect(entity.vatAmountDisplay, equals(model.vatAmountDisplay));

      // Check break prices collections
      expect(entity.unitListBreakPrices?.length, equals(1));
      expect(entity.unitListBreakPrices?[0].breakQty, equals(10));
      expect(entity.unitListBreakPrices?[0].breakPrice, equals(18.99));

      expect(entity.unitRegularBreakPrices?.length, equals(1));
      expect(entity.unitRegularBreakPrices?[0].breakQty, equals(10));

      expect(entity.regularPrice, equals(model.regularPrice));
      expect(entity.regularPriceDisplay, equals(model.regularPriceDisplay));
      expect(entity.extendedRegularPrice, equals(model.extendedRegularPrice));
      expect(entity.extendedRegularPriceDisplay,
          equals(model.extendedRegularPriceDisplay));
      expect(entity.actualPrice, equals(model.actualPrice));
      expect(entity.actualPriceDisplay, equals(model.actualPriceDisplay));
      expect(entity.extendedActualPrice, equals(model.extendedActualPrice));
      expect(entity.extendedActualPriceDisplay,
          equals(model.extendedActualPriceDisplay));

      expect(entity.regularBreakPrices?.length, equals(1));
      expect(entity.regularBreakPrices?[0].breakPrice, equals(14.99));

      expect(entity.actualBreakPrices?.length, equals(1));
      expect(entity.actualBreakPrices?[0].breakPrice, equals(13.99));
    });

    test('toEntity should handle null model', () {
      // Act
      final entity = ProductPriceEntityMapper.toEntity(null);

      // Assert
      expect(entity.productId, isNull);
      expect(entity.isOnSale, isNull);
      expect(entity.unitListPrice, isNull);
      expect(entity.unitNetPrice, isNull);
      expect(entity.unitListBreakPrices, isNull);
      expect(entity.regularBreakPrices, isNull);
      expect(entity.actualBreakPrices, isNull);
    });

    test('toEntity should handle model with null properties', () {
      // Arrange
      final model = ProductPrice();

      // Act
      final entity = ProductPriceEntityMapper.toEntity(model);

      // Assert
      expect(entity.productId, isNull);
      expect(entity.isOnSale, isNull);
      expect(entity.unitListPrice, isNull);
      expect(entity.unitNetPrice, isNull);
      expect(entity.unitListBreakPrices, isNull);
      expect(entity.regularBreakPrices, isNull);
      expect(entity.actualBreakPrices, isNull);
    });

    test('toEntity should handle model with empty break price collections', () {
      // Arrange
      final model = ProductPrice(
        productId: 'product456',
        unitListBreakPrices: [],
        unitRegularBreakPrices: [],
        regularBreakPrices: [],
        actualBreakPrices: [],
      );

      // Act
      final entity = ProductPriceEntityMapper.toEntity(model);

      // Assert
      expect(entity.productId, equals('product456'));
      expect(entity.unitListBreakPrices, isEmpty);
      expect(entity.unitRegularBreakPrices, isEmpty);
      expect(entity.regularBreakPrices, isEmpty);
      expect(entity.actualBreakPrices, isEmpty);
    });

    test('toModel should convert entity to model with all properties', () {
      // Arrange
      final entity = ProductPriceEntity(
        productId: 'product123',
        isOnSale: true,
        requiresRealTimePrice: false,
        quoteRequired: false,
        additionalResults: {'discountType': 'holiday'},
        unitCost: 10.50,
        unitCostDisplay: '\$10.50',
        unitListPrice: 19.99,
        unitListPriceDisplay: '\$19.99',
        extendedUnitListPrice: 99.95,
        extendedUnitListPriceDisplay: '\$99.95',
        unitRegularPrice: 15.99,
        unitRegularPriceDisplay: '\$15.99',
        extendedUnitRegularPrice: 79.95,
        extendedUnitRegularPriceDisplay: '\$79.95',
        unitNetPrice: 14.99,
        unitNetPriceDisplay: '\$14.99',
        extendedUnitNetPrice: 74.95,
        extendedUnitNetPriceDisplay: '\$74.95',
        unitOfMeasure: 'EA',
        vatRate: 0.20,
        vatAmount: 2.99,
        vatAmountDisplay: '\$2.99',
        unitListBreakPrices: [
          BreakPriceDTOEntity(
              breakQty: 10, breakPrice: 18.99, breakPriceDisplay: '\$18.99')
        ],
        unitRegularBreakPrices: [
          BreakPriceDTOEntity(
              breakQty: 10, breakPrice: 14.99, breakPriceDisplay: '\$14.99')
        ],
        regularPrice: 15.99,
        regularPriceDisplay: '\$15.99',
        extendedRegularPrice: 79.95,
        extendedRegularPriceDisplay: '\$79.95',
        actualPrice: 14.99,
        actualPriceDisplay: '\$14.99',
        extendedActualPrice: 74.95,
        extendedActualPriceDisplay: '\$74.95',
        regularBreakPrices: [
          BreakPriceDTOEntity(
              breakQty: 10, breakPrice: 14.99, breakPriceDisplay: '\$14.99')
        ],
        actualBreakPrices: [
          BreakPriceDTOEntity(
              breakQty: 10, breakPrice: 13.99, breakPriceDisplay: '\$13.99')
        ],
      );

      // Act
      final model = ProductPriceEntityMapper.toModel(entity);

      // Assert
      expect(model.productId, equals(entity.productId));
      expect(model.isOnSale, equals(entity.isOnSale));
      expect(model.requiresRealTimePrice, equals(entity.requiresRealTimePrice));
      expect(model.quoteRequired, equals(entity.quoteRequired));
      expect(model.additionalResults, equals(entity.additionalResults));
      expect(model.unitCost, equals(entity.unitCost));
      expect(model.unitCostDisplay, equals(entity.unitCostDisplay));
      expect(model.unitListPrice, equals(entity.unitListPrice));
      expect(model.unitListPriceDisplay, equals(entity.unitListPriceDisplay));
      expect(model.extendedUnitListPrice, equals(entity.extendedUnitListPrice));
      expect(model.extendedUnitListPriceDisplay,
          equals(entity.extendedUnitListPriceDisplay));
      expect(model.unitRegularPrice, equals(entity.unitRegularPrice));
      expect(model.unitRegularPriceDisplay,
          equals(entity.unitRegularPriceDisplay));
      expect(model.extendedUnitRegularPrice,
          equals(entity.extendedUnitRegularPrice));
      expect(model.extendedUnitRegularPriceDisplay,
          equals(entity.extendedUnitRegularPriceDisplay));
      expect(model.unitNetPrice, equals(entity.unitNetPrice));
      expect(model.unitNetPriceDisplay, equals(entity.unitNetPriceDisplay));
      expect(model.extendedUnitNetPrice, equals(entity.extendedUnitNetPrice));
      expect(model.extendedUnitNetPriceDisplay,
          equals(entity.extendedUnitNetPriceDisplay));
      expect(model.unitOfMeasure, equals(entity.unitOfMeasure));
      expect(model.vatRate, equals(entity.vatRate));
      expect(model.vatAmount, equals(entity.vatAmount));
      expect(model.vatAmountDisplay, equals(entity.vatAmountDisplay));

      // Check break prices collections
      expect(model.unitListBreakPrices?.length, equals(1));
      expect(model.unitListBreakPrices?[0].breakQty, equals(10));
      expect(model.unitListBreakPrices?[0].breakPrice, equals(18.99));

      expect(model.unitRegularBreakPrices?.length, equals(1));
      expect(model.unitRegularBreakPrices?[0].breakQty, equals(10));

      expect(model.regularPrice, equals(entity.regularPrice));
      expect(model.regularPriceDisplay, equals(entity.regularPriceDisplay));
      expect(model.extendedRegularPrice, equals(entity.extendedRegularPrice));
      expect(model.extendedRegularPriceDisplay,
          equals(entity.extendedRegularPriceDisplay));
      expect(model.actualPrice, equals(entity.actualPrice));
      expect(model.actualPriceDisplay, equals(entity.actualPriceDisplay));
      expect(model.extendedActualPrice, equals(entity.extendedActualPrice));
      expect(model.extendedActualPriceDisplay,
          equals(entity.extendedActualPriceDisplay));

      expect(model.regularBreakPrices?.length, equals(1));
      expect(model.regularBreakPrices?[0].breakPrice, equals(14.99));

      expect(model.actualBreakPrices?.length, equals(1));
      expect(model.actualBreakPrices?[0].breakPrice, equals(13.99));
    });

    test('toModel should handle entity with null properties', () {
      // Arrange
      const entity = ProductPriceEntity();

      // Act
      final model = ProductPriceEntityMapper.toModel(entity);

      // Assert
      expect(model.productId, isNull);
      expect(model.isOnSale, isNull);
      expect(model.unitListPrice, isNull);
      expect(model.unitNetPrice, isNull);
      expect(model.unitListBreakPrices, isNull);
      expect(model.regularBreakPrices, isNull);
      expect(model.actualBreakPrices, isNull);
    });

    test('toModel should handle entity with empty break price collections', () {
      // Arrange
      const entity = ProductPriceEntity(
        productId: 'product456',
        unitListBreakPrices: [],
        unitRegularBreakPrices: [],
        regularBreakPrices: [],
        actualBreakPrices: [],
      );

      // Act
      final model = ProductPriceEntityMapper.toModel(entity);

      // Assert
      expect(model.productId, equals('product456'));
      expect(model.unitListBreakPrices, isEmpty);
      expect(model.unitRegularBreakPrices, isEmpty);
      expect(model.regularBreakPrices, isEmpty);
      expect(model.actualBreakPrices, isEmpty);
    });

    test('roundtrip conversion preserves all data', () {
      // Arrange
      final originalModel = ProductPrice(
        productId: 'product123',
        isOnSale: true,
        unitListPrice: 19.99,
        unitListPriceDisplay: '\$19.99',
        unitNetPrice: 14.99,
        unitNetPriceDisplay: '\$14.99',
        unitOfMeasure: 'EA',
        unitListBreakPrices: [
          BreakPriceDto(
              breakQty: 10, breakPrice: 18.99, breakPriceDisplay: '\$18.99')
        ],
        actualBreakPrices: [
          BreakPriceDto(
              breakQty: 10, breakPrice: 13.99, breakPriceDisplay: '\$13.99')
        ],
      );

      // Act
      final entity = ProductPriceEntityMapper.toEntity(originalModel);
      final resultModel = ProductPriceEntityMapper.toModel(entity);

      // Assert
      expect(resultModel.productId, equals(originalModel.productId));
      expect(resultModel.isOnSale, equals(originalModel.isOnSale));
      expect(resultModel.unitListPrice, equals(originalModel.unitListPrice));
      expect(resultModel.unitListPriceDisplay,
          equals(originalModel.unitListPriceDisplay));
      expect(resultModel.unitNetPrice, equals(originalModel.unitNetPrice));
      expect(resultModel.unitNetPriceDisplay,
          equals(originalModel.unitNetPriceDisplay));
      expect(resultModel.unitOfMeasure, equals(originalModel.unitOfMeasure));

      expect(resultModel.unitListBreakPrices?.length,
          equals(originalModel.unitListBreakPrices?.length));
      expect(resultModel.unitListBreakPrices?[0].breakQty,
          equals(originalModel.unitListBreakPrices?[0].breakQty));
      expect(resultModel.unitListBreakPrices?[0].breakPrice,
          equals(originalModel.unitListBreakPrices?[0].breakPrice));

      expect(resultModel.actualBreakPrices?.length,
          equals(originalModel.actualBreakPrices?.length));
      expect(resultModel.actualBreakPrices?[0].breakQty,
          equals(originalModel.actualBreakPrices?[0].breakQty));
      expect(resultModel.actualBreakPrices?[0].breakPrice,
          equals(originalModel.actualBreakPrices?[0].breakPrice));
    });
  });
}
