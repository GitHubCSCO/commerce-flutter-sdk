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
    SalesRepRequesteAQuoteParameters instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('quoteId', instance.quoteId);
  writeNotNull('jobName', instance.jobName);
  writeNotNull('note', instance.note);
  writeNotNull('isJobQuote', instance.isJobQuote);
  writeNotNull('userId', instance.userId);
  return val;
}

RequesteAQuoteParameters _$RequesteAQuoteParametersFromJson(
        Map<String, dynamic> json) =>
    RequesteAQuoteParameters(
      quoteId: json['quoteId'] as String?,
      jobName: json['jobName'] as String?,
      note: json['note'] as String?,
      isJobQuote: json['isJobQuote'] as bool?,
    );

Map<String, dynamic> _$RequesteAQuoteParametersToJson(
    RequesteAQuoteParameters instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('quoteId', instance.quoteId);
  writeNotNull('jobName', instance.jobName);
  writeNotNull('note', instance.note);
  writeNotNull('isJobQuote', instance.isJobQuote);
  return val;
}
