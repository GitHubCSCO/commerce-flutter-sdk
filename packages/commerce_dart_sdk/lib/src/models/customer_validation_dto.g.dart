// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_validation_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerValidationDto _$CustomerValidationDtoFromJson(
        Map<String, dynamic> json) =>
    CustomerValidationDto(
      address1: json['address1'] == null
          ? null
          : FieldValidationDto.fromJson(
              json['address1'] as Map<String, dynamic>),
      address2: json['address2'] == null
          ? null
          : FieldValidationDto.fromJson(
              json['address2'] as Map<String, dynamic>),
      address3: json['address3'] == null
          ? null
          : FieldValidationDto.fromJson(
              json['address3'] as Map<String, dynamic>),
      address4: json['address4'] == null
          ? null
          : FieldValidationDto.fromJson(
              json['address4'] as Map<String, dynamic>),
      attention: json['attention'] == null
          ? null
          : FieldValidationDto.fromJson(
              json['attention'] as Map<String, dynamic>),
      city: json['city'] == null
          ? null
          : FieldValidationDto.fromJson(json['city'] as Map<String, dynamic>),
      companyName: json['companyName'] == null
          ? null
          : FieldValidationDto.fromJson(
              json['companyName'] as Map<String, dynamic>),
      country: json['country'] == null
          ? null
          : FieldValidationDto.fromJson(
              json['country'] as Map<String, dynamic>),
      email: json['email'] == null
          ? null
          : FieldValidationDto.fromJson(json['email'] as Map<String, dynamic>),
      fax: json['fax'] == null
          ? null
          : FieldValidationDto.fromJson(json['fax'] as Map<String, dynamic>),
      firstName: json['firstName'] == null
          ? null
          : FieldValidationDto.fromJson(
              json['firstName'] as Map<String, dynamic>),
      lastName: json['lastName'] == null
          ? null
          : FieldValidationDto.fromJson(
              json['lastName'] as Map<String, dynamic>),
      phone: json['phone'] == null
          ? null
          : FieldValidationDto.fromJson(json['phone'] as Map<String, dynamic>),
      postalCode: json['postalCode'] == null
          ? null
          : FieldValidationDto.fromJson(
              json['postalCode'] as Map<String, dynamic>),
      state: json['state'] == null
          ? null
          : FieldValidationDto.fromJson(json['state'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CustomerValidationDtoToJson(
    CustomerValidationDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('firstName', instance.firstName?.toJson());
  writeNotNull('lastName', instance.lastName?.toJson());
  writeNotNull('companyName', instance.companyName?.toJson());
  writeNotNull('attention', instance.attention?.toJson());
  writeNotNull('address1', instance.address1?.toJson());
  writeNotNull('address2', instance.address2?.toJson());
  writeNotNull('address3', instance.address3?.toJson());
  writeNotNull('address4', instance.address4?.toJson());
  writeNotNull('country', instance.country?.toJson());
  writeNotNull('state', instance.state?.toJson());
  writeNotNull('city', instance.city?.toJson());
  writeNotNull('postalCode', instance.postalCode?.toJson());
  writeNotNull('phone', instance.phone?.toJson());
  writeNotNull('email', instance.email?.toJson());
  writeNotNull('fax', instance.fax?.toJson());
  return val;
}

FieldValidationDto _$FieldValidationDtoFromJson(Map<String, dynamic> json) =>
    FieldValidationDto(
      isDisabled: json['isDisabled'] as bool?,
      isRequired: json['isRequired'] as bool?,
      maxLength: json['maxLength'] as int?,
    );

Map<String, dynamic> _$FieldValidationDtoToJson(FieldValidationDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('isRequired', instance.isRequired);
  writeNotNull('isDisabled', instance.isDisabled);
  writeNotNull('maxLength', instance.maxLength);
  return val;
}
