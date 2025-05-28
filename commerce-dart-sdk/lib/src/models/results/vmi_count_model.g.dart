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

Map<String, dynamic> _$VmiCountModelToJson(VmiCountModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uri', instance.uri);
  writeNotNull('properties', instance.properties);
  writeNotNull('id', instance.id);
  val['vmiBinId'] = instance.vmiBinId;
  writeNotNull('productId', instance.productId);
  writeNotNull('count', instance.count);
  writeNotNull('createdBy', instance.createdBy);
  return val;
}
