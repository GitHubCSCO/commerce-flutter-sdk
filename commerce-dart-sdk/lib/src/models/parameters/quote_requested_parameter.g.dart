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
    QuoteRequestedParameter instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('quoteId', instance.quoteId);
  writeNotNull('status', instance.status);
  writeNotNull('expirationDate', instance.expirationDate?.toIso8601String());
  return val;
}
