import 'package:commerce_flutter_app/features/domain/entity/break_price_entity.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class BreakPriceEntityMapper {
  BreakPriceEntity toEntity(BreakPriceDto model) => BreakPriceEntity(
        breakQty: model.breakQty,
        breakPrice: model.breakPrice,
        breakPriceDisplay: model.breakPriceDisplay,
        savingsMessage: model.savingsMessage,
        breakPriceWithVat: model.breakPriceWithVat,
        breakPriceWithVatDisplay: model.breakPriceWithVatDisplay,
      );
  BreakPriceDto toModel(BreakPriceEntity entity) => BreakPriceDto(
        breakQty: entity.breakQty,
        breakPrice: entity.breakPrice,
        breakPriceDisplay: entity.breakPriceDisplay,
        savingsMessage: entity.savingsMessage,
        breakPriceWithVat: entity.breakPriceWithVat,
        breakPriceWithVatDisplay: entity.breakPriceWithVatDisplay,
      );
}
