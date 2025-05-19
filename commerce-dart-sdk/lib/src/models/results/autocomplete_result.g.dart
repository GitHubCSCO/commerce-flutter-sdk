// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'autocomplete_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AutocompleteResult _$AutocompleteResultFromJson(Map<String, dynamic> json) =>
    AutocompleteResult(
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => AutocompleteProduct.fromJson(e as Map<String, dynamic>))
          .toList(),
      brands: (json['brands'] as List<dynamic>?)
          ?.map((e) => AutocompleteBrand.fromJson(e as Map<String, dynamic>))
          .toList(),
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => AutocompleteCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$AutocompleteResultToJson(AutocompleteResult instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uri', instance.uri);
  writeNotNull('properties', instance.properties);
  writeNotNull('products', instance.products?.map((e) => e.toJson()).toList());
  writeNotNull('brands', instance.brands?.map((e) => e.toJson()).toList());
  writeNotNull(
      'categories', instance.categories?.map((e) => e.toJson()).toList());
  return val;
}
