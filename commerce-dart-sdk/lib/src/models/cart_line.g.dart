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
      allowZeroPricing: json['allowZeroPricing'] as bool?,
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$AddCartLineToJson(AddCartLine instance) =>
    <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.productId case final value?) 'productId': value,
      if (instance.qtyOrdered case final value?) 'qtyOrdered': value,
      if (instance.unitOfMeasure case final value?) 'unitOfMeasure': value,
      if (instance.notes case final value?) 'notes': value,
      if (instance.vmiBinId case final value?) 'vmiBinId': value,
      if (instance.allowZeroPricing case final value?)
        'allowZeroPricing': value,
      if (instance.sectionOptions?.map((e) => e.toJson()).toList()
          case final value?)
        'sectionOptions': value,
    };

CartLineList _$CartLineListFromJson(Map<String, dynamic> json) => CartLineList(
      cartLines: (json['cartLines'] as List<dynamic>?)
          ?.map((e) => CartLine.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$CartLineListToJson(CartLineList instance) =>
    <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.cartLines?.map((e) => e.toJson()).toList() case final value?)
        'cartLines': value,
    };

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
      line: (json['line'] as num?)?.toInt(),
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
      productId: json['productId'] as String?,
      qtyOrdered: json['qtyOrdered'] as num?,
      unitOfMeasure: json['unitOfMeasure'] as String?,
      notes: json['notes'] as String?,
      vmiBinId: json['vmiBinId'] as String?,
      sectionOptions: (json['sectionOptions'] as List<dynamic>?)
          ?.map((e) => SectionOptionDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      allowZeroPricing: json['allowZeroPricing'] as bool?,
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$CartLineToJson(CartLine instance) => <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.productId case final value?) 'productId': value,
      if (instance.qtyOrdered case final value?) 'qtyOrdered': value,
      if (instance.unitOfMeasure case final value?) 'unitOfMeasure': value,
      if (instance.notes case final value?) 'notes': value,
      if (instance.vmiBinId case final value?) 'vmiBinId': value,
      if (instance.allowZeroPricing case final value?)
        'allowZeroPricing': value,
      if (instance.sectionOptions?.map((e) => e.toJson()).toList()
          case final value?)
        'sectionOptions': value,
      if (instance.productUri case final value?) 'productUri': value,
      if (instance.id case final value?) 'id': value,
      if (instance.line case final value?) 'line': value,
      if (instance.requisitionId case final value?) 'requisitionId': value,
      if (instance.smallImagePath case final value?) 'smallImagePath': value,
      if (instance.altText case final value?) 'altText': value,
      if (instance.productName case final value?) 'productName': value,
      if (instance.manufacturerItem case final value?)
        'manufacturerItem': value,
      if (instance.customerName case final value?) 'customerName': value,
      if (instance.shortDescription case final value?)
        'shortDescription': value,
      if (instance.erpNumber case final value?) 'erpNumber': value,
      if (instance.unitOfMeasureDisplay case final value?)
        'unitOfMeasureDisplay': value,
      if (instance.unitOfMeasureDescription case final value?)
        'unitOfMeasureDescription': value,
      if (instance.baseUnitOfMeasure case final value?)
        'baseUnitOfMeasure': value,
      if (instance.baseUnitOfMeasureDisplay case final value?)
        'baseUnitOfMeasureDisplay': value,
      if (instance.qtyPerBaseUnitOfMeasure case final value?)
        'qtyPerBaseUnitOfMeasure': value,
      if (instance.costCode case final value?) 'costCode': value,
      if (instance.qtyLeft case final value?) 'qtyLeft': value,
      if (instance.pricing?.toJson() case final value?) 'pricing': value,
      if (instance.isPromotionItem case final value?) 'isPromotionItem': value,
      if (instance.isDiscounted case final value?) 'isDiscounted': value,
      if (instance.isFixedConfiguration case final value?)
        'isFixedConfiguration': value,
      if (instance.quoteRequired case final value?) 'quoteRequired': value,
      if (instance.breakPrices?.map((e) => e.toJson()).toList()
          case final value?)
        'breakPrices': value,
      if (instance.availability?.toJson() case final value?)
        'availability': value,
      if (instance.qtyOnHand case final value?) 'qtyOnHand': value,
      if (instance.canAddToCart case final value?) 'canAddToCart': value,
      if (instance.isQtyAdjusted case final value?) 'isQtyAdjusted': value,
      if (instance.hasInsufficientInventory case final value?)
        'hasInsufficientInventory': value,
      if (instance.canBackOrder case final value?) 'canBackOrder': value,
      if (instance.salePriceLabel case final value?) 'salePriceLabel': value,
      if (instance.isSubscription case final value?) 'isSubscription': value,
      if (instance.productSubscription?.toJson() case final value?)
        'productSubscription': value,
      if (instance.isRestricted case final value?) 'isRestricted': value,
      if (instance.isActive case final value?) 'isActive': value,
      if (instance.brand?.toJson() case final value?) 'brand': value,
    };

SectionOptionDto _$SectionOptionDtoFromJson(Map<String, dynamic> json) =>
    SectionOptionDto(
      optionName: json['optionName'] as String?,
      sectionName: json['sectionName'] as String?,
      sectionOptionId: json['sectionOptionId'] as String?,
    );

Map<String, dynamic> _$SectionOptionDtoToJson(SectionOptionDto instance) =>
    <String, dynamic>{
      if (instance.sectionOptionId case final value?) 'sectionOptionId': value,
      if (instance.sectionName case final value?) 'sectionName': value,
      if (instance.optionName case final value?) 'optionName': value,
    };

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
      subscriptionPeriodsPerCycle:
          (json['subscriptionPeriodsPerCycle'] as num?)?.toInt(),
      subscriptionSeptember: json['subscriptionSeptember'] as bool?,
      subscriptionShipViaId: json['subscriptionShipViaId'] as String?,
      subscriptionTotalCycles:
          (json['subscriptionTotalCycles'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ProductSubscriptionDtoToJson(
        ProductSubscriptionDto instance) =>
    <String, dynamic>{
      if (instance.subscriptionAddToInitialOrder case final value?)
        'subscriptionAddToInitialOrder': value,
      if (instance.subscriptionAllMonths case final value?)
        'subscriptionAllMonths': value,
      if (instance.subscriptionApril case final value?)
        'subscriptionApril': value,
      if (instance.subscriptionAugust case final value?)
        'subscriptionAugust': value,
      if (instance.subscriptionCyclePeriod case final value?)
        'subscriptionCyclePeriod': value,
      if (instance.subscriptionDecember case final value?)
        'subscriptionDecember': value,
      if (instance.subscriptionFebruary case final value?)
        'subscriptionFebruary': value,
      if (instance.subscriptionFixedPrice case final value?)
        'subscriptionFixedPrice': value,
      if (instance.subscriptionJanuary case final value?)
        'subscriptionJanuary': value,
      if (instance.subscriptionJuly case final value?)
        'subscriptionJuly': value,
      if (instance.subscriptionJune case final value?)
        'subscriptionJune': value,
      if (instance.subscriptionMarch case final value?)
        'subscriptionMarch': value,
      if (instance.subscriptionMay case final value?) 'subscriptionMay': value,
      if (instance.subscriptionNovember case final value?)
        'subscriptionNovember': value,
      if (instance.subscriptionOctober case final value?)
        'subscriptionOctober': value,
      if (instance.subscriptionPeriodsPerCycle case final value?)
        'subscriptionPeriodsPerCycle': value,
      if (instance.subscriptionSeptember case final value?)
        'subscriptionSeptember': value,
      if (instance.subscriptionShipViaId case final value?)
        'subscriptionShipViaId': value,
      if (instance.subscriptionTotalCycles case final value?)
        'subscriptionTotalCycles': value,
    };
