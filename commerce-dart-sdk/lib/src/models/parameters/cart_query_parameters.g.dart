// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_query_parameters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$CartQueryParametersToJson(
        CartQueryParameters instance) =>
    <String, dynamic>{
      if (instance.page case final value?) 'page': value,
      if (instance.pageSize case final value?) 'pageSize': value,
      if (instance.sort case final value?) 'sort': value,
      if (instance.alsoPurchasedMaxResults case final value?)
        'alsoPurchasedMaxResults': value,
      if (instance.forceRecalculation case final value?)
        'forceRecalculation': value,
      if (instance.allowInvalidAddress case final value?)
        'allowInvalidAddress': value,
      if (JsonEncodingMethods.commaSeparatedJson(instance.expand)
          case final value?)
        'expand': value,
    };
