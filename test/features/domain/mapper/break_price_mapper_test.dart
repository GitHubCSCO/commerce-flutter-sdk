import 'package:flutter_test/flutter_test.dart';
import 'package:commerce_flutter_app/features/domain/mapper/break_price_mapper.dart';
import 'package:commerce_flutter_app/features/domain/entity/break_price_entity.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

void main() {
  group('BreakPriceDtoEntityMapper', () {
    test('toEntity should convert model to entity with all properties', () {
      // Arrange
      final model = BreakPriceDto(
        breakQty: 10,
        breakPrice: 19.99,
        breakPriceDisplay: '\$19.99',
        savingsMessage: 'Save 10%',
        breakPriceWithVat: 23.99,
        breakPriceWithVatDisplay: '\$23.99',
      );

      // Act
      final entity = BreakPriceDtoEntityMapper.toEntity(model);

      // Assert
      expect(entity.breakQty, model.breakQty);
      expect(entity.breakPrice, model.breakPrice);
      expect(entity.breakPriceDisplay, model.breakPriceDisplay);
      expect(entity.savingsMessage, model.savingsMessage);
      expect(entity.breakPriceWithVat, model.breakPriceWithVat);
      expect(entity.breakPriceWithVatDisplay, model.breakPriceWithVatDisplay);
    });

    test('toEntity should handle model with null properties', () {
      // Arrange
      final model = BreakPriceDto(
        breakQty: null,
        breakPrice: null,
        breakPriceDisplay: null,
        savingsMessage: null,
        breakPriceWithVat: null,
        breakPriceWithVatDisplay: null,
      );

      // Act
      final entity = BreakPriceDtoEntityMapper.toEntity(model);

      // Assert
      expect(entity.breakQty, null);
      expect(entity.breakPrice, null);
      expect(entity.breakPriceDisplay, null);
      expect(entity.savingsMessage, null);
      expect(entity.breakPriceWithVat, null);
      expect(entity.breakPriceWithVatDisplay, null);
    });

    test('toModel should convert entity to model with all properties', () {
      // Arrange
      final entity = BreakPriceDTOEntity(
        breakQty: 5,
        breakPrice: 24.99,
        breakPriceDisplay: '\$24.99',
        savingsMessage: 'Save 5%',
        breakPriceWithVat: 29.99,
        breakPriceWithVatDisplay: '\$29.99',
      );

      // Act
      final model = BreakPriceDtoEntityMapper.toModel(entity);

      // Assert
      expect(model.breakQty, entity.breakQty);
      expect(model.breakPrice, entity.breakPrice);
      expect(model.breakPriceDisplay, entity.breakPriceDisplay);
      expect(model.savingsMessage, entity.savingsMessage);
      expect(model.breakPriceWithVat, entity.breakPriceWithVat);
      expect(model.breakPriceWithVatDisplay, entity.breakPriceWithVatDisplay);
    });

    test('toModel should handle entity with null properties', () {
      // Arrange
      final entity = BreakPriceDTOEntity(
        breakQty: null,
        breakPrice: null,
        breakPriceDisplay: null,
        savingsMessage: null,
        breakPriceWithVat: null,
        breakPriceWithVatDisplay: null,
      );

      // Act
      final model = BreakPriceDtoEntityMapper.toModel(entity);

      // Assert
      expect(model.breakQty, null);
      expect(model.breakPrice, null);
      expect(model.breakPriceDisplay, null);
      expect(model.savingsMessage, null);
      expect(model.breakPriceWithVat, null);
      expect(model.breakPriceWithVatDisplay, null);
    });

    test('roundtrip conversion preserves all data', () {
      // Arrange
      final originalModel = BreakPriceDto(
        breakQty: 15,
        breakPrice: 15.99,
        breakPriceDisplay: '\$15.99',
        savingsMessage: 'Save 15%',
        breakPriceWithVat: 19.18,
        breakPriceWithVatDisplay: '\$19.18',
      );

      // Act
      final entity = BreakPriceDtoEntityMapper.toEntity(originalModel);
      final resultModel = BreakPriceDtoEntityMapper.toModel(entity);

      // Assert
      expect(resultModel.breakQty, equals(originalModel.breakQty));
      expect(resultModel.breakPrice, equals(originalModel.breakPrice));
      expect(resultModel.breakPriceDisplay,
          equals(originalModel.breakPriceDisplay));
      expect(resultModel.savingsMessage, equals(originalModel.savingsMessage));
      expect(resultModel.breakPriceWithVat,
          equals(originalModel.breakPriceWithVat));
      expect(resultModel.breakPriceWithVatDisplay,
          equals(originalModel.breakPriceWithVatDisplay));
    });
  });
}
