// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_profile_query_parameters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$PaymentProfileQueryParametersToJson(
    PaymentProfileQueryParameters instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('page', instance.page);
  writeNotNull('pageSize', instance.pageSize);
  writeNotNull('sort', instance.sort);
  writeNotNull(
      'expand', JsonEncodingMethods.commaSeparatedJson(instance.expand));
  return val;
}
