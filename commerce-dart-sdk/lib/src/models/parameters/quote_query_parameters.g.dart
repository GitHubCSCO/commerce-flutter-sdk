// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote_query_parameters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$QuoteQueryParametersToJson(
        QuoteQueryParameters instance) =>
    <String, dynamic>{
      if (instance.page case final value?) 'page': value,
      if (instance.pageSize case final value?) 'pageSize': value,
      if (instance.sort case final value?) 'sort': value,
      if (instance.userId case final value?) 'userId': value,
      if (instance.salesRepNumber case final value?) 'salesRepNumber': value,
      if (instance.customerId case final value?) 'customerId': value,
      if (instance.statuses case final value?) 'statuses': value,
      if (instance.quoteNumber case final value?) 'quoteNumber': value,
      if (instance.fromDate?.toIso8601String() case final value?)
        'fromDate': value,
      if (instance.toDate?.toIso8601String() case final value?) 'toDate': value,
      if (instance.expireFromDate?.toIso8601String() case final value?)
        'expireFromDate': value,
      if (instance.expireToDate?.toIso8601String() case final value?)
        'expireToDate': value,
      if (instance.types case final value?) 'types': value,
      if (JsonEncodingMethods.commaSeparatedJson(instance.expand)
          case final value?)
        'expand': value,
    };
