// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_quote_update_parameter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$JobQuoteLineUpdateToJson(JobQuoteLineUpdate instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.qtyOrdered case final value?) 'qtyOrdered': value,
    };

Map<String, dynamic> _$JobQuoteUpdateParameterToJson(
        JobQuoteUpdateParameter instance) =>
    <String, dynamic>{
      if (instance.jobQuoteId case final value?) 'jobQuoteId': value,
      if (instance.jobQuoteLineCollection?.map((e) => e.toJson()).toList()
          case final value?)
        'jobQuoteLineCollection': value,
    };
