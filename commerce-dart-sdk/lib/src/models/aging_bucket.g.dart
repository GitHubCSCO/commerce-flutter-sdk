// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aging_bucket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AgingBucket _$AgingBucketFromJson(Map<String, dynamic> json) => AgingBucket(
      amount: json['amount'] as num?,
      amountDisplay: json['amountDisplay'] as String?,
      label: json['label'] as String?,
    );

Map<String, dynamic> _$AgingBucketToJson(AgingBucket instance) =>
    <String, dynamic>{
      if (instance.amount case final value?) 'amount': value,
      if (instance.amountDisplay case final value?) 'amountDisplay': value,
      if (instance.label case final value?) 'label': value,
    };
