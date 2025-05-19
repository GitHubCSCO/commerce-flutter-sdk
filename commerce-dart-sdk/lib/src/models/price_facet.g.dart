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

Map<String, dynamic> _$PriceFacetToJson(PriceFacet instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('minimumPrice', instance.minimumPrice);
  writeNotNull('maximumPrice', instance.maximumPrice);
  writeNotNull('count', instance.count);
  writeNotNull('selected', instance.selected);
  return val;
}
