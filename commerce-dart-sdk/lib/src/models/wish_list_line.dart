import 'models.dart';

part 'wish_list_line.g.dart';

@JsonSerializable()
class WishListLine extends BaseModel {
  String? id;

  String? productUri;

  String? productId;

  String? smallImagePath;

  String? altText;

  String? productName;

  String? manufacturerItem;

  String? customerName;

  String? shortDescription;

  num? qtyOnHand;

  num? qtyOrdered;

  String? erpNumber;

  ProductPrice? pricing;

  bool? quoteRequired;

  bool? isActive;

  bool? canEnterQuantity;

  bool? canShowPrice;

  bool? canAddToCart;

  bool? canShowUnitOfMeasure;

  bool? canBackOrder;

  bool? trackInventory;

  Availability? availability;

  List<BreakPriceDto>? breakPrices;

  String? unitOfMeasure;

  String? unitOfMeasureDisplay;

  String? unitOfMeasureDescription;

  String? baseUnitOfMeasure;

  String? baseUnitOfMeasureDisplay;

  num? qtyPerBaseUnitOfMeasure;

  String? selectedUnitOfMeasure;

  List<ProductUnitOfMeasure>? productUnitOfMeasures;

  String? packDescription;

  DateTime? createdOn;

  String? notes;

  String? createdByDisplayName;

  bool? isSharedLine;

  bool? isVisible;

  bool? isDiscontinued;

  int? sortOrder;

  Brand? brand;

  bool? isQtyAdjusted;

  bool? allowZeroPricing;

  WishListLine({
    this.id,
    this.productUri,
    this.productId,
    this.smallImagePath,
    this.altText,
    this.productName,
    this.manufacturerItem,
    this.customerName,
    this.shortDescription,
    this.qtyOnHand,
    this.qtyOrdered,
    this.erpNumber,
    this.pricing,
    this.quoteRequired,
    this.isActive,
    this.canEnterQuantity,
    this.canShowPrice,
    this.canAddToCart,
    this.canShowUnitOfMeasure,
    this.canBackOrder,
    this.trackInventory,
    this.availability,
    this.breakPrices,
    this.unitOfMeasure,
    this.unitOfMeasureDisplay,
    this.unitOfMeasureDescription,
    this.baseUnitOfMeasure,
    this.baseUnitOfMeasureDisplay,
    this.qtyPerBaseUnitOfMeasure,
    this.selectedUnitOfMeasure,
    this.productUnitOfMeasures,
    this.packDescription,
    this.createdOn,
    this.notes,
    this.createdByDisplayName,
    this.isSharedLine,
    this.isVisible,
    this.isDiscontinued,
    this.sortOrder,
    this.brand,
    this.isQtyAdjusted,
    this.allowZeroPricing,
  });

  factory WishListLine.fromJson(Map<String, dynamic> json) =>
      _$WishListLineFromJson(json);

  Map<String, dynamic> toJson() => _$WishListLineToJson(this);
}
