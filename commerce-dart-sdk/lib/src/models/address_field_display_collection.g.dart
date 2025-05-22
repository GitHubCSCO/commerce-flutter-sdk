// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_field_display_collection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressFieldDisplayCollection _$AddressFieldDisplayCollectionFromJson(
        Map<String, dynamic> json) =>
    AddressFieldDisplayCollection(
      address1: json['address1'] == null
          ? null
          : AddressFieldDisplay.fromJson(
              json['address1'] as Map<String, dynamic>),
      address2: json['address2'] == null
          ? null
          : AddressFieldDisplay.fromJson(
              json['address2'] as Map<String, dynamic>),
      address3: json['address3'] == null
          ? null
          : AddressFieldDisplay.fromJson(
              json['address3'] as Map<String, dynamic>),
      address4: json['address4'] == null
          ? null
          : AddressFieldDisplay.fromJson(
              json['address4'] as Map<String, dynamic>),
      attention: json['attention'] == null
          ? null
          : AddressFieldDisplay.fromJson(
              json['attention'] as Map<String, dynamic>),
      city: json['city'] == null
          ? null
          : AddressFieldDisplay.fromJson(json['city'] as Map<String, dynamic>),
      companyName: json['companyName'] == null
          ? null
          : AddressFieldDisplay.fromJson(
              json['companyName'] as Map<String, dynamic>),
      contactFullName: json['contactFullName'] == null
          ? null
          : AddressFieldDisplay.fromJson(
              json['contactFullName'] as Map<String, dynamic>),
      country: json['country'] == null
          ? null
          : AddressFieldDisplay.fromJson(
              json['country'] as Map<String, dynamic>),
      email: json['email'] == null
          ? null
          : AddressFieldDisplay.fromJson(json['email'] as Map<String, dynamic>),
      fax: json['fax'] == null
          ? null
          : AddressFieldDisplay.fromJson(json['fax'] as Map<String, dynamic>),
      firstName: json['firstName'] == null
          ? null
          : AddressFieldDisplay.fromJson(
              json['firstName'] as Map<String, dynamic>),
      lastName: json['lastName'] == null
          ? null
          : AddressFieldDisplay.fromJson(
              json['lastName'] as Map<String, dynamic>),
      phone: json['phone'] == null
          ? null
          : AddressFieldDisplay.fromJson(json['phone'] as Map<String, dynamic>),
      postalCode: json['postalCode'] == null
          ? null
          : AddressFieldDisplay.fromJson(
              json['postalCode'] as Map<String, dynamic>),
      state: json['state'] == null
          ? null
          : AddressFieldDisplay.fromJson(json['state'] as Map<String, dynamic>),
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$AddressFieldDisplayCollectionToJson(
    AddressFieldDisplayCollection instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uri', instance.uri);
  writeNotNull('properties', instance.properties);
  writeNotNull('address1', instance.address1?.toJson());
  writeNotNull('address2', instance.address2?.toJson());
  writeNotNull('address3', instance.address3?.toJson());
  writeNotNull('address4', instance.address4?.toJson());
  writeNotNull('attention', instance.attention?.toJson());
  writeNotNull('city', instance.city?.toJson());
  writeNotNull('companyName', instance.companyName?.toJson());
  writeNotNull('contactFullName', instance.contactFullName?.toJson());
  writeNotNull('country', instance.country?.toJson());
  writeNotNull('email', instance.email?.toJson());
  writeNotNull('fax', instance.fax?.toJson());
  writeNotNull('firstName', instance.firstName?.toJson());
  writeNotNull('lastName', instance.lastName?.toJson());
  writeNotNull('phone', instance.phone?.toJson());
  writeNotNull('postalCode', instance.postalCode?.toJson());
  writeNotNull('state', instance.state?.toJson());
  return val;
}
