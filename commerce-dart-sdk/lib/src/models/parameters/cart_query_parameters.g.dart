// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_query_parameters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$CartQueryParametersToJson(CartQueryParameters instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('page', instance.page);
  writeNotNull('pageSize', instance.pageSize);
  writeNotNull('sort', instance.sort);
  writeNotNull('alsoPurchasedMaxResults', instance.alsoPurchasedMaxResults);
  writeNotNull('forceRecalculation', instance.forceRecalculation);
  writeNotNull('allowInvalidAddress', instance.allowInvalidAddress);
  writeNotNull(
      'expand', JsonEncodingMethods.commaSeparatedJson(instance.expand));
  return val;
}
