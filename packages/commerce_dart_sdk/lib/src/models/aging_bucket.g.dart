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

Map<String, dynamic> _$AgingBucketToJson(AgingBucket instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('amount', instance.amount);
  writeNotNull('amountDisplay', instance.amountDisplay);
  writeNotNull('label', instance.label);
  return val;
}
