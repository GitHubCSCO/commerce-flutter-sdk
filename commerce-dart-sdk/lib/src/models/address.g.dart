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
      isVmiLocation: json['isVmiLocation'] as bool?,
      label: json['label'] as String?,
      lastName: json['lastName'] as String?,
      phone: json['phone'] as String?,
      postalCode: json['postalCode'] as String?,
      state: json['state'] == null
          ? null
          : StateModel.fromJson(json['state'] as Map<String, dynamic>),
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$AddressToJson(Address instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uri', instance.uri);
  writeNotNull('properties', instance.properties);
  writeNotNull('id', instance.id);
  writeNotNull('customerNumber', instance.customerNumber);
  writeNotNull('customerSequence', instance.customerSequence);
  writeNotNull('customerName', instance.customerName);
  writeNotNull('label', instance.label);
  writeNotNull('firstName', instance.firstName);
  writeNotNull('lastName', instance.lastName);
  writeNotNull('companyName', instance.companyName);
  writeNotNull('attention', instance.attention);
  writeNotNull('address1', instance.address1);
  writeNotNull('address2', instance.address2);
  writeNotNull('address3', instance.address3);
  writeNotNull('address4', instance.address4);
  writeNotNull('city', instance.city);
  writeNotNull('postalCode', instance.postalCode);
  writeNotNull('state', instance.state?.toJson());
  writeNotNull('country', instance.country?.toJson());
  writeNotNull('phone', instance.phone);
  writeNotNull('fullAddress', instance.fullAddress);
  writeNotNull('email', instance.email);
  writeNotNull('fax', instance.fax);
  writeNotNull('isVmiLocation', instance.isVmiLocation);
  return val;
}
