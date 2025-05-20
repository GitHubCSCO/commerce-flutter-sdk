import 'models.dart';

part 'product_price.g.dart';

@JsonSerializable(explicitToJson: true)
class ProductPrice extends BaseModel {
  ProductPrice({
    this.actualBreakPrices,
    this.actualPrice,
    this.actualPriceDisplay,
    this.additionalResults,
    this.extendedActualPrice,
    this.extendedActualPriceDisplay,
    this.extendedRegularPrice,
    this.extendedRegularPriceDisplay,
    this.extendedUnitListPrice,
    this.extendedUnitListPriceDisplay,
    this.extendedUnitNetPrice,
    this.extendedUnitNetPriceDisplay,
    this.extendedUnitRegularPrice,
    this.extendedUnitRegularPriceDisplay,
    this.isOnSale,
    this.productId,
    this.quoteRequired,
    this.regularBreakPrices,
    this.regularPrice,
    this.regularPriceDisplay,
    this.requiresRealTimePrice,
    this.unitCost,
    this.unitCostDisplay,
    this.unitListBreakPrices,
    this.unitListPrice,
    this.unitListPriceDisplay,
    this.unitNetPrice,
    this.unitNetPriceDisplay,
    this.unitOfMeasure,
    this.unitRegularBreakPrices,
    this.unitRegularPrice,
    this.unitRegularPriceDisplay,
    this.vatAmount,
    this.vatAmountDisplay,
    this.vatRate,
  });

  String? productId;

  /// Gets or sets a value indicating whether the Product is calculated to be on sale
  bool? isOnSale;

  /// Get or sets whether this pricing is empty and requires call to fetch realtime prices
  bool? requiresRealTimePrice = false;

  /// Gets or sets a value indicating whether quote required.
  bool? quoteRequired;

  /// Gets or sets the user definable additional results returned from price calculation
  Map<String, String>? additionalResults;

  /// Gets or sets the unit cost.
  num? unitCost;

  /// Gets or sets the unit cost display.
  String? unitCostDisplay;

  /// Gets or sets the unit list price.
  num? unitListPrice;

  /// Gets or sets the unit list price display.
  String? unitListPriceDisplay;

  /// Gets or sets the Quantity UnitListPrice
  num? extendedUnitListPrice;

  /// Gets or sets the Formatted Quantity ListPrice
  String? extendedUnitListPriceDisplay;

  /// Gets or sets the unit regular price.
  num? unitRegularPrice;

  /// Gets or sets the unit regular price display.
  String? unitRegularPriceDisplay;

  /// Gets or sets the Quantity UnitRegularPrice
  num? extendedUnitRegularPrice;

  /// Gets or sets the Formatted Quantity UnitRegularPrice
  String? extendedUnitRegularPriceDisplay;

  /// Gets or sets the unit net price.
  num? unitNetPrice;

  /// Gets or sets the unit net price display.
  String? unitNetPriceDisplay;

  /// Gets or sets the Quantity UnitNetPrice
  num? extendedUnitNetPrice;

  /// Gets or sets the Formatted Quantity UnitNetPrice
  String? extendedUnitNetPriceDisplay;

  /// Gets or sets the unit of measure.
  String? unitOfMeasure;

  num? vatRate;

  num? vatAmount;

  String? vatAmountDisplay;

  List<BreakPriceDto>? unitListBreakPrices;

  List<BreakPriceDto>? unitRegularBreakPrices;

  num? regularPrice;

  String? regularPriceDisplay;

  num? extendedRegularPrice;

  String? extendedRegularPriceDisplay;

  num? actualPrice;

  String? actualPriceDisplay;

  num? extendedActualPrice;

  String? extendedActualPriceDisplay;

  List<BreakPriceDto>? regularBreakPrices;

  List<BreakPriceDto>? actualBreakPrices;

  factory ProductPrice.fromJson(Map<String, dynamic> json) =>
      _$ProductPriceFromJson(json);
  Map<String, dynamic> toJson() => _$ProductPriceToJson(this);
}
