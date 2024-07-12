import 'package:commerce_flutter_app/features/domain/entity/product_price_entity.dart';
import 'package:commerce_flutter_app/features/domain/mapper/break_price_mapper.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class ProductPriceEntityMapper {
  static ProductPriceEntity toEntity(ProductPrice? model) => ProductPriceEntity(
        productId: model?.productId,
        isOnSale: model?.isOnSale,
        requiresRealTimePrice: model?.requiresRealTimePrice,
        quoteRequired: model?.quoteRequired,
        additionalResults: model?.additionalResults,
        unitCost: model?.unitCost,
        unitCostDisplay: model?.unitCostDisplay,
        unitListPrice: model?.unitListPrice,
        unitListPriceDisplay: model?.unitListPriceDisplay,
        extendedUnitListPrice: model?.extendedUnitListPrice,
        extendedUnitListPriceDisplay: model?.extendedUnitListPriceDisplay,
        unitRegularPrice: model?.unitRegularPrice,
        unitRegularPriceDisplay: model?.unitRegularPriceDisplay,
        extendedUnitRegularPrice: model?.extendedUnitRegularPrice,
        extendedUnitRegularPriceDisplay: model?.extendedUnitRegularPriceDisplay,
        unitNetPrice: model?.unitNetPrice,
        unitNetPriceDisplay: model?.unitNetPriceDisplay,
        extendedUnitNetPrice: model?.extendedUnitNetPrice,
        extendedUnitNetPriceDisplay: model?.extendedUnitNetPriceDisplay,
        unitOfMeasure: model?.unitOfMeasure,
        vatRate: model?.vatRate,
        vatAmount: model?.vatAmount,
        vatAmountDisplay: model?.vatAmountDisplay,
        unitListBreakPrices: model?.unitListBreakPrices
            ?.map((e) => BreakPriceDtoEntityMapper.toEntity(e))
            .toList(),
        unitRegularBreakPrices: model?.unitRegularBreakPrices
            ?.map((e) => BreakPriceDtoEntityMapper.toEntity(e))
            .toList(),
        regularPrice: model?.regularPrice,
        regularPriceDisplay: model?.regularPriceDisplay,
        extendedRegularPrice: model?.extendedRegularPrice,
        extendedRegularPriceDisplay: model?.extendedRegularPriceDisplay,
        actualPrice: model?.actualPrice,
        actualPriceDisplay: model?.actualPriceDisplay,
        extendedActualPrice: model?.extendedActualPrice,
        extendedActualPriceDisplay: model?.extendedActualPriceDisplay,
        regularBreakPrices: model?.regularBreakPrices
            ?.map((e) => BreakPriceDtoEntityMapper.toEntity(e))
            .toList(),
        actualBreakPrices: model?.actualBreakPrices
            ?.map((e) => BreakPriceDtoEntityMapper.toEntity(e))
            .toList(),
      );

  static ProductPrice toModel(ProductPriceEntity entity) => ProductPrice(
        productId: entity.productId,
        isOnSale: entity.isOnSale,
        requiresRealTimePrice: entity.requiresRealTimePrice,
        quoteRequired: entity.quoteRequired,
        additionalResults: entity.additionalResults,
        unitCost: entity.unitCost,
        unitCostDisplay: entity.unitCostDisplay,
        unitListPrice: entity.unitListPrice,
        unitListPriceDisplay: entity.unitListPriceDisplay,
        extendedUnitListPrice: entity.extendedUnitListPrice,
        extendedUnitListPriceDisplay: entity.extendedUnitListPriceDisplay,
        unitRegularPrice: entity.unitRegularPrice,
        unitRegularPriceDisplay: entity.unitRegularPriceDisplay,
        extendedUnitRegularPrice: entity.extendedUnitRegularPrice,
        extendedUnitRegularPriceDisplay: entity.extendedUnitRegularPriceDisplay,
        unitNetPrice: entity.unitNetPrice,
        unitNetPriceDisplay: entity.unitNetPriceDisplay,
        extendedUnitNetPrice: entity.extendedUnitNetPrice,
        extendedUnitNetPriceDisplay: entity.extendedUnitNetPriceDisplay,
        unitOfMeasure: entity.unitOfMeasure,
        vatRate: entity.vatRate,
        vatAmount: entity.vatAmount,
        vatAmountDisplay: entity.vatAmountDisplay,
        unitListBreakPrices: entity.unitListBreakPrices
            ?.map((e) => BreakPriceDtoEntityMapper.toModel(e))
            .toList(),
        unitRegularBreakPrices: entity.unitRegularBreakPrices
            ?.map((e) => BreakPriceDtoEntityMapper.toModel(e))
            .toList(),
        regularPrice: entity.regularPrice,
        regularPriceDisplay: entity.regularPriceDisplay,
        extendedRegularPrice: entity.extendedRegularPrice,
        extendedRegularPriceDisplay: entity.extendedRegularPriceDisplay,
        actualPrice: entity.actualPrice,
        actualPriceDisplay: entity.actualPriceDisplay,
        extendedActualPrice: entity.extendedActualPrice,
        extendedActualPriceDisplay: entity.extendedActualPriceDisplay,
        regularBreakPrices: entity.regularBreakPrices
            ?.map((e) => BreakPriceDtoEntityMapper.toModel(e))
            .toList(),
        actualBreakPrices: entity.actualBreakPrices
            ?.map((e) => BreakPriceDtoEntityMapper.toModel(e))
            .toList(),
      );
}
