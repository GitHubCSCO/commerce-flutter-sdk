import 'package:commerce_flutter_sdk/src/features/domain/entity/break_price_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/break_price_mapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

void main() {
  group('BreakPriceDtoEntityMapper', () {
    test('should correctly map BreakPriceDto to BreakPriceDTOEntity', () {
      // Arrange
      final model = BreakPriceDto(
        breakQty: 10,
        breakPrice: 99.99,
        breakPriceDisplay: "\$99.99",
        savingsMessage: "Save 10%",
        breakPriceWithVat: 119.99,
        breakPriceWithVatDisplay: "\$119.99 (incl. VAT)",
      );

      // Act
      final result = BreakPriceDtoEntityMapper.toEntity(model);

      // Assert
      expect(result.breakQty, model.breakQty);
      expect(result.breakPrice, model.breakPrice);
      expect(result.breakPriceDisplay, model.breakPriceDisplay);
      expect(result.savingsMessage, model.savingsMessage);
      expect(result.breakPriceWithVat, model.breakPriceWithVat);
      expect(result.breakPriceWithVatDisplay, model.breakPriceWithVatDisplay);
    });

    test('should correctly map BreakPriceDTOEntity to BreakPriceDto', () {
      // Arrange
      final entity = BreakPriceDTOEntity(
        breakQty: 5,
        breakPrice: 49.99,
        breakPriceDisplay: "\$49.99",
        savingsMessage: "Save 5%",
        breakPriceWithVat: 59.99,
        breakPriceWithVatDisplay: "\$59.99 (incl. VAT)",
      );

      // Act
      final result = BreakPriceDtoEntityMapper.toModel(entity);

      // Assert
      expect(result.breakQty, entity.breakQty);
      expect(result.breakPrice, entity.breakPrice);
      expect(result.breakPriceDisplay, entity.breakPriceDisplay);
      expect(result.savingsMessage, entity.savingsMessage);
      expect(result.breakPriceWithVat, entity.breakPriceWithVat);
      expect(result.breakPriceWithVatDisplay, entity.breakPriceWithVatDisplay);
    });
  });
}
