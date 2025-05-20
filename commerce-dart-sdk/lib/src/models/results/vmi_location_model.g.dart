// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vmi_location_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VmiLocationModel _$VmiLocationModelFromJson(Map<String, dynamic> json) =>
    VmiLocationModel(
      id: json['id'] as String,
      customerId: json['customerId'] as String?,
      billToId: json['billToId'] as String?,
      shipToId: json['shipToId'] as String?,
      name: json['name'] as String,
      useBins: json['useBins'] as bool,
      isPrimaryLocation: json['isPrimaryLocation'] as bool,
      note: json['note'] as String,
      customer: json['customer'] == null
          ? null
          : Address.fromJson(json['customer'] as Map<String, dynamic>),
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$VmiLocationModelToJson(VmiLocationModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uri', instance.uri);
  writeNotNull('properties', instance.properties);
  val['id'] = instance.id;
  writeNotNull('customerId', instance.customerId);
  writeNotNull('billToId', instance.billToId);
  writeNotNull('shipToId', instance.shipToId);
  val['name'] = instance.name;
  val['useBins'] = instance.useBins;
  val['isPrimaryLocation'] = instance.isPrimaryLocation;
  val['note'] = instance.note;
  writeNotNull('customer', instance.customer?.toJson());
  return val;
}
