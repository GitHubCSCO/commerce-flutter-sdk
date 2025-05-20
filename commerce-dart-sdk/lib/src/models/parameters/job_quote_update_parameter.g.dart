// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_quote_update_parameter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$JobQuoteLineUpdateToJson(JobQuoteLineUpdate instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('qtyOrdered', instance.qtyOrdered);
  return val;
}

Map<String, dynamic> _$JobQuoteUpdateParameterToJson(
    JobQuoteUpdateParameter instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('jobQuoteId', instance.jobQuoteId);
  writeNotNull('jobQuoteLineCollection',
      instance.jobQuoteLineCollection?.map((e) => e.toJson()).toList());
  return val;
}
