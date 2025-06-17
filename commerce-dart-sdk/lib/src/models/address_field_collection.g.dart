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
        AddressFieldCollection instance) =>
    <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.billToAddressFields?.toJson() case final value?)
        'billToAddressFields': value,
      if (instance.shipToAddressFields?.toJson() case final value?)
        'shipToAddressFields': value,
    };
