import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'products_query_parameters.g.dart';

/// The base class for all products related query parameters
///
/// Doesn't create [fromJson].
/// [JsonSerializable] is required to convert an object to a map
/// while requesting with an [Uri], the [queryparameters] need to be a map
/// so by using [Uri("...", queryParameter: BaseProductsQueryParameters.toJson())]
/// the object is automatically converted to be used as query parameter.
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
    this.applyPersonalization,
    super.page,
    super.pageSize,
    super.sort,
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

  List<int>? priceFilters;
  List<String>? names;
  List<String>? extendedNames;

  // Similar to [QueryParameter(queryType: QueryListParameterType.CommaSeparated)]
  @JsonKey(toJson: JsonEncodingMethods.commaSeparatedJson)
  List<String>? expand;

  String? categoryId;
  String? searchWithin;
  String? includeSuggestions;
  String? includeAttributes;
  String? filter;

  bool? applyPersonalization;

  @override
  Map<String, dynamic> toJson() =>
      JsonEncodingMethods.convertAttributesToString(
          _$BaseProductsQueryParametersToJson(this));
}

/// The class for all products query parameters (V2 API)
@JsonSerializable(createFactory: false)
class ProductsQueryParameters extends BaseProductsQueryParameters {
  ProductsQueryParameters({
    this.search,
    this.productNumbers,
    this.includeProductsInSubCategories,
    this.minimumPrice,
    this.maximumPrice,
    this.topSellersPersonaIds,
    this.cartId,
    this.pageToken,
    this.relevancy,
    this.stockedItemsOnly,
    this.previouslyPurchasedProducts,
    super.attributeValueIds,
    super.brandIds,
    super.categoryId,
    super.expand,
    super.extendedNames,
    super.filter,
    super.includeAttributes,
    super.includeSuggestions,
    super.names,
    super.priceFilters,
    super.productIds,
    super.productLineIds,
    super.searchWithin,
    super.topSellersCategoryIds,
    super.page,
    super.pageSize,
    super.sort,
    super.applyPersonalization,
  });

  String? search;
  List<String>? productNumbers;
  bool? includeProductsInSubCategories;
  num? minimumPrice;
  num? maximumPrice;
  List<String>? topSellersPersonaIds;
  String? cartId;
  String? pageToken;
  String? relevancy;
  bool? stockedItemsOnly;
  bool? previouslyPurchasedProducts;

  @override
  Map<String, dynamic> toJson() =>
      JsonEncodingMethods.convertAttributesToString(
          _$ProductsQueryParametersToJson(this));
}
