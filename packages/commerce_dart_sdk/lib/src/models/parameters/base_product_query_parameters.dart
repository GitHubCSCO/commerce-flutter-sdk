import 'package:json_annotation/json_annotation.dart';
import 'parameters.dart';

part 'base_product_query_parameters.g.dart';

@JsonSerializable()
class BaseProductsQueryParameters extends BaseQueryParameters {
  BaseProductsQueryParameters({
    this.attributeValueIds,
    this.brandIds,
    this.categoryId,
    this.expand,
    this.extendedNames,
    this.filter,
    this.includeAttributes,
    this.includeSuggestions,
    this.names,
    this.priceFilters,
    this.productIds,
    this.productLineIds,
    this.searchWithin,
    this.topSellersCategoryIds,
  });

  int? _page = 1;

  @override
  int? get page => _page;

  @override
  set page(int? value) {
    _page = value;
  }

  int? _pageSize = 16;

  @override
  int? get pageSize => _pageSize;

  @override
  set pageSize(int? value) {
    _pageSize = value;
  }

  List<String>? productIds;
  List<String>? brandIds;
  List<String>? productLineIds;
  List<String>? topSellersCategoryIds;
  List<String>? attributeValueIds;

  List<String>? priceFilters;
  List<String>? names;
  List<String>? extendedNames;

  // [QueryParameter(queryType: QueryListParameterType.CommaSeparated)]
  String? expand;

  String? categoryId;
  String? searchWithin;
  String? includeSuggestions;
  String? includeAttributes;
  String? filter;

  @override
  Map<String, dynamic> toJson() => _$BaseProductsQueryParametersToJson(this);
}

@JsonSerializable()
class ProductsQueryParameters extends BaseProductsQueryParameters {
  ProductsQueryParameters({
    this.erpNumbers,
    this.getAllAttributeFacets,
    this.includeAlternateInventory,
    this.makeBrandUrls,
    this.previouslyPurchasedProducts,
    this.query,
    this.replaceProducts,
    this.stockedItemsOnly,
    this.topSellersMaxResults,
  });

  List<String?>? erpNumbers;
  String? query;
  bool? replaceProducts;
  bool? getAllAttributeFacets;
  bool? includeAlternateInventory;
  bool? makeBrandUrls;
  int? topSellersMaxResults;
  bool? previouslyPurchasedProducts;
  bool? stockedItemsOnly;

  @override
  Map<String, dynamic> toJson() => _$ProductsQueryParametersToJson(this);
}

@JsonSerializable()
class ProductsQueryV2Parameters extends BaseProductsQueryParameters {
  ProductsQueryV2Parameters({
    this.cardId,
    this.includeProductsInSubCategories,
    this.maximumPrice,
    this.minimumPrice,
    this.previouslyPurchasedProducts,
    this.search,
    this.stockedItemsOnly,
    this.topSellersPersonaIds,
  });

  String? search;
  bool? includeProductsInSubCategories;
  num? minimumPrice;
  num? maximumPrice;
  List<String>? topSellersPersonaIds;
  String? cardId;
  bool? stockedItemsOnly;
  bool? previouslyPurchasedProducts;

  @override
  Map<String, dynamic> toJson() => _$ProductsQueryV2ParametersToJson(this);
}
