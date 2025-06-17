// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'countries_query_parameters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$CountriesQueryParametersToJson(
        CountriesQueryParameters instance) =>
    <String, dynamic>{
      if (instance.page case final value?) 'page': value,
      if (instance.pageSize case final value?) 'pageSize': value,
      if (instance.sort case final value?) 'sort': value,
      if (JsonEncodingMethods.commaSeparatedJson(instance.expand)
          case final value?)
        'expand': value,
    };
