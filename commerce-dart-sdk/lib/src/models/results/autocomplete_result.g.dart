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
      attributeResults: json['attributeResults'] == null
          ? null
          : AttributeResults.fromJson(
              json['attributeResults'] as Map<String, dynamic>),
      isRetailSearchCompletionResults:
          json['isRetailSearchCompletionResults'] as bool?,
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$AutocompleteResultToJson(AutocompleteResult instance) =>
    <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.products?.map((e) => e.toJson()).toList() case final value?)
        'products': value,
      if (instance.brands?.map((e) => e.toJson()).toList() case final value?)
        'brands': value,
      if (instance.categories?.map((e) => e.toJson()).toList()
          case final value?)
        'categories': value,
      if (instance.attributeResults?.toJson() case final value?)
        'attributeResults': value,
      if (instance.isRetailSearchCompletionResults case final value?)
        'isRetailSearchCompletionResults': value,
    };
