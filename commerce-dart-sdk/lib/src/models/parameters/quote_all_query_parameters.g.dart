// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote_all_query_parameters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuoteAllQueryParameters _$QuoteAllQueryParametersFromJson(
        Map<String, dynamic> json) =>
    QuoteAllQueryParameters(
      calculationMethod: json['calculationMethod'] as String?,
      percent: (json['percent'] as num?)?.toInt(),
      quoteId: json['quoteId'] as String?,
    );

Map<String, dynamic> _$QuoteAllQueryParametersToJson(
    QuoteAllQueryParameters instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('calculationMethod', instance.calculationMethod);
  writeNotNull('percent', instance.percent);
  writeNotNull('quoteId', instance.quoteId);
  return val;
}
