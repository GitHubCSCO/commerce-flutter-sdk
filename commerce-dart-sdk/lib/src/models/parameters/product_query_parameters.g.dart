// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_query_parameters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$ProductQueryParametersToJson(
    ProductQueryParameters instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('page', instance.page);
  writeNotNull('pageSize', instance.pageSize);
  writeNotNull('sort', instance.sort);
  writeNotNull('productId', instance.productId);
  writeNotNull('categoryId', instance.categoryId);
  writeNotNull('replaceProducts', instance.replaceProducts);
  writeNotNull('unitOfMeasure', instance.unitOfMeasure);
  writeNotNull('qtyOrdered', instance.qtyOrdered);
  writeNotNull('addToRecentlyViewed', instance.addToRecentlyViewed);
  writeNotNull('applyPersonalization', instance.applyPersonalization);
  writeNotNull('alsoPurchasedMaxResults', instance.alsoPurchasedMaxResults);
  writeNotNull('includeAlternateInventory', instance.includeAlternateInventory);
  writeNotNull('includeAttributes', instance.includeAttributes);
  writeNotNull('expand', instance.expand);
  writeNotNull('configuration', instance.configuration);
  return val;
}
