// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_field_display.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressFieldDisplay _$AddressFieldDisplayFromJson(Map<String, dynamic> json) =>
    AddressFieldDisplay(
      displayName: json['displayName'] as String?,
      isVisible: json['isVisible'] as bool?,
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$AddressFieldDisplayToJson(
        AddressFieldDisplay instance) =>
    <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.displayName case final value?) 'displayName': value,
      if (instance.isVisible case final value?) 'isVisible': value,
    };
