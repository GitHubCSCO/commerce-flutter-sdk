import 'package:commerce_dart_sdk/commerce_dart_sdk.dart';

part 'product_query_parameters.g.dart';

@JsonSerializable(createFactory: false)
class ProductQueryParameters extends BaseQueryParameters {
  String? productId;

  String? categoryId;

  bool? replaceProducts;

  String? unitOfMeasure;

  double? qtyOrdered;

  bool? addToRecentlyViewed;

  bool? applyPersonalization;

  int? alsoPurchasedMaxResults;

  bool? includeAlternateInventory;

  String? includeAttributes;

  /// Options: alsopurchased, warehouses
  /// Since it is only a single element, no need to use comma separated
  // Similar to [QueryParameter(queryType: QueryListParameterType.CommaSeparated)]
  // @JsonKey(toJson: _commaSeparatedJson)
  String? expand;
  // static String? _commaSeparatedJson(List<String>? stringList) =>
  //     stringList?.join(',');

  List<String>? configuration;

  ProductQueryParameters({
    this.productId,
    this.categoryId,
    this.replaceProducts,
    this.unitOfMeasure,
    this.qtyOrdered,
    this.addToRecentlyViewed,
    this.applyPersonalization,
    this.alsoPurchasedMaxResults,
    this.includeAlternateInventory,
    this.includeAttributes,
    this.expand,
    this.configuration,
    super.page,
    super.pageSize,
    super.sort,
  });

  @override
  Map<String, dynamic> toJson() =>
      JsonEncodingMethods.convertAttributesToString(
          _$ProductQueryParametersToJson(this));
}
