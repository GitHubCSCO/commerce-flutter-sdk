// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote_query_parameters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$QuoteQueryParametersToJson(
    QuoteQueryParameters instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('page', instance.page);
  writeNotNull('pageSize', instance.pageSize);
  writeNotNull('sort', instance.sort);
  writeNotNull('userId', instance.userId);
  writeNotNull('salesRepNumber', instance.salesRepNumber);
  writeNotNull('customerId', instance.customerId);
  writeNotNull('statuses', instance.statuses);
  writeNotNull('quoteNumber', instance.quoteNumber);
  writeNotNull('fromDate', instance.fromDate?.toIso8601String());
  writeNotNull('toDate', instance.toDate?.toIso8601String());
  writeNotNull('expireFromDate', instance.expireFromDate?.toIso8601String());
  writeNotNull('expireToDate', instance.expireToDate?.toIso8601String());
  writeNotNull('types', instance.types);
  writeNotNull(
      'expand', JsonEncodingMethods.commaSeparatedJson(instance.expand));
  return val;
}
