// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accounts_receivable.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountsReceivable _$AccountsReceivableFromJson(Map<String, dynamic> json) =>
    AccountsReceivable(
      agingBucketFuture: json['agingBucketFuture'] == null
          ? null
          : AgingBucket.fromJson(
              json['agingBucketFuture'] as Map<String, dynamic>),
      agingBucketTotal: json['agingBucketTotal'] == null
          ? null
          : AgingBucket.fromJson(
              json['agingBucketTotal'] as Map<String, dynamic>),
      agingBuckets: (json['agingBuckets'] as List<dynamic>?)
          ?.map((e) => AgingBucket.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AccountsReceivableToJson(AccountsReceivable instance) =>
    <String, dynamic>{
      if (instance.agingBuckets?.map((e) => e.toJson()).toList()
          case final value?)
        'agingBuckets': value,
      if (instance.agingBucketTotal?.toJson() case final value?)
        'agingBucketTotal': value,
      if (instance.agingBucketFuture?.toJson() case final value?)
        'agingBucketFuture': value,
    };
