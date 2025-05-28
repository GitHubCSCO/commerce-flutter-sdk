// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_brands_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetBrandsResult _$GetBrandsResultFromJson(Map<String, dynamic> json) =>
    GetBrandsResult(
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
      brands: (json['brands'] as List<dynamic>?)
          ?.map((e) => Brand.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$GetBrandsResultToJson(GetBrandsResult instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uri', instance.uri);
  writeNotNull('properties', instance.properties);
  writeNotNull('pagination', instance.pagination?.toJson());
  writeNotNull('brands', instance.brands?.map((e) => e.toJson()).toList());
  return val;
}
