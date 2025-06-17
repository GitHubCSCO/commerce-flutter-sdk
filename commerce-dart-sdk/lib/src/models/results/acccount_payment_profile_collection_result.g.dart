// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'acccount_payment_profile_collection_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountPaymentProfileCollectionResult
    _$AccountPaymentProfileCollectionResultFromJson(
            Map<String, dynamic> json) =>
        AccountPaymentProfileCollectionResult(
          accountPaymentProfiles:
              (json['accountPaymentProfiles'] as List<dynamic>?)
                  ?.map((e) =>
                      AccountPaymentProfile.fromJson(e as Map<String, dynamic>))
                  .toList(),
          pagination: json['pagination'] == null
              ? null
              : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
        )
          ..uri = json['uri'] as String?
          ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String?),
          );

Map<String, dynamic> _$AccountPaymentProfileCollectionResultToJson(
        AccountPaymentProfileCollectionResult instance) =>
    <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.accountPaymentProfiles?.map((e) => e.toJson()).toList()
          case final value?)
        'accountPaymentProfiles': value,
      if (instance.pagination?.toJson() case final value?) 'pagination': value,
    };
