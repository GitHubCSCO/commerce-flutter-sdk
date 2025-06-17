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
        CustomerValidationDto instance) =>
    <String, dynamic>{
      if (instance.firstName?.toJson() case final value?) 'firstName': value,
      if (instance.lastName?.toJson() case final value?) 'lastName': value,
      if (instance.companyName?.toJson() case final value?)
        'companyName': value,
      if (instance.attention?.toJson() case final value?) 'attention': value,
      if (instance.address1?.toJson() case final value?) 'address1': value,
      if (instance.address2?.toJson() case final value?) 'address2': value,
      if (instance.address3?.toJson() case final value?) 'address3': value,
      if (instance.address4?.toJson() case final value?) 'address4': value,
      if (instance.country?.toJson() case final value?) 'country': value,
      if (instance.state?.toJson() case final value?) 'state': value,
      if (instance.city?.toJson() case final value?) 'city': value,
      if (instance.postalCode?.toJson() case final value?) 'postalCode': value,
      if (instance.phone?.toJson() case final value?) 'phone': value,
      if (instance.email?.toJson() case final value?) 'email': value,
      if (instance.fax?.toJson() case final value?) 'fax': value,
    };

FieldValidationDto _$FieldValidationDtoFromJson(Map<String, dynamic> json) =>
    FieldValidationDto(
      isDisabled: json['isDisabled'] as bool?,
      isRequired: json['isRequired'] as bool?,
      maxLength: (json['maxLength'] as num?)?.toInt(),
    );

Map<String, dynamic> _$FieldValidationDtoToJson(FieldValidationDto instance) =>
    <String, dynamic>{
      if (instance.isRequired case final value?) 'isRequired': value,
      if (instance.isDisabled case final value?) 'isDisabled': value,
      if (instance.maxLength case final value?) 'maxLength': value,
    };
