// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_product_query_parameters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseProductsQueryParameters _$BaseProductsQueryParametersFromJson(
        Map<String, dynamic> json) =>
    BaseProductsQueryParameters(
      attributeValueIds: (json['attributeValueIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      brandIds: (json['brandIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      categoryId: json['categoryId'] as String?,
      expand: json['expand'] as String?,
      extendedNames: (json['extendedNames'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      filter: json['filter'] as String?,
      includeAttributes: json['includeAttributes'] as String?,
      includeSuggestions: json['includeSuggestions'] as String?,
      names:
          (json['names'] as List<dynamic>?)?.map((e) => e as String).toList(),
      priceFilters: (json['priceFilters'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      productIds: (json['productIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      productLineIds: (json['productLineIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      searchWithin: json['searchWithin'] as String?,
      topSellersCategoryIds: (json['topSellersCategoryIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    )
      ..sort = json['sort'] as String?
      ..page = json['page'] as int?
      ..pageSize = json['pageSize'] as int?;

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
  writeNotNull('expand', instance.expand);
  writeNotNull('categoryId', instance.categoryId);
  writeNotNull('searchWithin', instance.searchWithin);
  writeNotNull('includeSuggestions', instance.includeSuggestions);
  writeNotNull('includeAttributes', instance.includeAttributes);
  writeNotNull('filter', instance.filter);
  return val;
}

ProductsQueryParameters _$ProductsQueryParametersFromJson(
        Map<String, dynamic> json) =>
    ProductsQueryParameters(
      erpNumbers: (json['erpNumbers'] as List<dynamic>?)
          ?.map((e) => e as String?)
          .toList(),
      getAllAttributeFacets: json['getAllAttributeFacets'] as bool?,
      includeAlternateInventory: json['includeAlternateInventory'] as bool?,
      makeBrandUrls: json['makeBrandUrls'] as bool?,
      previouslyPurchasedProducts: json['previouslyPurchasedProducts'] as bool?,
      query: json['query'] as String?,
      replaceProducts: json['replaceProducts'] as bool?,
      stockedItemsOnly: json['stockedItemsOnly'] as bool?,
      topSellersMaxResults: json['topSellersMaxResults'] as int?,
    )
      ..sort = json['sort'] as String?
      ..page = json['page'] as int?
      ..pageSize = json['pageSize'] as int?
      ..productIds = (json['productIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList()
      ..brandIds =
          (json['brandIds'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..productLineIds = (json['productLineIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList()
      ..topSellersCategoryIds =
          (json['topSellersCategoryIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList()
      ..attributeValueIds = (json['attributeValueIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList()
      ..priceFilters = (json['priceFilters'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList()
      ..names =
          (json['names'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..extendedNames = (json['extendedNames'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList()
      ..expand = json['expand'] as String?
      ..categoryId = json['categoryId'] as String?
      ..searchWithin = json['searchWithin'] as String?
      ..includeSuggestions = json['includeSuggestions'] as String?
      ..includeAttributes = json['includeAttributes'] as String?
      ..filter = json['filter'] as String?;

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
  writeNotNull('expand', instance.expand);
  writeNotNull('categoryId', instance.categoryId);
  writeNotNull('searchWithin', instance.searchWithin);
  writeNotNull('includeSuggestions', instance.includeSuggestions);
  writeNotNull('includeAttributes', instance.includeAttributes);
  writeNotNull('filter', instance.filter);
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

ProductsQueryV2Parameters _$ProductsQueryV2ParametersFromJson(
        Map<String, dynamic> json) =>
    ProductsQueryV2Parameters(
      cardId: json['cardId'] as String?,
      includeProductsInSubCategories:
          json['includeProductsInSubCategories'] as bool?,
      maximumPrice: json['maximumPrice'] as num?,
      minimumPrice: json['minimumPrice'] as num?,
      previouslyPurchasedProducts: json['previouslyPurchasedProducts'] as bool?,
      search: json['search'] as String?,
      stockedItemsOnly: json['stockedItemsOnly'] as bool?,
      topSellersPersonaIds: (json['topSellersPersonaIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    )
      ..sort = json['sort'] as String?
      ..page = json['page'] as int?
      ..pageSize = json['pageSize'] as int?
      ..productIds = (json['productIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList()
      ..brandIds =
          (json['brandIds'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..productLineIds = (json['productLineIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList()
      ..topSellersCategoryIds =
          (json['topSellersCategoryIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList()
      ..attributeValueIds = (json['attributeValueIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList()
      ..priceFilters = (json['priceFilters'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList()
      ..names =
          (json['names'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..extendedNames = (json['extendedNames'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList()
      ..expand = json['expand'] as String?
      ..categoryId = json['categoryId'] as String?
      ..searchWithin = json['searchWithin'] as String?
      ..includeSuggestions = json['includeSuggestions'] as String?
      ..includeAttributes = json['includeAttributes'] as String?
      ..filter = json['filter'] as String?;

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
  writeNotNull('expand', instance.expand);
  writeNotNull('categoryId', instance.categoryId);
  writeNotNull('searchWithin', instance.searchWithin);
  writeNotNull('includeSuggestions', instance.includeSuggestions);
  writeNotNull('includeAttributes', instance.includeAttributes);
  writeNotNull('filter', instance.filter);
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
