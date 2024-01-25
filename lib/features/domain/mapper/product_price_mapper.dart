import 'package:commerce_flutter_app/features/domain/entity/product_price_entity.dart';
import 'package:commerce_flutter_app/features/domain/mapper/break_price_mapper.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class ProductPriceEntityMapper {
  ProductPriceEntity toEntity(ProductPrice model) => ProductPriceEntity(
        productId: model.productId,
        isOnSale: model.isOnSale,
        requiresRealTimePrice: model.requiresRealTimePrice,
        quoteRequired: model.quoteRequired,
        additionalResults: model.additionalResults,
        unitCost: model.unitCost,
        unitCostDisplay: model.unitCostDisplay,
        unitListPrice: model.unitListPrice,
        unitListPriceDisplay: model.unitListPriceDisplay,
        extendedUnitListPrice: model.extendedUnitListPrice,
        extendedUnitListPriceDisplay: model.extendedUnitListPriceDisplay,
        unitRegularPrice: model.unitRegularPrice,
        unitRegularPriceDisplay: model.unitRegularPriceDisplay,
        extendedUnitRegularPrice: model.extendedUnitRegularPrice,
        extendedUnitRegularPriceDisplay: model.extendedUnitRegularPriceDisplay,
        unitNetPrice: model.unitNetPrice,
        unitNetPriceDisplay: model.unitNetPriceDisplay,
        extendedUnitNetPrice: model.extendedUnitNetPrice,
        extendedUnitNetPriceDisplay: model.extendedUnitNetPriceDisplay,
        unitOfMeasure: model.unitOfMeasure,
        vatRate: model.vatRate,
        vatAmount: model.vatAmount,
        vatAmountDisplay: model.vatAmountDisplay,
        unitListBreakPrices: model.unitListBreakPrices
            ?.map((e) => BreakPriceEntityMapper().toEntity(e))
            .toList(),
        unitRegularBreakPrices: model.unitRegularBreakPrices
            ?.map((e) => BreakPriceEntityMapper().toEntity(e))
            .toList(),
        regularPrice: model.regularPrice,
        regularPriceDisplay: model.regularPriceDisplay,
        extendedRegularPrice: model.extendedRegularPrice,
        extendedRegularPriceDisplay: model.extendedRegularPriceDisplay,
        actualPrice: model.actualPrice,
        actualPriceDisplay: model.actualPriceDisplay,
        extendedActualPrice: model.extendedActualPrice,
        extendedActualPriceDisplay: model.extendedActualPriceDisplay,
        regularBreakPrices: model.regularBreakPrices
            ?.map((e) => BreakPriceEntityMapper().toEntity(e))
            .toList(),
        actualBreakPrices: model.actualBreakPrices
            ?.map((e) => BreakPriceEntityMapper().toEntity(e))
            .toList(),
      );
}
