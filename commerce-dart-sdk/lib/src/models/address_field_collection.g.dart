// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_field_collection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressFieldCollection _$AddressFieldCollectionFromJson(
        Map<String, dynamic> json) =>
    AddressFieldCollection(
      billToAddressFields: json['billToAddressFields'] == null
          ? null
          : AddressFieldDisplayCollection.fromJson(
              json['billToAddressFields'] as Map<String, dynamic>),
      shipToAddressFields: json['shipToAddressFields'] == null
          ? null
          : AddressFieldDisplayCollection.fromJson(
              json['shipToAddressFields'] as Map<String, dynamic>),
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$AddressFieldCollectionToJson(
    AddressFieldCollection instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uri', instance.uri);
  writeNotNull('properties', instance.properties);
  writeNotNull('billToAddressFields', instance.billToAddressFields?.toJson());
  writeNotNull('shipToAddressFields', instance.shipToAddressFields?.toJson());
  return val;
}
