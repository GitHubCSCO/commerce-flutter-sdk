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

Map<String, dynamic> _$AutocompleteToJson(Autocomplete instance) {
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

Map<String, dynamic> _$AutocompleteProductToJson(AutocompleteProduct instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uri', instance.uri);
  writeNotNull('properties', instance.properties);
  writeNotNull('id', instance.id);
  writeNotNull('title', instance.title);
  writeNotNull('subtitle', instance.subtitle);
  writeNotNull('image', instance.image);
  writeNotNull('name', instance.name);
  writeNotNull('erpNumber', instance.erpNumber);
  writeNotNull('url', instance.url);
  writeNotNull('manufacturerItemNumber', instance.manufacturerItemNumber);
  writeNotNull('isNameCustomerOverride', instance.isNameCustomerOverride);
  writeNotNull('brandName', instance.brandName);
  writeNotNull('brandDetailPagePath', instance.brandDetailPagePath);
  writeNotNull('binNumber', instance.binNumber);
  return val;
}

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

Map<String, dynamic> _$AutocompleteBrandToJson(AutocompleteBrand instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uri', instance.uri);
  writeNotNull('properties', instance.properties);
  writeNotNull('id', instance.id);
  writeNotNull('title', instance.title);
  writeNotNull('subtitle', instance.subtitle);
  writeNotNull('url', instance.url);
  writeNotNull('image', instance.image);
  writeNotNull('productLineId', instance.productLineId);
  writeNotNull('productLineName', instance.productLineName);
  return val;
}

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
    AutocompleteCategory instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uri', instance.uri);
  writeNotNull('properties', instance.properties);
  writeNotNull('id', instance.id);
  writeNotNull('title', instance.title);
  writeNotNull('subtitle', instance.subtitle);
  writeNotNull('url', instance.url);
  writeNotNull('image', instance.image);
  return val;
}
