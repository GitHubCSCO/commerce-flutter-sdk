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
      'amount': instance.amount,
      'amountDisplay': instance.amountDisplay,
      'label': instance.label,
    };
