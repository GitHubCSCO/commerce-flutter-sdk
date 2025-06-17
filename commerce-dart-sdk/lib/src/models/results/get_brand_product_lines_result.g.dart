// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_brand_product_lines_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetBrandProductLinesResult _$GetBrandProductLinesResultFromJson(
        Map<String, dynamic> json) =>
    GetBrandProductLinesResult(
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
      productLines: (json['productLines'] as List<dynamic>?)
          ?.map((e) => BrandProductLine.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$GetBrandProductLinesResultToJson(
        GetBrandProductLinesResult instance) =>
    <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.pagination?.toJson() case final value?) 'pagination': value,
      if (instance.productLines?.map((e) => e.toJson()).toList()
          case final value?)
        'productLines': value,
    };
