// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bill_tos_query_parameters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$BillTosQueryParametersToJson(
        BillTosQueryParameters instance) =>
    <String, dynamic>{
      if (instance.sort case final value?) 'sort': value,
      if (instance.page case final value?) 'page': value,
      if (instance.pageSize case final value?) 'pageSize': value,
      if (instance.filter case final value?) 'filter': value,
      if (JsonEncodingMethods.commaSeparatedJson(instance.exclude)
          case final value?)
        'exclude': value,
      if (JsonEncodingMethods.commaSeparatedJson(instance.expand)
          case final value?)
        'expand': value,
    };
