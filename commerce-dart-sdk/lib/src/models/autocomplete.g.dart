// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'autocomplete.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Autocomplete _$AutocompleteFromJson(Map<String, dynamic> json) => Autocomplete(
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => AutocompleteProduct.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$AutocompleteToJson(Autocomplete instance) =>
    <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.products?.map((e) => e.toJson()).toList() case final value?)
        'products': value,
    };

AutocompleteProduct _$AutocompleteProductFromJson(Map<String, dynamic> json) =>
    AutocompleteProduct(
      id: json['id'] as String?,
      title: json['title'] as String?,
      subtitle: json['subtitle'] as String?,
      image: json['image'] as String?,
      name: json['name'] as String?,
      erpNumber: json['erpNumber'] as String?,
      url: json['url'] as String?,
      manufacturerItemNumber: json['manufacturerItemNumber'] as String?,
      isNameCustomerOverride: json['isNameCustomerOverride'] as bool?,
      brandName: json['brandName'] as String?,
      brandDetailPagePath: json['brandDetailPagePath'] as String?,
      binNumber: json['binNumber'] as String?,
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$AutocompleteProductToJson(
        AutocompleteProduct instance) =>
    <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.id case final value?) 'id': value,
      if (instance.title case final value?) 'title': value,
      if (instance.subtitle case final value?) 'subtitle': value,
      if (instance.image case final value?) 'image': value,
      if (instance.name case final value?) 'name': value,
      if (instance.erpNumber case final value?) 'erpNumber': value,
      if (instance.url case final value?) 'url': value,
      if (instance.manufacturerItemNumber case final value?)
        'manufacturerItemNumber': value,
      if (instance.isNameCustomerOverride case final value?)
        'isNameCustomerOverride': value,
      if (instance.brandName case final value?) 'brandName': value,
      if (instance.brandDetailPagePath case final value?)
        'brandDetailPagePath': value,
      if (instance.binNumber case final value?) 'binNumber': value,
    };

AutocompleteBrand _$AutocompleteBrandFromJson(Map<String, dynamic> json) =>
    AutocompleteBrand(
      id: json['id'] as String?,
      title: json['title'] as String?,
      subtitle: json['subtitle'] as String?,
      url: json['url'] as String?,
      image: json['image'] as String?,
      productLineId: json['productLineId'] as String?,
      productLineName: json['productLineName'] as String?,
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$AutocompleteBrandToJson(AutocompleteBrand instance) =>
    <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.id case final value?) 'id': value,
      if (instance.title case final value?) 'title': value,
      if (instance.subtitle case final value?) 'subtitle': value,
      if (instance.url case final value?) 'url': value,
      if (instance.image case final value?) 'image': value,
      if (instance.productLineId case final value?) 'productLineId': value,
      if (instance.productLineName case final value?) 'productLineName': value,
    };

AutocompleteCategory _$AutocompleteCategoryFromJson(
        Map<String, dynamic> json) =>
    AutocompleteCategory(
      id: json['id'] as String?,
      title: json['title'] as String?,
      subtitle: json['subtitle'] as String?,
      url: json['url'] as String?,
      image: json['image'] as String?,
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$AutocompleteCategoryToJson(
        AutocompleteCategory instance) =>
    <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.id case final value?) 'id': value,
      if (instance.title case final value?) 'title': value,
      if (instance.subtitle case final value?) 'subtitle': value,
      if (instance.url case final value?) 'url': value,
      if (instance.image case final value?) 'image': value,
    };
