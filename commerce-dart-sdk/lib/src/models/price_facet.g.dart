// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_facet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PriceFacet _$PriceFacetFromJson(Map<String, dynamic> json) => PriceFacet(
      minimumPrice: (json['minimumPrice'] as num?)?.toInt(),
      maximumPrice: (json['maximumPrice'] as num?)?.toInt(),
      count: (json['count'] as num?)?.toInt(),
      selected: json['selected'] as bool?,
    );

Map<String, dynamic> _$PriceFacetToJson(PriceFacet instance) =>
    <String, dynamic>{
      if (instance.minimumPrice case final value?) 'minimumPrice': value,
      if (instance.maximumPrice case final value?) 'maximumPrice': value,
      if (instance.count case final value?) 'count': value,
      if (instance.selected case final value?) 'selected': value,
    };
