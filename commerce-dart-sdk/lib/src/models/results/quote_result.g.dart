// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuoteResult _$QuoteResultFromJson(Map<String, dynamic> json) => QuoteResult(
      quotes: (json['quotes'] as List<dynamic>?)
          ?.map((e) => QuoteDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      salespersonList: (json['salespersonList'] as List<dynamic>?)
          ?.map((e) => SalespersonListDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$QuoteResultToJson(QuoteResult instance) =>
    <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.quotes?.map((e) => e.toJson()).toList() case final value?)
        'quotes': value,
      if (instance.salespersonList?.map((e) => e.toJson()).toList()
          case final value?)
        'salespersonList': value,
      if (instance.pagination?.toJson() case final value?) 'pagination': value,
    };
