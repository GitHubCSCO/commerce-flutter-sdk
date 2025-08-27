// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attribute_results.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttributeResults _$AttributeResultsFromJson(Map<String, dynamic> json) =>
    AttributeResults(
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => AutocompleteCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
      brands: (json['brands'] as List<dynamic>?)
          ?.map((e) => AutocompleteBrand.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AttributeResultsToJson(AttributeResults instance) =>
    <String, dynamic>{
      if (instance.categories?.map((e) => e.toJson()).toList()
          case final value?)
        'categories': value,
      if (instance.brands?.map((e) => e.toJson()).toList() case final value?)
        'brands': value,
    };
