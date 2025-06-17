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

Map<String, dynamic> _$VmiLocationModelToJson(VmiLocationModel instance) =>
    <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      'id': instance.id,
      if (instance.customerId case final value?) 'customerId': value,
      if (instance.billToId case final value?) 'billToId': value,
      if (instance.shipToId case final value?) 'shipToId': value,
      'name': instance.name,
      'useBins': instance.useBins,
      'isPrimaryLocation': instance.isPrimaryLocation,
      'note': instance.note,
      if (instance.customer?.toJson() case final value?) 'customer': value,
    };
