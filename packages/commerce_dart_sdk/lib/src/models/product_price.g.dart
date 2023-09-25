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

Map<String, dynamic> _$ProductPriceToJson(ProductPrice instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uri', instance.uri);
  writeNotNull('properties', instance.properties);
  writeNotNull('productId', instance.productId);
  writeNotNull('isOnSale', instance.isOnSale);
  writeNotNull('requiresRealTimePrice', instance.requiresRealTimePrice);
  writeNotNull('quoteRequired', instance.quoteRequired);
  writeNotNull('additionalResults', instance.additionalResults);
  writeNotNull('unitCost', instance.unitCost);
  writeNotNull('unitCostDisplay', instance.unitCostDisplay);
  writeNotNull('unitListPrice', instance.unitListPrice);
  writeNotNull('unitListPriceDisplay', instance.unitListPriceDisplay);
  writeNotNull('extendedUnitListPrice', instance.extendedUnitListPrice);
  writeNotNull(
      'extendedUnitListPriceDisplay', instance.extendedUnitListPriceDisplay);
  writeNotNull('unitRegularPrice', instance.unitRegularPrice);
  writeNotNull('unitRegularPriceDisplay', instance.unitRegularPriceDisplay);
  writeNotNull('extendedUnitRegularPrice', instance.extendedUnitRegularPrice);
  writeNotNull('extendedUnitRegularPriceDisplay',
      instance.extendedUnitRegularPriceDisplay);
  writeNotNull('unitNetPrice', instance.unitNetPrice);
  writeNotNull('unitNetPriceDisplay', instance.unitNetPriceDisplay);
  writeNotNull('extendedUnitNetPrice', instance.extendedUnitNetPrice);
  writeNotNull(
      'extendedUnitNetPriceDisplay', instance.extendedUnitNetPriceDisplay);
  writeNotNull('unitOfMeasure', instance.unitOfMeasure);
  writeNotNull('vatRate', instance.vatRate);
  writeNotNull('vatAmount', instance.vatAmount);
  writeNotNull('vatAmountDisplay', instance.vatAmountDisplay);
  writeNotNull('unitListBreakPrices',
      instance.unitListBreakPrices?.map((e) => e.toJson()).toList());
  writeNotNull('unitRegularBreakPrices',
      instance.unitRegularBreakPrices?.map((e) => e.toJson()).toList());
  writeNotNull('regularPrice', instance.regularPrice);
  writeNotNull('regularPriceDisplay', instance.regularPriceDisplay);
  writeNotNull('extendedRegularPrice', instance.extendedRegularPrice);
  writeNotNull(
      'extendedRegularPriceDisplay', instance.extendedRegularPriceDisplay);
  writeNotNull('actualPrice', instance.actualPrice);
  writeNotNull('actualPriceDisplay', instance.actualPriceDisplay);
  writeNotNull('extendedActualPrice', instance.extendedActualPrice);
  writeNotNull(
      'extendedActualPriceDisplay', instance.extendedActualPriceDisplay);
  writeNotNull('regularBreakPrices',
      instance.regularBreakPrices?.map((e) => e.toJson()).toList());
  writeNotNull('actualBreakPrices',
      instance.actualBreakPrices?.map((e) => e.toJson()).toList());
  return val;
}
