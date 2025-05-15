// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_ex_config_query_parameters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$TokenExConfigQueryParametersToJson(
    TokenExConfigQueryParameters instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('page', instance.page);
  writeNotNull('pageSize', instance.pageSize);
  writeNotNull('sort', instance.sort);
  writeNotNull('token', instance.token);
  writeNotNull('origin', instance.origin);
  writeNotNull('isECheck', instance.isECheck);
  return val;
}
