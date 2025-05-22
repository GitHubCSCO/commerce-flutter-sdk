// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_price_query_parameter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$ProductPriceQueryParameterToJson(
    ProductPriceQueryParameter instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('productId', instance.productId);
  writeNotNull('unitOfMeasure', instance.unitOfMeasure);
  writeNotNull('qtyOrdered', instance.qtyOrdered);
  writeNotNull('configuration', instance.configuration);
  return val;
}
