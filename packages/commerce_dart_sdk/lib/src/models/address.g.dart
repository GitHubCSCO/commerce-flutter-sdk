// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      address1: json['address1'] as String?,
      address2: json['address2'] as String?,
      address3: json['address3'] as String?,
      address4: json['address4'] as String?,
      attention: json['attention'] as String?,
      city: json['city'] as String?,
      companyName: json['companyName'] as String?,
      country: json['country'] == null
          ? null
          : Country.fromJson(json['country'] as Map<String, dynamic>),
      customerName: json['customerName'] as String?,
      customerNumber: json['customerNumber'] as String?,
      customerSequence: json['customerSequence'] as String?,
      email: json['email'] as String?,
      fax: json['fax'] as String?,
      firstName: json['firstName'] as String?,
      fullAddress: json['fullAddress'] as String?,
      id: json['id'] as String?,
      isVmiLocation: json['isVmiLocation'] as String?,
      label: json['label'] as String?,
      lastName: json['lastName'] as String?,
      phone: json['phone'] as String?,
      postalCode: json['postalCode'] as String?,
      state: json['state'] == null
          ? null
          : State.fromJson(json['state'] as Map<String, dynamic>),
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'uri': instance.uri,
      'properties': instance.properties,
      'id': instance.id,
      'customerNumber': instance.customerNumber,
      'customerSequence': instance.customerSequence,
      'customerName': instance.customerName,
      'label': instance.label,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'companyName': instance.companyName,
      'attention': instance.attention,
      'address1': instance.address1,
      'address2': instance.address2,
      'address3': instance.address3,
      'address4': instance.address4,
      'city': instance.city,
      'postalCode': instance.postalCode,
      'state': instance.state?.toJson(),
      'country': instance.country?.toJson(),
      'phone': instance.phone,
      'fullAddress': instance.fullAddress,
      'email': instance.email,
      'fax': instance.fax,
      'isVmiLocation': instance.isVmiLocation,
    };
