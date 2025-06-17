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

Map<String, dynamic> _$PriceRangeToJson(PriceRange instance) =>
    <String, dynamic>{
      if (instance.minimumPrice case final value?) 'minimumPrice': value,
      if (instance.maximumPrice case final value?) 'maximumPrice': value,
      if (instance.count case final value?) 'count': value,
      if (instance.priceFacets?.map((e) => e.toJson()).toList()
          case final value?)
        'priceFacets': value,
    };
