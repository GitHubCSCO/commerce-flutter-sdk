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

Map<String, dynamic> _$GetBrandsResultToJson(GetBrandsResult instance) =>
    <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.pagination?.toJson() case final value?) 'pagination': value,
      if (instance.brands?.map((e) => e.toJson()).toList() case final value?)
        'brands': value,
    };
