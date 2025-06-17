// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountResult _$AccountResultFromJson(Map<String, dynamic> json) =>
    AccountResult(
      accounts: (json['accounts'] as List<dynamic>?)
          ?.map((e) => Account.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$AccountResultToJson(AccountResult instance) =>
    <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.accounts?.map((e) => e.toJson()).toList() case final value?)
        'accounts': value,
      if (instance.pagination?.toJson() case final value?) 'pagination': value,
    };
