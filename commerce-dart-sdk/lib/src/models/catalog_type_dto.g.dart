// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catalog_type_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CatalogTypeDto _$CatalogTypeDtoFromJson(Map<String, dynamic> json) =>
    CatalogTypeDto(
      id: json['id'] as String?,
      title: json['title'] as String?,
    );

Map<String, dynamic> _$CatalogTypeDtoToJson(CatalogTypeDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('title', instance.title);
  return val;
}

GetCatalogTypeResult _$GetCatalogTypeResultFromJson(
        Map<String, dynamic> json) =>
    GetCatalogTypeResult(
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => CatalogTypeDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$GetCatalogTypeResultToJson(
    GetCatalogTypeResult instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uri', instance.uri);
  writeNotNull('properties', instance.properties);
  writeNotNull('pagination', instance.pagination?.toJson());
  writeNotNull('items', instance.items?.map((e) => e.toJson()).toList());
  return val;
}

Map<String, dynamic> _$CatalogTypeQueryParametersToJson(
    CatalogTypeQueryParameters instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('page', instance.page);
  writeNotNull('pageSize', instance.pageSize);
  writeNotNull('sort', instance.sort);
  writeNotNull('keyword', instance.keyword);
  return val;
}
