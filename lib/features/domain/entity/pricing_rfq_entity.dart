import 'package:equatable/equatable.dart';

class PricingRfqEntity extends Equatable {
  final num? unitCost;
  final String? unitCostDisplay;
  final num? listPrice;
  final String? listPriceDisplay;
  final num? customerPrice;
  final String? customerPriceDisplay;
  final num? minimumPriceAllowed;
  final String? minimumPriceAllowedDisplay;
  final num? maxDiscountPct;
  final num? minMarginAllowed;
  final bool? showListPrice;
  final bool? showCustomerPrice;
  final bool? showUnitCost;
  final List<BreakPriceEntity>? priceBreaks;
  final List<CalculationMethodEntity>? calculationMethods;
  final List<ValidationMessageEntity>? validationMessages;

  const PricingRfqEntity({
    this.unitCost,
    this.unitCostDisplay,
    this.listPrice,
    this.listPriceDisplay,
    this.customerPrice,
    this.customerPriceDisplay,
    this.minimumPriceAllowed,
    this.minimumPriceAllowedDisplay,
    this.maxDiscountPct,
    this.minMarginAllowed,
    this.showListPrice,
    this.showCustomerPrice,
    this.showUnitCost,
    this.priceBreaks,
    this.calculationMethods,
    this.validationMessages,
  });

  @override
  List<Object?> get props => [
        unitCost,
        unitCostDisplay,
        listPrice,
        listPriceDisplay,
        customerPrice,
        customerPriceDisplay,
        minimumPriceAllowed,
        minimumPriceAllowedDisplay,
        maxDiscountPct,
        minMarginAllowed,
        showListPrice,
        showCustomerPrice,
        showUnitCost,
        priceBreaks,
        calculationMethods,
        validationMessages,
      ];

  PricingRfqEntity copyWith({
    num? unitCost,
    String? unitCostDisplay,
    num? listPrice,
    String? listPriceDisplay,
    num? customerPrice,
    String? customerPriceDisplay,
    num? minimumPriceAllowed,
    String? minimumPriceAllowedDisplay,
    num? maxDiscountPct,
    num? minMarginAllowed,
    bool? showListPrice,
    bool? showCustomerPrice,
    bool? showUnitCost,
    List<BreakPriceEntity>? priceBreaks,
    List<CalculationMethodEntity>? calculationMethods,
    List<ValidationMessageEntity>? validationMessages,
  }) {
    return PricingRfqEntity(
      unitCost: unitCost ?? this.unitCost,
      unitCostDisplay: unitCostDisplay ?? this.unitCostDisplay,
      listPrice: listPrice ?? this.listPrice,
      listPriceDisplay: listPriceDisplay ?? this.listPriceDisplay,
      customerPrice: customerPrice ?? this.customerPrice,
      customerPriceDisplay: customerPriceDisplay ?? this.customerPriceDisplay,
      minimumPriceAllowed: minimumPriceAllowed ?? this.minimumPriceAllowed,
      minimumPriceAllowedDisplay:
          minimumPriceAllowedDisplay ?? this.minimumPriceAllowedDisplay,
      maxDiscountPct: maxDiscountPct ?? this.maxDiscountPct,
      minMarginAllowed: minMarginAllowed ?? this.minMarginAllowed,
      showListPrice: showListPrice ?? this.showListPrice,
      showCustomerPrice: showCustomerPrice ?? this.showCustomerPrice,
      showUnitCost: showUnitCost ?? this.showUnitCost,
      priceBreaks: priceBreaks ?? this.priceBreaks,
      calculationMethods: calculationMethods ?? this.calculationMethods,
      validationMessages: validationMessages ?? this.validationMessages,
    );
  }
}

class ValidationMessageEntity extends Equatable {
  final String key;
  final String value;

  const ValidationMessageEntity({required this.key, required this.value});

  @override
  List<Object> get props => [key, value];

  ValidationMessageEntity copyWith({
    String? key,
    String? value,
  }) {
    return ValidationMessageEntity(
      key: key ?? this.key,
      value: value ?? this.value,
    );
  }
}

class CalculationMethodEntity extends Equatable {
  final String? value;
  final String? name;
  final String? displayName;
  final String? maximumDiscount;
  final String? minimumMargin;

  const CalculationMethodEntity({
    this.value,
    this.name,
    this.displayName,
    this.maximumDiscount,
    this.minimumMargin,
  });

  @override
  List<Object?> get props => [
        value,
        name,
        displayName,
        maximumDiscount,
        minimumMargin,
      ];

  CalculationMethodEntity copyWith({
    String? value,
    String? name,
    String? displayName,
    String? maximumDiscount,
    String? minimumMargin,
  }) {
    return CalculationMethodEntity(
      value: value ?? this.value,
      name: name ?? this.name,
      displayName: displayName ?? this.displayName,
      maximumDiscount: maximumDiscount ?? this.maximumDiscount,
      minimumMargin: minimumMargin ?? this.minimumMargin,
    );
  }
}

class BreakPriceEntity extends Equatable {
  final num? startQty;
  final String? startQtyDisplay;
  final num? endQty;
  final String? endQtyDisplay;
  final num? price;
  final String? priceDisplay;
  final int? percent;
  final String? calculationMethod;

  const BreakPriceEntity({
    this.startQty,
    this.startQtyDisplay,
    this.endQty,
    this.endQtyDisplay,
    this.price,
    this.priceDisplay,
    this.percent,
    this.calculationMethod,
  });

  @override
  List<Object?> get props => [
        startQty,
        startQtyDisplay,
        endQty,
        endQtyDisplay,
        price,
        priceDisplay,
        percent,
        calculationMethod,
      ];

  BreakPriceEntity copyWith({
    num? startQty,
    String? startQtyDisplay,
    num? endQty,
    String? endQtyDisplay,
    num? price,
    String? priceDisplay,
    int? percent,
    String? calculationMethod,
  }) {
    return BreakPriceEntity(
      startQty: startQty ?? this.startQty,
      startQtyDisplay: startQtyDisplay ?? this.startQtyDisplay,
      endQty: endQty ?? this.endQty,
      endQtyDisplay: endQtyDisplay ?? this.endQtyDisplay,
      price: price ?? this.price,
      priceDisplay: priceDisplay ?? this.priceDisplay,
      percent: percent ?? this.percent,
      calculationMethod: calculationMethod ?? this.calculationMethod,
    );
  }
}
