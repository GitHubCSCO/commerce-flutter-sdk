// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'website_cross_sells.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebsiteCrosssells _$WebsiteCrosssellsFromJson(Map<String, dynamic> json) =>
    WebsiteCrosssells(
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$WebsiteCrosssellsToJson(WebsiteCrosssells instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uri', instance.uri);
  writeNotNull('properties', instance.properties);
  writeNotNull('products', instance.products?.map((e) => e.toJson()).toList());
  return val;
}
