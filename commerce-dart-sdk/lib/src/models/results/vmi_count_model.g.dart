// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vmi_count_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VmiCountModel _$VmiCountModelFromJson(Map<String, dynamic> json) =>
    VmiCountModel(
      id: json['id'] as String?,
      vmiBinId: json['vmiBinId'] as String,
      productId: json['productId'] as String?,
      count: (json['count'] as num?)?.toDouble(),
      createdBy: json['createdBy'] as String?,
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$VmiCountModelToJson(VmiCountModel instance) =>
    <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.id case final value?) 'id': value,
      'vmiBinId': instance.vmiBinId,
      if (instance.productId case final value?) 'productId': value,
      if (instance.count case final value?) 'count': value,
      if (instance.createdBy case final value?) 'createdBy': value,
    };
