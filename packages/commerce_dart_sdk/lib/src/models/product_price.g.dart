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
        (k, e) => MapEntry(k, e as String),
      );

Map<String, dynamic> _$ProductPriceToJson(ProductPrice instance) =>
    <String, dynamic>{
      'uri': instance.uri,
      'properties': instance.properties,
      'productId': instance.productId,
      'isOnSale': instance.isOnSale,
      'requiresRealTimePrice': instance.requiresRealTimePrice,
      'quoteRequired': instance.quoteRequired,
      'additionalResults': instance.additionalResults,
      'unitCost': instance.unitCost,
      'unitCostDisplay': instance.unitCostDisplay,
      'unitListPrice': instance.unitListPrice,
      'unitListPriceDisplay': instance.unitListPriceDisplay,
      'extendedUnitListPrice': instance.extendedUnitListPrice,
      'extendedUnitListPriceDisplay': instance.extendedUnitListPriceDisplay,
      'unitRegularPrice': instance.unitRegularPrice,
      'unitRegularPriceDisplay': instance.unitRegularPriceDisplay,
      'extendedUnitRegularPrice': instance.extendedUnitRegularPrice,
      'extendedUnitRegularPriceDisplay':
          instance.extendedUnitRegularPriceDisplay,
      'unitNetPrice': instance.unitNetPrice,
      'unitNetPriceDisplay': instance.unitNetPriceDisplay,
      'extendedUnitNetPrice': instance.extendedUnitNetPrice,
      'extendedUnitNetPriceDisplay': instance.extendedUnitNetPriceDisplay,
      'unitOfMeasure': instance.unitOfMeasure,
      'vatRate': instance.vatRate,
      'vatAmount': instance.vatAmount,
      'vatAmountDisplay': instance.vatAmountDisplay,
      'unitListBreakPrices':
          instance.unitListBreakPrices?.map((e) => e.toJson()).toList(),
      'unitRegularBreakPrices':
          instance.unitRegularBreakPrices?.map((e) => e.toJson()).toList(),
      'regularPrice': instance.regularPrice,
      'regularPriceDisplay': instance.regularPriceDisplay,
      'extendedRegularPrice': instance.extendedRegularPrice,
      'extendedRegularPriceDisplay': instance.extendedRegularPriceDisplay,
      'actualPrice': instance.actualPrice,
      'actualPriceDisplay': instance.actualPriceDisplay,
      'extendedActualPrice': instance.extendedActualPrice,
      'extendedActualPriceDisplay': instance.extendedActualPriceDisplay,
      'regularBreakPrices':
          instance.regularBreakPrices?.map((e) => e.toJson()).toList(),
      'actualBreakPrices':
          instance.actualBreakPrices?.map((e) => e.toJson()).toList(),
    };
