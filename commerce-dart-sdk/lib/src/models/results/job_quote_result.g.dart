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

Map<String, dynamic> _$JobQuoteResultToJson(JobQuoteResult instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uri', instance.uri);
  writeNotNull('properties', instance.properties);
  writeNotNull(
      'jobQuotes', instance.jobQuotes?.map((e) => e.toJson()).toList());
  writeNotNull('pagination', instance.pagination?.toJson());
  return val;
}
