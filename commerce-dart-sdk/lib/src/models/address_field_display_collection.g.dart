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
        AddressFieldDisplayCollection instance) =>
    <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.address1?.toJson() case final value?) 'address1': value,
      if (instance.address2?.toJson() case final value?) 'address2': value,
      if (instance.address3?.toJson() case final value?) 'address3': value,
      if (instance.address4?.toJson() case final value?) 'address4': value,
      if (instance.attention?.toJson() case final value?) 'attention': value,
      if (instance.city?.toJson() case final value?) 'city': value,
      if (instance.companyName?.toJson() case final value?)
        'companyName': value,
      if (instance.contactFullName?.toJson() case final value?)
        'contactFullName': value,
      if (instance.country?.toJson() case final value?) 'country': value,
      if (instance.email?.toJson() case final value?) 'email': value,
      if (instance.fax?.toJson() case final value?) 'fax': value,
      if (instance.firstName?.toJson() case final value?) 'firstName': value,
      if (instance.lastName?.toJson() case final value?) 'lastName': value,
      if (instance.phone?.toJson() case final value?) 'phone': value,
      if (instance.postalCode?.toJson() case final value?) 'postalCode': value,
      if (instance.state?.toJson() case final value?) 'state': value,
    };
