// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_base.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrorResponse _$ErrorResponseFromJson(Map<String, dynamic> json) =>
    ErrorResponse(
      error: json['error'] as String?,
      errorDescription: json['error_description'] as String?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$ErrorResponseToJson(ErrorResponse instance) =>
    <String, dynamic>{
      if (instance.message case final value?) 'message': value,
      if (instance.error case final value?) 'error': value,
      if (instance.errorDescription case final value?)
        'error_description': value,
    };
