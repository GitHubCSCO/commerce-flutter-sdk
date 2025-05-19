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
    AccountPaymentProfile instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uri', instance.uri);
  writeNotNull('properties', instance.properties);
  writeNotNull('id', instance.id);
  writeNotNull('description', instance.description);
  writeNotNull('cardType', instance.cardType);
  writeNotNull('expirationDate', instance.expirationDate);
  writeNotNull('maskedCardNumber', instance.maskedCardNumber);
  writeNotNull('cardIdentifier', instance.cardIdentifier);
  writeNotNull('cardHolderName', instance.cardHolderName);
  writeNotNull('address1', instance.address1);
  writeNotNull('address2', instance.address2);
  writeNotNull('address3', instance.address3);
  writeNotNull('address4', instance.address4);
  writeNotNull('city', instance.city);
  writeNotNull('state', instance.state);
  writeNotNull('postalCode', instance.postalCode);
  writeNotNull('country', instance.country);
  writeNotNull('isDefault', instance.isDefault);
  return val;
}
