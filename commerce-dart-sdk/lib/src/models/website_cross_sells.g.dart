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

Map<String, dynamic> _$WebsiteCrosssellsToJson(WebsiteCrosssells instance) =>
    <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.products?.map((e) => e.toJson()).toList() case final value?)
        'products': value,
    };
