// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_card_billing_address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreditCardBillingAddress _$CreditCardBillingAddressFromJson(
        Map<String, dynamic> json) =>
    CreditCardBillingAddress(
      address1: json['address1'] as String?,
      address2: json['address2'] as String?,
      city: json['city'] as String?,
      stateAbbreviation: json['stateAbbreviation'] as String?,
      countryAbbreviation: json['countryAbbreviation'] as String?,
      postalCode: json['postalCode'] as String?,
    );

Map<String, dynamic> _$CreditCardBillingAddressToJson(
        CreditCardBillingAddress instance) =>
    <String, dynamic>{
      if (instance.address1 case final value?) 'address1': value,
      if (instance.address2 case final value?) 'address2': value,
      if (instance.city case final value?) 'city': value,
      if (instance.stateAbbreviation case final value?)
        'stateAbbreviation': value,
      if (instance.countryAbbreviation case final value?)
        'countryAbbreviation': value,
      if (instance.postalCode case final value?) 'postalCode': value,
    };
