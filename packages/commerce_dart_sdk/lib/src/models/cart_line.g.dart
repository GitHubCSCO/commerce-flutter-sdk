// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_line.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddCartLine _$AddCartLineFromJson(Map<String, dynamic> json) => AddCartLine(
      notes: json['notes'] as String?,
      productId: json['productId'] as String?,
      qtyOrdered: json['qtyOrdered'] as num?,
      sectionOptions: (json['sectionOptions'] as List<dynamic>?)
          ?.map((e) => SectionOptionDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      unitOfMeasure: json['unitOfMeasure'] as String?,
      vmiBinId: json['vmiBinId'] as String?,
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      );

Map<String, dynamic> _$AddCartLineToJson(AddCartLine instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uri', instance.uri);
  writeNotNull('properties', instance.properties);
  writeNotNull('productId', instance.productId);
  writeNotNull('qtyOrdered', instance.qtyOrdered);
  writeNotNull('unitOfMeasure', instance.unitOfMeasure);
  writeNotNull('notes', instance.notes);
  writeNotNull('vmiBinId', instance.vmiBinId);
  writeNotNull('sectionOptions',
      instance.sectionOptions?.map((e) => e.toJson()).toList());
  return val;
}

CartLineList _$CartLineListFromJson(Map<String, dynamic> json) => CartLineList(
      cartLines: (json['cartLines'] as List<dynamic>?)
          ?.map((e) => CartLine.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      );

Map<String, dynamic> _$CartLineListToJson(CartLineList instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uri', instance.uri);
  writeNotNull('properties', instance.properties);
  writeNotNull(
      'cartLines', instance.cartLines?.map((e) => e.toJson()).toList());
  return val;
}

CartLine _$CartLineFromJson(Map<String, dynamic> json) => CartLine(
      altText: json['altText'] as String?,
      availability: json['availability'] == null
          ? null
          : Availability.fromJson(json['availability'] as Map<String, dynamic>),
      baseUnitOfMeasure: json['baseUnitOfMeasure'] as String?,
      baseUnitOfMeasureDisplay: json['baseUnitOfMeasureDisplay'] as String?,
      brand: json['brand'] == null
          ? null
          : Brand.fromJson(json['brand'] as Map<String, dynamic>),
      breakPrices: (json['breakPrices'] as List<dynamic>?)
          ?.map((e) => BreakPriceDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      canAddToCart: json['canAddToCart'] as bool?,
      canBackOrder: json['canBackOrder'] as bool?,
      costCode: json['costCode'] as String?,
      customerName: json['customerName'] as String?,
      erpNumber: json['erpNumber'] as String?,
      hasInsufficientInventory: json['hasInsufficientInventory'] as bool?,
      id: json['id'] as String?,
      isActive: json['isActive'] as bool?,
      isDiscounted: json['isDiscounted'] as bool?,
      isFixedConfiguration: json['isFixedConfiguration'] as bool?,
      isPromotionItem: json['isPromotionItem'] as bool?,
      isQtyAdjusted: json['isQtyAdjusted'] as bool?,
      isRestricted: json['isRestricted'] as bool?,
      isSubscription: json['isSubscription'] as bool?,
      line: json['line'] as int?,
      manufacturerItem: json['manufacturerItem'] as String?,
      pricing: json['pricing'] == null
          ? null
          : ProductPrice.fromJson(json['pricing'] as Map<String, dynamic>),
      productName: json['productName'] as String?,
      productSubscription: json['productSubscription'] == null
          ? null
          : ProductSubscriptionDto.fromJson(
              json['productSubscription'] as Map<String, dynamic>),
      productUri: json['productUri'] as String?,
      qtyLeft: json['qtyLeft'] as num?,
      qtyOnHand: json['qtyOnHand'] as num?,
      qtyPerBaseUnitOfMeasure: json['qtyPerBaseUnitOfMeasure'] as num?,
      quoteRequired: json['quoteRequired'] as bool?,
      requisitionId: json['requisitionId'] as String?,
      salePriceLabel: json['salePriceLabel'] as String?,
      shortDescription: json['shortDescription'] as String?,
      smallImagePath: json['smallImagePath'] as String?,
      unitOfMeasureDescription: json['unitOfMeasureDescription'] as String?,
      unitOfMeasureDisplay: json['unitOfMeasureDisplay'] as String?,
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      )
      ..productId = json['productId'] as String?
      ..qtyOrdered = json['qtyOrdered'] as num?
      ..unitOfMeasure = json['unitOfMeasure'] as String?
      ..notes = json['notes'] as String?
      ..vmiBinId = json['vmiBinId'] as String?
      ..sectionOptions = (json['sectionOptions'] as List<dynamic>?)
          ?.map((e) => SectionOptionDto.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$CartLineToJson(CartLine instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uri', instance.uri);
  writeNotNull('properties', instance.properties);
  writeNotNull('productId', instance.productId);
  writeNotNull('qtyOrdered', instance.qtyOrdered);
  writeNotNull('unitOfMeasure', instance.unitOfMeasure);
  writeNotNull('notes', instance.notes);
  writeNotNull('vmiBinId', instance.vmiBinId);
  writeNotNull('sectionOptions',
      instance.sectionOptions?.map((e) => e.toJson()).toList());
  writeNotNull('productUri', instance.productUri);
  writeNotNull('id', instance.id);
  writeNotNull('line', instance.line);
  writeNotNull('requisitionId', instance.requisitionId);
  writeNotNull('smallImagePath', instance.smallImagePath);
  writeNotNull('altText', instance.altText);
  writeNotNull('productName', instance.productName);
  writeNotNull('manufacturerItem', instance.manufacturerItem);
  writeNotNull('customerName', instance.customerName);
  writeNotNull('shortDescription', instance.shortDescription);
  writeNotNull('erpNumber', instance.erpNumber);
  writeNotNull('unitOfMeasureDisplay', instance.unitOfMeasureDisplay);
  writeNotNull('unitOfMeasureDescription', instance.unitOfMeasureDescription);
  writeNotNull('baseUnitOfMeasure', instance.baseUnitOfMeasure);
  writeNotNull('baseUnitOfMeasureDisplay', instance.baseUnitOfMeasureDisplay);
  writeNotNull('qtyPerBaseUnitOfMeasure', instance.qtyPerBaseUnitOfMeasure);
  writeNotNull('costCode', instance.costCode);
  writeNotNull('qtyLeft', instance.qtyLeft);
  writeNotNull('pricing', instance.pricing?.toJson());
  writeNotNull('isPromotionItem', instance.isPromotionItem);
  writeNotNull('isDiscounted', instance.isDiscounted);
  writeNotNull('isFixedConfiguration', instance.isFixedConfiguration);
  writeNotNull('quoteRequired', instance.quoteRequired);
  writeNotNull(
      'breakPrices', instance.breakPrices?.map((e) => e.toJson()).toList());
  writeNotNull('availability', instance.availability?.toJson());
  writeNotNull('qtyOnHand', instance.qtyOnHand);
  writeNotNull('canAddToCart', instance.canAddToCart);
  writeNotNull('isQtyAdjusted', instance.isQtyAdjusted);
  writeNotNull('hasInsufficientInventory', instance.hasInsufficientInventory);
  writeNotNull('canBackOrder', instance.canBackOrder);
  writeNotNull('salePriceLabel', instance.salePriceLabel);
  writeNotNull('isSubscription', instance.isSubscription);
  writeNotNull('productSubscription', instance.productSubscription?.toJson());
  writeNotNull('isRestricted', instance.isRestricted);
  writeNotNull('isActive', instance.isActive);
  writeNotNull('brand', instance.brand?.toJson());
  return val;
}

SectionOptionDto _$SectionOptionDtoFromJson(Map<String, dynamic> json) =>
    SectionOptionDto(
      optionName: json['optionName'] as String?,
      sectionName: json['sectionName'] as String?,
      sectionOptionId: json['sectionOptionId'] as String?,
    );

Map<String, dynamic> _$SectionOptionDtoToJson(SectionOptionDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('sectionOptionId', instance.sectionOptionId);
  writeNotNull('sectionName', instance.sectionName);
  writeNotNull('optionName', instance.optionName);
  return val;
}

ProductSubscriptionDto _$ProductSubscriptionDtoFromJson(
        Map<String, dynamic> json) =>
    ProductSubscriptionDto(
      subscriptionAddToInitialOrder:
          json['subscriptionAddToInitialOrder'] as bool?,
      subscriptionAllMonths: json['subscriptionAllMonths'] as bool?,
      subscriptionApril: json['subscriptionApril'] as bool?,
      subscriptionAugust: json['subscriptionAugust'] as bool?,
      subscriptionCyclePeriod: json['subscriptionCyclePeriod'] as String?,
      subscriptionDecember: json['subscriptionDecember'] as bool?,
      subscriptionFebruary: json['subscriptionFebruary'] as bool?,
      subscriptionFixedPrice: json['subscriptionFixedPrice'] as bool?,
      subscriptionJanuary: json['subscriptionJanuary'] as bool?,
      subscriptionJuly: json['subscriptionJuly'] as bool?,
      subscriptionJune: json['subscriptionJune'] as bool?,
      subscriptionMarch: json['subscriptionMarch'] as bool?,
      subscriptionMay: json['subscriptionMay'] as bool?,
      subscriptionNovember: json['subscriptionNovember'] as bool?,
      subscriptionOctober: json['subscriptionOctober'] as bool?,
      subscriptionPeriodsPerCycle: json['subscriptionPeriodsPerCycle'] as int?,
      subscriptionSeptember: json['subscriptionSeptember'] as bool?,
      subscriptionShipViaId: json['subscriptionShipViaId'] as String?,
      subscriptionTotalCycles: json['subscriptionTotalCycles'] as int?,
    );

Map<String, dynamic> _$ProductSubscriptionDtoToJson(
    ProductSubscriptionDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'subscriptionAddToInitialOrder', instance.subscriptionAddToInitialOrder);
  writeNotNull('subscriptionAllMonths', instance.subscriptionAllMonths);
  writeNotNull('subscriptionApril', instance.subscriptionApril);
  writeNotNull('subscriptionAugust', instance.subscriptionAugust);
  writeNotNull('subscriptionCyclePeriod', instance.subscriptionCyclePeriod);
  writeNotNull('subscriptionDecember', instance.subscriptionDecember);
  writeNotNull('subscriptionFebruary', instance.subscriptionFebruary);
  writeNotNull('subscriptionFixedPrice', instance.subscriptionFixedPrice);
  writeNotNull('subscriptionJanuary', instance.subscriptionJanuary);
  writeNotNull('subscriptionJuly', instance.subscriptionJuly);
  writeNotNull('subscriptionJune', instance.subscriptionJune);
  writeNotNull('subscriptionMarch', instance.subscriptionMarch);
  writeNotNull('subscriptionMay', instance.subscriptionMay);
  writeNotNull('subscriptionNovember', instance.subscriptionNovember);
  writeNotNull('subscriptionOctober', instance.subscriptionOctober);
  writeNotNull(
      'subscriptionPeriodsPerCycle', instance.subscriptionPeriodsPerCycle);
  writeNotNull('subscriptionSeptember', instance.subscriptionSeptember);
  writeNotNull('subscriptionShipViaId', instance.subscriptionShipViaId);
  writeNotNull('subscriptionTotalCycles', instance.subscriptionTotalCycles);
  return val;
}
