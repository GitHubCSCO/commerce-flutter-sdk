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

  List<String>? priceFilters;
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

  // Automatic conversion of map values ([int], [bool] etc.) to [String]
  // this is required since [toJson()] method converts an object to [Map]
  // and for sending request, the [queryParameters] needs to be set with a [Map]
  // and [queryParameters] Map cannot have any value that is in types like [int] or [bool]
  @override
  Map<String, dynamic> toJson() =>
      JsonEncodingMethods.convertAttributesToString(
          _$BaseProductsQueryParametersToJson(this));
}

/// The class for all products V1 related query parameters
///
/// Doesn't create [fromJson].
/// [JsonSerializable] is required to convert an object to a map
/// while requesting with an [Uri], the [queryparameters] need to be a map
/// so by using [Uri("...", queryParameter: ProductsQueryParameters.toJson())]
/// the object is automatically converted to be used as query parameter.
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

  List<String?>? erpNumbers;
  String? query;
  bool? replaceProducts;
  bool? getAllAttributeFacets;
  bool? includeAlternateInventory;
  bool? makeBrandUrls;
  int? topSellersMaxResults;
  bool? previouslyPurchasedProducts;
  bool? stockedItemsOnly;

  //  Automatic conversion of map values ([int], [bool] etc.) to [String]
  //  this is required since [toJson()] method converts an object to [Map]
  //  and for sending request, the [queryParameters] needs to be set with a [Map]
  //  and [queryParameters] Map cannot have any value that is in types like [int] or [bool]
  @override
  Map<String, dynamic> toJson() =>
      JsonEncodingMethods.convertAttributesToString(
          _$ProductsQueryParametersToJson(this));
}

/// The class for all products V2 related query parameters
///
/// Doesn't create [fromJson].
/// [JsonSerializable] is required to convert an object to a map
/// while requesting with an [Uri], the [queryparameters] need to be a map
/// so by using [Uri("...", queryParameter: ProductsQueryV2Parameters.toJson())]
/// the object is automatically converted to be used as query parameter.
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
  bool? includeProductsInSubCategories;
  num? minimumPrice;
  num? maximumPrice;
  List<String>? topSellersPersonaIds;
  String? cardId;
  bool? stockedItemsOnly;
  bool? previouslyPurchasedProducts;

  // Automatic conversion of map values ([int], [bool] etc.) to [String]
  // this is required since [toJson()] method converts an object to [Map]
  // and for sending request, the [queryParameters] needs to be set with a [Map]
  // and [queryParameters] Map cannot have any value that is in types like [int] or [bool]
  @override
  Map<String, dynamic> toJson() =>
      JsonEncodingMethods.convertAttributesToString(
          _$ProductsQueryV2ParametersToJson(this));
}
