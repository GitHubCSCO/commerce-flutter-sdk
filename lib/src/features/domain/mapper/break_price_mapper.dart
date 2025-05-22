import 'package:commerce_flutter_sdk/src/features/domain/entity/break_price_entity.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class BreakPriceDtoEntityMapper {
  static BreakPriceDTOEntity toEntity(BreakPriceDto model) =>
      BreakPriceDTOEntity(
        breakQty: model.breakQty,
        breakPrice: model.breakPrice,
        breakPriceDisplay: model.breakPriceDisplay,
        savingsMessage: model.savingsMessage,
        breakPriceWithVat: model.breakPriceWithVat,
        breakPriceWithVatDisplay: model.breakPriceWithVatDisplay,
      );
  static BreakPriceDto toModel(BreakPriceDTOEntity entity) => BreakPriceDto(
        breakQty: entity.breakQty,
        breakPrice: entity.breakPrice,
        breakPriceDisplay: entity.breakPriceDisplay,
        savingsMessage: entity.savingsMessage,
        breakPriceWithVat: entity.breakPriceWithVat,
        breakPriceWithVatDisplay: entity.breakPriceWithVatDisplay,
      );
}
