// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brands_query_parameters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$BrandsQueryParametersToJson(
        BrandsQueryParameters instance) =>
    <String, dynamic>{
      if (instance.page case final value?) 'page': value,
      if (instance.sort case final value?) 'sort': value,
      if (instance.startsWith case final value?) 'startsWith': value,
      if (instance.manufacturer case final value?) 'manufacturer': value,
      'pageSize': instance.pageSize,
      if (JsonEncodingMethods.commaSeparatedJson(instance.expand)
          case final value?)
        'expand': value,
    };

Map<String, dynamic> _$BrandQueryParametersToJson(
        BrandQueryParameters instance) =>
    <String, dynamic>{
      if (instance.page case final value?) 'page': value,
      if (instance.pageSize case final value?) 'pageSize': value,
      if (instance.sort case final value?) 'sort': value,
      if (JsonEncodingMethods.commaSeparatedJson(instance.expand)
          case final value?)
        'expand': value,
    };
