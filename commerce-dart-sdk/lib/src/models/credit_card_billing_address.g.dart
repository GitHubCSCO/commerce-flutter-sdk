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
    CreditCardBillingAddress instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('address1', instance.address1);
  writeNotNull('address2', instance.address2);
  writeNotNull('city', instance.city);
  writeNotNull('stateAbbreviation', instance.stateAbbreviation);
  writeNotNull('countryAbbreviation', instance.countryAbbreviation);
  writeNotNull('postalCode', instance.postalCode);
  return val;
}
