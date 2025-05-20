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

Map<String, dynamic> _$GetProductResultToJson(GetProductResult instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uri', instance.uri);
  writeNotNull('properties', instance.properties);
  writeNotNull('product', instance.product?.toJson());
  return val;
}
