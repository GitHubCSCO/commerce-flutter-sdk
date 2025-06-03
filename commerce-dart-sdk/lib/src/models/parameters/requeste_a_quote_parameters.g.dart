// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'requeste_a_quote_parameters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SalesRepRequesteAQuoteParameters _$SalesRepRequesteAQuoteParametersFromJson(
        Map<String, dynamic> json) =>
    SalesRepRequesteAQuoteParameters(
      userId: json['userId'] as String?,
      isJobQuote: json['isJobQuote'] as bool?,
      jobName: json['jobName'] as String?,
      note: json['note'] as String?,
      quoteId: json['quoteId'] as String?,
    );

Map<String, dynamic> _$SalesRepRequesteAQuoteParametersToJson(
        SalesRepRequesteAQuoteParameters instance) =>
    <String, dynamic>{
      if (instance.quoteId case final value?) 'quoteId': value,
      if (instance.jobName case final value?) 'jobName': value,
      if (instance.note case final value?) 'note': value,
      if (instance.isJobQuote case final value?) 'isJobQuote': value,
      if (instance.userId case final value?) 'userId': value,
    };

RequesteAQuoteParameters _$RequesteAQuoteParametersFromJson(
        Map<String, dynamic> json) =>
    RequesteAQuoteParameters(
      quoteId: json['quoteId'] as String?,
      jobName: json['jobName'] as String?,
      note: json['note'] as String?,
      isJobQuote: json['isJobQuote'] as bool?,
    );

Map<String, dynamic> _$RequesteAQuoteParametersToJson(
        RequesteAQuoteParameters instance) =>
    <String, dynamic>{
      if (instance.quoteId case final value?) 'quoteId': value,
      if (instance.jobName case final value?) 'jobName': value,
      if (instance.note case final value?) 'note': value,
      if (instance.isJobQuote case final value?) 'isJobQuote': value,
    };
