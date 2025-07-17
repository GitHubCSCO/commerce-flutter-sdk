// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_quote_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobQuoteResult _$JobQuoteResultFromJson(Map<String, dynamic> json) =>
    JobQuoteResult(
      jobQuotes: (json['jobQuotes'] as List<dynamic>?)
          ?.map((e) => JobQuoteDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$JobQuoteResultToJson(JobQuoteResult instance) =>
    <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.jobQuotes?.map((e) => e.toJson()).toList() case final value?)
        'jobQuotes': value,
      if (instance.pagination?.toJson() case final value?) 'pagination': value,
    };
