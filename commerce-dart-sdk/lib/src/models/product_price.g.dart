// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_price.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductPrice _$ProductPriceFromJson(Map<String, dynamic> json) => ProductPrice(
      actualBreakPrices: (json['actualBreakPrices'] as List<dynamic>?)
          ?.map((e) => BreakPriceDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      actualPrice: json['actualPrice'] as num?,
      actualPriceDisplay: json['actualPriceDisplay'] as String?,
      additionalResults:
          (json['additionalResults'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      extendedActualPrice: json['extendedActualPrice'] as num?,
      extendedActualPriceDisplay: json['extendedActualPriceDisplay'] as String?,
      extendedRegularPrice: json['extendedRegularPrice'] as num?,
      extendedRegularPriceDisplay:
          json['extendedRegularPriceDisplay'] as String?,
      extendedUnitListPrice: json['extendedUnitListPrice'] as num?,
      extendedUnitListPriceDisplay:
          json['extendedUnitListPriceDisplay'] as String?,
      extendedUnitNetPrice: json['extendedUnitNetPrice'] as num?,
      extendedUnitNetPriceDisplay:
          json['extendedUnitNetPriceDisplay'] as String?,
      extendedUnitRegularPrice: json['extendedUnitRegularPrice'] as num?,
      extendedUnitRegularPriceDisplay:
          json['extendedUnitRegularPriceDisplay'] as String?,
      isOnSale: json['isOnSale'] as bool?,
      productId: json['productId'] as String?,
      quoteRequired: json['quoteRequired'] as bool?,
      regularBreakPrices: (json['regularBreakPrices'] as List<dynamic>?)
          ?.map((e) => BreakPriceDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      regularPrice: json['regularPrice'] as num?,
      regularPriceDisplay: json['regularPriceDisplay'] as String?,
      requiresRealTimePrice: json['requiresRealTimePrice'] as bool?,
      unitCost: json['unitCost'] as num?,
      unitCostDisplay: json['unitCostDisplay'] as String?,
      unitListBreakPrices: (json['unitListBreakPrices'] as List<dynamic>?)
          ?.map((e) => BreakPriceDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      unitListPrice: json['unitListPrice'] as num?,
      unitListPriceDisplay: json['unitListPriceDisplay'] as String?,
      unitNetPrice: json['unitNetPrice'] as num?,
      unitNetPriceDisplay: json['unitNetPriceDisplay'] as String?,
      unitOfMeasure: json['unitOfMeasure'] as String?,
      unitRegularBreakPrices: (json['unitRegularBreakPrices'] as List<dynamic>?)
          ?.map((e) => BreakPriceDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      unitRegularPrice: json['unitRegularPrice'] as num?,
      unitRegularPriceDisplay: json['unitRegularPriceDisplay'] as String?,
      vatAmount: json['vatAmount'] as num?,
      vatAmountDisplay: json['vatAmountDisplay'] as String?,
      vatRate: json['vatRate'] as num?,
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$ProductPriceToJson(ProductPrice instance) =>
    <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.productId case final value?) 'productId': value,
      if (instance.isOnSale case final value?) 'isOnSale': value,
      if (instance.requiresRealTimePrice case final value?)
        'requiresRealTimePrice': value,
      if (instance.quoteRequired case final value?) 'quoteRequired': value,
      if (instance.additionalResults case final value?)
        'additionalResults': value,
      if (instance.unitCost case final value?) 'unitCost': value,
      if (instance.unitCostDisplay case final value?) 'unitCostDisplay': value,
      if (instance.unitListPrice case final value?) 'unitListPrice': value,
      if (instance.unitListPriceDisplay case final value?)
        'unitListPriceDisplay': value,
      if (instance.extendedUnitListPrice case final value?)
        'extendedUnitListPrice': value,
      if (instance.extendedUnitListPriceDisplay case final value?)
        'extendedUnitListPriceDisplay': value,
      if (instance.unitRegularPrice case final value?)
        'unitRegularPrice': value,
      if (instance.unitRegularPriceDisplay case final value?)
        'unitRegularPriceDisplay': value,
      if (instance.extendedUnitRegularPrice case final value?)
        'extendedUnitRegularPrice': value,
      if (instance.extendedUnitRegularPriceDisplay case final value?)
        'extendedUnitRegularPriceDisplay': value,
      if (instance.unitNetPrice case final value?) 'unitNetPrice': value,
      if (instance.unitNetPriceDisplay case final value?)
        'unitNetPriceDisplay': value,
      if (instance.extendedUnitNetPrice case final value?)
        'extendedUnitNetPrice': value,
      if (instance.extendedUnitNetPriceDisplay case final value?)
        'extendedUnitNetPriceDisplay': value,
      if (instance.unitOfMeasure case final value?) 'unitOfMeasure': value,
      if (instance.vatRate case final value?) 'vatRate': value,
      if (instance.vatAmount case final value?) 'vatAmount': value,
      if (instance.vatAmountDisplay case final value?)
        'vatAmountDisplay': value,
      if (instance.unitListBreakPrices?.map((e) => e.toJson()).toList()
          case final value?)
        'unitListBreakPrices': value,
      if (instance.unitRegularBreakPrices?.map((e) => e.toJson()).toList()
          case final value?)
        'unitRegularBreakPrices': value,
      if (instance.regularPrice case final value?) 'regularPrice': value,
      if (instance.regularPriceDisplay case final value?)
        'regularPriceDisplay': value,
      if (instance.extendedRegularPrice case final value?)
        'extendedRegularPrice': value,
      if (instance.extendedRegularPriceDisplay case final value?)
        'extendedRegularPriceDisplay': value,
      if (instance.actualPrice case final value?) 'actualPrice': value,
      if (instance.actualPriceDisplay case final value?)
        'actualPriceDisplay': value,
      if (instance.extendedActualPrice case final value?)
        'extendedActualPrice': value,
      if (instance.extendedActualPriceDisplay case final value?)
        'extendedActualPriceDisplay': value,
      if (instance.regularBreakPrices?.map((e) => e.toJson()).toList()
          case final value?)
        'regularBreakPrices': value,
      if (instance.actualBreakPrices?.map((e) => e.toJson()).toList()
          case final value?)
        'actualBreakPrices': value,
    };
