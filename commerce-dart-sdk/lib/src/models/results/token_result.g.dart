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

Map<String, dynamic> _$TokenResultToJson(TokenResult instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('access_token', instance.accessToken);
  writeNotNull('expires_in', instance.expiresIn);
  writeNotNull('token_type', instance.tokenType);
  writeNotNull('refresh_token', instance.refreshToken);
  return val;
}
