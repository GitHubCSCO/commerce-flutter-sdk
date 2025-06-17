// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenResult _$TokenResultFromJson(Map<String, dynamic> json) => TokenResult(
      accessToken: json['access_token'] as String?,
      expiresIn: (json['expires_in'] as num?)?.toInt(),
      refreshToken: json['refresh_token'] as String?,
      tokenType: json['token_type'] as String?,
    );

Map<String, dynamic> _$TokenResultToJson(TokenResult instance) =>
    <String, dynamic>{
      if (instance.accessToken case final value?) 'access_token': value,
      if (instance.expiresIn case final value?) 'expires_in': value,
      if (instance.tokenType case final value?) 'token_type': value,
      if (instance.refreshToken case final value?) 'refresh_token': value,
    };
