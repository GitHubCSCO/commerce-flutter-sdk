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
}
