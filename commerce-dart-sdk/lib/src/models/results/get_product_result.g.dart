// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_product_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetProductResult _$GetProductResultFromJson(Map<String, dynamic> json) =>
    GetProductResult(
      product: json['product'] == null
          ? null
          : Product.fromJson(json['product'] as Map<String, dynamic>),
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$GetProductResultToJson(GetProductResult instance) =>
    <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.product?.toJson() case final value?) 'product': value,
    };
