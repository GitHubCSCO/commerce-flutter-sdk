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

Map<String, dynamic> _$AddressFieldDisplayToJson(AddressFieldDisplay instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uri', instance.uri);
  writeNotNull('properties', instance.properties);
  writeNotNull('displayName', instance.displayName);
  writeNotNull('isVisible', instance.isVisible);
  return val;
}
