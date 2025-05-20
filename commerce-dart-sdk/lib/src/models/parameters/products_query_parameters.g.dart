// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_query_parameters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$BaseProductsQueryParametersToJson(
    BaseProductsQueryParameters instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('sort', instance.sort);
  writeNotNull('page', instance.page);
  writeNotNull('pageSize', instance.pageSize);
  writeNotNull('productIds', instance.productIds);
  writeNotNull('brandIds', instance.brandIds);
  writeNotNull('productLineIds', instance.productLineIds);
  writeNotNull('topSellersCategoryIds', instance.topSellersCategoryIds);
  writeNotNull('attributeValueIds', instance.attributeValueIds);
  writeNotNull('priceFilters', instance.priceFilters);
  writeNotNull('names', instance.names);
  writeNotNull('extendedNames', instance.extendedNames);
  writeNotNull(
      'expand', JsonEncodingMethods.commaSeparatedJson(instance.expand));
  writeNotNull('categoryId', instance.categoryId);
  writeNotNull('searchWithin', instance.searchWithin);
  writeNotNull('includeSuggestions', instance.includeSuggestions);
  writeNotNull('includeAttributes', instance.includeAttributes);
  writeNotNull('filter', instance.filter);
  writeNotNull('applyPersonalization', instance.applyPersonalization);
  return val;
}

Map<String, dynamic> _$ProductsQueryParametersToJson(
    ProductsQueryParameters instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('sort', instance.sort);
  writeNotNull('page', instance.page);
  writeNotNull('pageSize', instance.pageSize);
  writeNotNull('productIds', instance.productIds);
  writeNotNull('brandIds', instance.brandIds);
  writeNotNull('productLineIds', instance.productLineIds);
  writeNotNull('topSellersCategoryIds', instance.topSellersCategoryIds);
  writeNotNull('attributeValueIds', instance.attributeValueIds);
  writeNotNull('priceFilters', instance.priceFilters);
  writeNotNull('names', instance.names);
  writeNotNull('extendedNames', instance.extendedNames);
  writeNotNull(
      'expand', JsonEncodingMethods.commaSeparatedJson(instance.expand));
  writeNotNull('categoryId', instance.categoryId);
  writeNotNull('searchWithin', instance.searchWithin);
  writeNotNull('includeSuggestions', instance.includeSuggestions);
  writeNotNull('includeAttributes', instance.includeAttributes);
  writeNotNull('filter', instance.filter);
  writeNotNull('applyPersonalization', instance.applyPersonalization);
  writeNotNull('erpNumbers', instance.erpNumbers);
  writeNotNull('query', instance.query);
  writeNotNull('replaceProducts', instance.replaceProducts);
  writeNotNull('getAllAttributeFacets', instance.getAllAttributeFacets);
  writeNotNull('includeAlternateInventory', instance.includeAlternateInventory);
  writeNotNull('makeBrandUrls', instance.makeBrandUrls);
  writeNotNull('topSellersMaxResults', instance.topSellersMaxResults);
  writeNotNull(
      'previouslyPurchasedProducts', instance.previouslyPurchasedProducts);
  writeNotNull('stockedItemsOnly', instance.stockedItemsOnly);
  return val;
}

Map<String, dynamic> _$ProductsQueryV2ParametersToJson(
    ProductsQueryV2Parameters instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('sort', instance.sort);
  writeNotNull('page', instance.page);
  writeNotNull('pageSize', instance.pageSize);
  writeNotNull('productIds', instance.productIds);
  writeNotNull('brandIds', instance.brandIds);
  writeNotNull('productLineIds', instance.productLineIds);
  writeNotNull('topSellersCategoryIds', instance.topSellersCategoryIds);
  writeNotNull('attributeValueIds', instance.attributeValueIds);
  writeNotNull('priceFilters', instance.priceFilters);
  writeNotNull('names', instance.names);
  writeNotNull('extendedNames', instance.extendedNames);
  writeNotNull(
      'expand', JsonEncodingMethods.commaSeparatedJson(instance.expand));
  writeNotNull('categoryId', instance.categoryId);
  writeNotNull('searchWithin', instance.searchWithin);
  writeNotNull('includeSuggestions', instance.includeSuggestions);
  writeNotNull('includeAttributes', instance.includeAttributes);
  writeNotNull('filter', instance.filter);
  writeNotNull('applyPersonalization', instance.applyPersonalization);
  writeNotNull('search', instance.search);
  writeNotNull('includeProductsInSubCategories',
      instance.includeProductsInSubCategories);
  writeNotNull('minimumPrice', instance.minimumPrice);
  writeNotNull('maximumPrice', instance.maximumPrice);
  writeNotNull('topSellersPersonaIds', instance.topSellersPersonaIds);
  writeNotNull('cardId', instance.cardId);
  writeNotNull('stockedItemsOnly', instance.stockedItemsOnly);
  writeNotNull(
      'previouslyPurchasedProducts', instance.previouslyPurchasedProducts);
  return val;
}
