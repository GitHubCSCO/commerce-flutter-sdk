// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote_requested_parameter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuoteRequestedParameter _$QuoteRequestedParameterFromJson(
        Map<String, dynamic> json) =>
    QuoteRequestedParameter(
      quoteId: json['quoteId'] as String?,
      status: json['status'] as String?,
      expirationDate: json['expirationDate'] == null
          ? null
          : DateTime.parse(json['expirationDate'] as String),
    );

Map<String, dynamic> _$QuoteRequestedParameterToJson(
        QuoteRequestedParameter instance) =>
    <String, dynamic>{
      if (instance.quoteId case final value?) 'quoteId': value,
      if (instance.status case final value?) 'status': value,
      if (instance.expirationDate?.toIso8601String() case final value?)
        'expirationDate': value,
    };
