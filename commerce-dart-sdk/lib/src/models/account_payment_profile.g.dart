// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_payment_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountPaymentProfile _$AccountPaymentProfileFromJson(
        Map<String, dynamic> json) =>
    AccountPaymentProfile(
      id: json['id'] as String?,
      description: json['description'] as String?,
      cardType: json['cardType'] as String?,
      expirationDate: json['expirationDate'] as String?,
      maskedCardNumber: json['maskedCardNumber'] as String?,
      cardIdentifier: json['cardIdentifier'] as String?,
      cardHolderName: json['cardHolderName'] as String?,
      address1: json['address1'] as String?,
      address2: json['address2'] as String?,
      address3: json['address3'] as String?,
      address4: json['address4'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      postalCode: json['postalCode'] as String?,
      country: json['country'] as String?,
      isDefault: json['isDefault'] as bool?,
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$AccountPaymentProfileToJson(
        AccountPaymentProfile instance) =>
    <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.id case final value?) 'id': value,
      if (instance.description case final value?) 'description': value,
      if (instance.cardType case final value?) 'cardType': value,
      if (instance.expirationDate case final value?) 'expirationDate': value,
      if (instance.maskedCardNumber case final value?)
        'maskedCardNumber': value,
      if (instance.cardIdentifier case final value?) 'cardIdentifier': value,
      if (instance.cardHolderName case final value?) 'cardHolderName': value,
      if (instance.address1 case final value?) 'address1': value,
      if (instance.address2 case final value?) 'address2': value,
      if (instance.address3 case final value?) 'address3': value,
      if (instance.address4 case final value?) 'address4': value,
      if (instance.city case final value?) 'city': value,
      if (instance.state case final value?) 'state': value,
      if (instance.postalCode case final value?) 'postalCode': value,
      if (instance.country case final value?) 'country': value,
      if (instance.isDefault case final value?) 'isDefault': value,
    };
