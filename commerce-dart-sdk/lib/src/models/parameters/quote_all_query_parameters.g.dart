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
        QuoteAllQueryParameters instance) =>
    <String, dynamic>{
      if (instance.calculationMethod case final value?)
        'calculationMethod': value,
      if (instance.percent case final value?) 'percent': value,
      if (instance.quoteId case final value?) 'quoteId': value,
    };
