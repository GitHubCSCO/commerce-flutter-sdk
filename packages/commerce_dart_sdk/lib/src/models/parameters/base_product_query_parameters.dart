// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'parameters.dart';

part 'base_product_query_parameters.g.dart';

// Doesn't create fromJson
@JsonSerializable(createFactory: false)
class BaseProductsQueryParameters extends BaseQueryParameters {
  BaseProductsQueryParameters({
    this.productIds,
    this.brandIds,
    this.productLineIds,
    this.topSellersCategoryIds,
    this.attributeValueIds,
    this.priceFilters,
    this.names,
    this.extendedNames,
    this.expand,
    this.categoryId,
    this.searchWithin,
    this.includeSuggestions,
    this.includeAttributes,
    this.filter,
  });

  @override
  @JsonKey(defaultValue: 1)
  int? get page => super.page ?? 1;

  @override
  @JsonKey(defaultValue: 16)
  int? get pageSize => super.pageSize ?? 16;

  List<String>? productIds;
  List<String>? brandIds;
  List<String>? productLineIds;
  List<String>? topSellersCategoryIds;
  List<String>? attributeValueIds;

  List<String>? priceFilters;
  List<String>? names;
  List<String>? extendedNames;

  // Similar to [QueryParameter(queryType: QueryListParameterType.CommaSeparated)]
  @JsonKey(toJson: _commaSeparatedJson)
  List<String>? expand;
  static String? _commaSeparatedJson(List<String>? stringList) =>
      stringList?.join(',');

  String? categoryId;
  String? searchWithin;
  String? includeSuggestions;
  String? includeAttributes;
  String? filter;

  @override
  Map<String, dynamic> toJson() => _$BaseProductsQueryParametersToJson(this);
}

// Doesn't create fromJson
@JsonSerializable(createFactory: false)
class ProductsQueryParameters extends BaseProductsQueryParameters {
  ProductsQueryParameters({
    this.erpNumbers,
    this.query,
    this.replaceProducts,
    this.getAllAttributeFacets,
    this.includeAlternateInventory,
    this.makeBrandUrls,
    this.topSellersMaxResults,
    this.previouslyPurchasedProducts,
    this.stockedItemsOnly,
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

// Doesn't create fromJson
@JsonSerializable(createFactory: false)
class ProductsQueryV2Parameters extends BaseProductsQueryParameters {
  ProductsQueryV2Parameters({
    this.search,
    this.includeProductsInSubCategories,
    this.minimumPrice,
    this.maximumPrice,
    this.topSellersPersonaIds,
    this.cardId,
    this.stockedItemsOnly,
    this.previouslyPurchasedProducts,
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
