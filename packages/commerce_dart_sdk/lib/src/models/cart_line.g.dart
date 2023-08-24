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

Map<String, dynamic> _$AddCartLineToJson(AddCartLine instance) =>
    <String, dynamic>{
      'uri': instance.uri,
      'properties': instance.properties,
      'productId': instance.productId,
      'qtyOrdered': instance.qtyOrdered,
      'unitOfMeasure': instance.unitOfMeasure,
      'notes': instance.notes,
      'vmiBinId': instance.vmiBinId,
      'sectionOptions':
          instance.sectionOptions?.map((e) => e.toJson()).toList(),
    };

CartLineList _$CartLineListFromJson(Map<String, dynamic> json) => CartLineList(
      cartLines: (json['cartLines'] as List<dynamic>?)
          ?.map((e) => CartLine.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      );

Map<String, dynamic> _$CartLineListToJson(CartLineList instance) =>
    <String, dynamic>{
      'uri': instance.uri,
      'properties': instance.properties,
      'cartLines': instance.cartLines?.map((e) => e.toJson()).toList(),
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

Map<String, dynamic> _$CartLineToJson(CartLine instance) => <String, dynamic>{
      'uri': instance.uri,
      'properties': instance.properties,
      'productId': instance.productId,
      'qtyOrdered': instance.qtyOrdered,
      'unitOfMeasure': instance.unitOfMeasure,
      'notes': instance.notes,
      'vmiBinId': instance.vmiBinId,
      'sectionOptions':
          instance.sectionOptions?.map((e) => e.toJson()).toList(),
      'productUri': instance.productUri,
      'id': instance.id,
      'line': instance.line,
      'requisitionId': instance.requisitionId,
      'smallImagePath': instance.smallImagePath,
      'altText': instance.altText,
      'productName': instance.productName,
      'manufacturerItem': instance.manufacturerItem,
      'customerName': instance.customerName,
      'shortDescription': instance.shortDescription,
      'erpNumber': instance.erpNumber,
      'unitOfMeasureDisplay': instance.unitOfMeasureDisplay,
      'unitOfMeasureDescription': instance.unitOfMeasureDescription,
      'baseUnitOfMeasure': instance.baseUnitOfMeasure,
      'baseUnitOfMeasureDisplay': instance.baseUnitOfMeasureDisplay,
      'qtyPerBaseUnitOfMeasure': instance.qtyPerBaseUnitOfMeasure,
      'costCode': instance.costCode,
      'qtyLeft': instance.qtyLeft,
      'pricing': instance.pricing?.toJson(),
      'isPromotionItem': instance.isPromotionItem,
      'isDiscounted': instance.isDiscounted,
      'isFixedConfiguration': instance.isFixedConfiguration,
      'quoteRequired': instance.quoteRequired,
      'breakPrices': instance.breakPrices?.map((e) => e.toJson()).toList(),
      'availability': instance.availability?.toJson(),
      'qtyOnHand': instance.qtyOnHand,
      'canAddToCart': instance.canAddToCart,
      'isQtyAdjusted': instance.isQtyAdjusted,
      'hasInsufficientInventory': instance.hasInsufficientInventory,
      'canBackOrder': instance.canBackOrder,
      'salePriceLabel': instance.salePriceLabel,
      'isSubscription': instance.isSubscription,
      'productSubscription': instance.productSubscription?.toJson(),
      'isRestricted': instance.isRestricted,
      'isActive': instance.isActive,
      'brand': instance.brand?.toJson(),
    };

SectionOptionDto _$SectionOptionDtoFromJson(Map<String, dynamic> json) =>
    SectionOptionDto(
      optionName: json['optionName'] as String?,
      sectionName: json['sectionName'] as String?,
      sectionOptionId: json['sectionOptionId'] as String?,
    );

Map<String, dynamic> _$SectionOptionDtoToJson(SectionOptionDto instance) =>
    <String, dynamic>{
      'sectionOptionId': instance.sectionOptionId,
      'sectionName': instance.sectionName,
      'optionName': instance.optionName,
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
      subscriptionPeriodsPerCycle: json['subscriptionPeriodsPerCycle'] as int?,
      subscriptionSeptember: json['subscriptionSeptember'] as bool?,
      subscriptionShipViaId: json['subscriptionShipViaId'] as String?,
      subscriptionTotalCycles: json['subscriptionTotalCycles'] as int?,
    );

Map<String, dynamic> _$ProductSubscriptionDtoToJson(
        ProductSubscriptionDto instance) =>
    <String, dynamic>{
      'subscriptionAddToInitialOrder': instance.subscriptionAddToInitialOrder,
      'subscriptionAllMonths': instance.subscriptionAllMonths,
      'subscriptionApril': instance.subscriptionApril,
      'subscriptionAugust': instance.subscriptionAugust,
      'subscriptionCyclePeriod': instance.subscriptionCyclePeriod,
      'subscriptionDecember': instance.subscriptionDecember,
      'subscriptionFebruary': instance.subscriptionFebruary,
      'subscriptionFixedPrice': instance.subscriptionFixedPrice,
      'subscriptionJanuary': instance.subscriptionJanuary,
      'subscriptionJuly': instance.subscriptionJuly,
      'subscriptionJune': instance.subscriptionJune,
      'subscriptionMarch': instance.subscriptionMarch,
      'subscriptionMay': instance.subscriptionMay,
      'subscriptionNovember': instance.subscriptionNovember,
      'subscriptionOctober': instance.subscriptionOctober,
      'subscriptionPeriodsPerCycle': instance.subscriptionPeriodsPerCycle,
      'subscriptionSeptember': instance.subscriptionSeptember,
      'subscriptionShipViaId': instance.subscriptionShipViaId,
      'subscriptionTotalCycles': instance.subscriptionTotalCycles,
    };
