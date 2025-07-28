// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ship_to.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShipTo _$ShipToFromJson(Map<String, dynamic> json) => ShipTo(
      isDefault: json['isDefault'] as bool?,
      isNew: json['isNew'] as bool?,
      oneTimeAddress: json['oneTimeAddress'] as bool?,
      validation: json['validation'] == null
          ? null
          : CustomerValidationDto.fromJson(
              json['validation'] as Map<String, dynamic>),
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      )
      ..id = json['id'] as String?
      ..customerNumber = json['customerNumber'] as String?
      ..customerSequence = json['customerSequence'] as String?
      ..customerName = json['customerName'] as String?
      ..label = json['label'] as String?
      ..firstName = json['firstName'] as String?
      ..lastName = json['lastName'] as String?
      ..companyName = json['companyName'] as String?
      ..attention = json['attention'] as String?
      ..address1 = json['address1'] as String?
      ..address2 = json['address2'] as String?
      ..address3 = json['address3'] as String?
      ..address4 = json['address4'] as String?
      ..city = json['city'] as String?
      ..postalCode = json['postalCode'] as String?
      ..state = json['state'] == null
          ? null
          : StateModel.fromJson(json['state'] as Map<String, dynamic>)
      ..country = json['country'] == null
          ? null
          : Country.fromJson(json['country'] as Map<String, dynamic>)
      ..phone = json['phone'] as String?
      ..fullAddress = json['fullAddress'] as String?
      ..email = json['email'] as String?
      ..fax = json['fax'] as String?
      ..isVmiLocation = json['isVmiLocation'] as bool?;

Map<String, dynamic> _$ShipToToJson(ShipTo instance) => <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.id case final value?) 'id': value,
      if (instance.customerNumber case final value?) 'customerNumber': value,
      if (instance.customerSequence case final value?)
        'customerSequence': value,
      if (instance.customerName case final value?) 'customerName': value,
      if (instance.label case final value?) 'label': value,
      if (instance.firstName case final value?) 'firstName': value,
      if (instance.lastName case final value?) 'lastName': value,
      if (instance.companyName case final value?) 'companyName': value,
      if (instance.attention case final value?) 'attention': value,
      if (instance.address1 case final value?) 'address1': value,
      if (instance.address2 case final value?) 'address2': value,
      if (instance.address3 case final value?) 'address3': value,
      if (instance.address4 case final value?) 'address4': value,
      if (instance.city case final value?) 'city': value,
      if (instance.postalCode case final value?) 'postalCode': value,
      if (instance.state?.toJson() case final value?) 'state': value,
      if (instance.country?.toJson() case final value?) 'country': value,
      if (instance.phone case final value?) 'phone': value,
      if (instance.fullAddress case final value?) 'fullAddress': value,
      if (instance.email case final value?) 'email': value,
      if (instance.fax case final value?) 'fax': value,
      if (instance.isVmiLocation case final value?) 'isVmiLocation': value,
      if (instance.isNew case final value?) 'isNew': value,
      if (instance.oneTimeAddress case final value?) 'oneTimeAddress': value,
      if (instance.validation?.toJson() case final value?) 'validation': value,
      if (instance.isDefault case final value?) 'isDefault': value,
    };
