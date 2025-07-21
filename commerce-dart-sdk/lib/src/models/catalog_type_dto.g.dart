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

Map<String, dynamic> _$CatalogTypeDtoToJson(CatalogTypeDto instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.title case final value?) 'title': value,
    };

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
        GetCatalogTypeResult instance) =>
    <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.pagination?.toJson() case final value?) 'pagination': value,
      if (instance.items?.map((e) => e.toJson()).toList() case final value?)
        'items': value,
    };

Map<String, dynamic> _$CatalogTypeQueryParametersToJson(
        CatalogTypeQueryParameters instance) =>
    <String, dynamic>{
      if (instance.page case final value?) 'page': value,
      if (instance.pageSize case final value?) 'pageSize': value,
      if (instance.sort case final value?) 'sort': value,
      if (instance.keyword case final value?) 'keyword': value,
    };
