import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'cart_line.g.dart';

/// Subset of cartline needed to add a new cartline
@JsonSerializable(explicitToJson: true)
class AddCartLine extends BaseModel {
  AddCartLine({
    this.notes,
    this.productId,
    this.qtyOrdered,
    this.sectionOptions,
    this.unitOfMeasure,
    this.vmiBinId,
    this.allowZeroPricing,
  });

  String? productId;

  num? qtyOrdered;

  String? unitOfMeasure;

  String? notes;

  String? vmiBinId;

  bool? allowZeroPricing;

  List<SectionOptionDto>? sectionOptions;

  factory AddCartLine.fromJson(Map<String, dynamic> json) =>
      _$AddCartLineFromJson(json);
  Map<String, dynamic> toJson() => _$AddCartLineToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CartLineList extends BaseModel {
  CartLineList({this.cartLines});
  List<CartLine>? cartLines;

  factory CartLineList.fromJson(Map<String, dynamic> json) =>
      _$CartLineListFromJson(json);
  Map<String, dynamic> toJson() => _$CartLineListToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CartLine extends AddCartLine {
  CartLine(
      {this.altText,
      this.availability,
      this.baseUnitOfMeasure,
      this.baseUnitOfMeasureDisplay,
      this.brand,
      this.breakPrices,
      this.canAddToCart,
      this.canBackOrder,
      this.costCode,
      this.customerName,
      this.erpNumber,
      this.hasInsufficientInventory,
      this.id,
      this.isActive,
      this.isDiscounted,
      this.isFixedConfiguration,
      this.isPromotionItem,
      this.isQtyAdjusted,
      this.isRestricted,
      this.isSubscription,
      this.line,
      this.manufacturerItem,
      this.pricing,
      this.productName,
      this.productSubscription,
      this.productUri,
      this.qtyLeft,
      this.qtyOnHand,
      this.qtyPerBaseUnitOfMeasure,
      this.quoteRequired,
      this.requisitionId,
      this.salePriceLabel,
      this.shortDescription,
      this.smallImagePath,
      this.status,
      this.unitOfMeasureDescription,
      this.unitOfMeasureDisplay,
      super.productId,
      super.qtyOrdered,
      super.unitOfMeasure,
      super.notes,
      super.vmiBinId,
      super.sectionOptions,
      super.allowZeroPricing});

  /// Gets or sets the product URI.
  String? productUri;

  /// Gets or sets the identifier.
  String? id;

  /// Gets or sets the line.
  int? line;

  /// Gets or sets the requisition identifier.
  ///
  /// Only used when adding to the cart and includes the Id of the Requisition the line came from.

  String? requisitionId;

  String? smallImagePath;

  String? altText;

  String? productName;

  String? manufacturerItem;

  String? customerName;

  String? shortDescription;

  String? erpNumber;

  String? unitOfMeasureDisplay;

  String? unitOfMeasureDescription;

  String? baseUnitOfMeasure;

  String? baseUnitOfMeasureDisplay;

  num? qtyPerBaseUnitOfMeasure;

  String? costCode;

  num? qtyLeft;

  ProductPrice? pricing;

  bool? isPromotionItem;

  bool? isDiscounted;

  bool? isFixedConfiguration;

  bool? quoteRequired;

  List<BreakPriceDto>? breakPrices;

  Availability? availability;

  num? qtyOnHand;

  bool? canAddToCart;

  bool? isQtyAdjusted;

  bool? hasInsufficientInventory;

  /// Gets or sets the ability to order with no inventory.
  bool? canBackOrder;

  String? salePriceLabel;

  bool? isSubscription;

  ProductSubscriptionDto? productSubscription;

  bool? isRestricted;

  bool? isActive;

  Brand? brand;

  @JsonKey(includeFromJson: false, includeToJson: false)
  bool get hasLinenotes => !notes.isNullorWhitespace;

  @JsonKey(includeFromJson: false, includeToJson: false)
  String? status;

  factory CartLine.fromJson(Map<String, dynamic> json) =>
      _$CartLineFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$CartLineToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SectionOptionDto {
  SectionOptionDto({
    this.optionName,
    this.sectionName,
    this.sectionOptionId,
  });

  String? sectionOptionId;

  String? sectionName;

  String? optionName;

  factory SectionOptionDto.fromJson(Map<String, dynamic> json) =>
      _$SectionOptionDtoFromJson(json);
  Map<String, dynamic> toJson() => _$SectionOptionDtoToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ProductSubscriptionDto {
  ProductSubscriptionDto({
    this.subscriptionAddToInitialOrder,
    this.subscriptionAllMonths,
    this.subscriptionApril,
    this.subscriptionAugust,
    this.subscriptionCyclePeriod,
    this.subscriptionDecember,
    this.subscriptionFebruary,
    this.subscriptionFixedPrice,
    this.subscriptionJanuary,
    this.subscriptionJuly,
    this.subscriptionJune,
    this.subscriptionMarch,
    this.subscriptionMay,
    this.subscriptionNovember,
    this.subscriptionOctober,
    this.subscriptionPeriodsPerCycle,
    this.subscriptionSeptember,
    this.subscriptionShipViaId,
    this.subscriptionTotalCycles,
  });

  bool? subscriptionAddToInitialOrder;

  bool? subscriptionAllMonths;

  bool? subscriptionApril = true;

  bool? subscriptionAugust = true;

  String? subscriptionCyclePeriod = "";

  bool? subscriptionDecember = true;

  bool? subscriptionFebruary = true;

  bool? subscriptionFixedPrice;

  bool? subscriptionJanuary = true;

  bool? subscriptionJuly = true;

  bool? subscriptionJune = true;

  bool? subscriptionMarch = true;

  bool? subscriptionMay = true;

  bool? subscriptionNovember = true;

  bool? subscriptionOctober = true;

  int? subscriptionPeriodsPerCycle;

  bool? subscriptionSeptember = true;

  String? subscriptionShipViaId;

  int? subscriptionTotalCycles;

  factory ProductSubscriptionDto.fromJson(Map<String, dynamic> json) =>
      _$ProductSubscriptionDtoFromJson(json);
  Map<String, dynamic> toJson() => _$ProductSubscriptionDtoToJson(this);
}
