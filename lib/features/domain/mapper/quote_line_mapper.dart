import 'package:commerce_flutter_app/features/domain/entity/pricing_rfq_entity.dart';
import 'package:commerce_flutter_app/features/domain/mapper/break_price_mapper.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class PricingRfqEntityMapper {
  static PricingRfqEntity toEntity(PricingRfq model) => PricingRfqEntity(
        unitCost: model.unitCost,
        unitCostDisplay: model.unitCostDisplay,
        listPrice: model.listPrice,
        listPriceDisplay: model.listPriceDisplay,
        customerPrice: model.customerPrice,
        customerPriceDisplay: model.customerPriceDisplay,
        minimumPriceAllowed: model.minimumPriceAllowed,
        minimumPriceAllowedDisplay: model.minimumPriceAllowedDisplay,
        maxDiscountPct: model.maxDiscountPct,
        minMarginAllowed: model.minMarginAllowed,
        showListPrice: model.showListPrice,
        showCustomerPrice: model.showCustomerPrice,
        showUnitCost: model.showUnitCost,
        priceBreaks: model.priceBreaks
            ?.map((e) => BreakPriceEntityMapper.toEntity(e))
            .toList(),
        calculationMethods: model.calculationMethods
            ?.map((e) => CalculationMethodEntityMapper.toEntity(e))
            .toList(),
        validationMessages: model.validationMessages
            ?.map((e) => ValidationMessageEntityMapper.toEntity(e))
            .toList(),
      );

  static PricingRfq toModel(PricingRfqEntity entity) => PricingRfq(
        unitCost: entity.unitCost,
        unitCostDisplay: entity.unitCostDisplay,
        listPrice: entity.listPrice,
        listPriceDisplay: entity.listPriceDisplay,
        customerPrice: entity.customerPrice,
        customerPriceDisplay: entity.customerPriceDisplay,
        minimumPriceAllowed: entity.minimumPriceAllowed,
        minimumPriceAllowedDisplay: entity.minimumPriceAllowedDisplay,
        maxDiscountPct: entity.maxDiscountPct,
        minMarginAllowed: entity.minMarginAllowed,
        showListPrice: entity.showListPrice,
        showCustomerPrice: entity.showCustomerPrice,
        showUnitCost: entity.showUnitCost,
        priceBreaks: entity.priceBreaks
            ?.map((e) => BreakPriceEntityMapper.toModel(e))
            .toList(),
        calculationMethods: entity.calculationMethods
            ?.map((e) => CalculationMethodEntityMapper.toModel(e))
            .toList(),
        validationMessages: entity.validationMessages
            ?.map((e) => ValidationMessageEntityMapper.toModel(e))
            .toList(),
      );
}

class CalculationMethodEntityMapper {
  static CalculationMethodEntity toEntity(CalculationMethod model) =>
      CalculationMethodEntity(
        value: model.value,
        name: model.name,
        displayName: model.displayName,
        maximumDiscount: model.maximumDiscount,
        minimumMargin: model.minimumMargin,
      );

  static CalculationMethod toModel(CalculationMethodEntity entity) =>
      CalculationMethod(
        value: entity.value,
        name: entity.name,
        displayName: entity.displayName,
        maximumDiscount: entity.maximumDiscount,
        minimumMargin: entity.minimumMargin,
      );
}

class ValidationMessageEntityMapper {
  static ValidationMessageEntity toEntity(ValidationMessage model) =>
      ValidationMessageEntity(
        key: model.key,
        value: model.value,
      );

  static ValidationMessage toModel(ValidationMessageEntity entity) =>
      ValidationMessage(
        key: entity.key,
        value: entity.value,
      );
}

class BreakPriceEntityMapper {
  static BreakPriceEntity toEntity(BreakPrice model) => BreakPriceEntity(
        startQty: model.startQty,
        startQtyDisplay: model.startQtyDisplay,
        endQty: model.endQty,
        endQtyDisplay: model.endQtyDisplay,
        price: model.price,
        priceDisplay: model.priceDispaly,
        percent: model.percent,
        calculationMethod: model.calculationMethod,
      );

  static BreakPrice toModel(BreakPriceEntity entity) => BreakPrice(
        startQty: entity.startQty,
        startQtyDisplay: entity.startQtyDisplay,
        endQty: entity.endQty,
        endQtyDisplay: entity.endQtyDisplay,
        price: entity.price,
        priceDispaly: entity.priceDisplay,
        percent: entity.percent,
        calculationMethod: entity.calculationMethod,
      );
}
