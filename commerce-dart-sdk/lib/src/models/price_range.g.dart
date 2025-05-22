// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_range.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PriceRange _$PriceRangeFromJson(Map<String, dynamic> json) => PriceRange(
      minimumPrice: json['minimumPrice'] as num?,
      maximumPrice: json['maximumPrice'] as num?,
      count: (json['count'] as num?)?.toInt(),
      priceFacets: (json['priceFacets'] as List<dynamic>?)
          ?.map((e) => PriceFacet.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PriceRangeToJson(PriceRange instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('minimumPrice', instance.minimumPrice);
  writeNotNull('maximumPrice', instance.maximumPrice);
  writeNotNull('count', instance.count);
  writeNotNull(
      'priceFacets', instance.priceFacets?.map((e) => e.toJson()).toList());
  return val;
}
