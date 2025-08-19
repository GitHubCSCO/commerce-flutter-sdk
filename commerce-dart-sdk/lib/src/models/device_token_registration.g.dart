// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_token_registration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceTokenRegistrationParameters _$DeviceTokenRegistrationParametersFromJson(
        Map<String, dynamic> json) =>
    DeviceTokenRegistrationParameters(
      deviceToken: json['deviceToken'] as String?,
    );

Map<String, dynamic> _$DeviceTokenRegistrationParametersToJson(
        DeviceTokenRegistrationParameters instance) =>
    <String, dynamic>{
      if (instance.deviceToken case final value?) 'deviceToken': value,
    };

DeviceTokenResponse _$DeviceTokenResponseFromJson(Map<String, dynamic> json) =>
    DeviceTokenResponse(
      success: json['success'] as bool?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$DeviceTokenResponseToJson(
        DeviceTokenResponse instance) =>
    <String, dynamic>{
      if (instance.success case final value?) 'success': value,
      if (instance.message case final value?) 'message': value,
    };
