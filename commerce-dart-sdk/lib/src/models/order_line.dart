import 'models.dart';

part 'order_line.g.dart';

@JsonSerializable()
class OrderLine extends BaseModel {
  /// Gets or sets the identifier.
  String? id;

  /// Gets or sets the product identifier.
  String? productId;

  /// Gets or sets the product URI.
  String? productUri;

  /// Gets or sets the medium image path.
  String? mediumImagePath;

  /// Gets or sets the alt text.
  String? altText;

  /// Gets or sets the name of the product.
  String? productName;

  /// Gets or sets the manufacturer item.
  String? manufacturerItem;

  /// Gets or sets the name of the customer.
  String? customerName;

  /// Gets or sets the short description.
  String? shortDescription;

  /// Gets or sets the product erp number.
  String? productErpNumber;

  /// Gets or sets the customer product number.
  String? customerProductNumber;

  /// Gets or sets the required date.
  DateTime? requiredDate;

  /// Gets or sets the last ship date.
  DateTime? lastShipDate;

  /// Gets or sets the customer number.
  String? customerNumber;

  /// Gets or sets the customer sequence.
  String? customerSequence;

  /// Gets or sets the type of the line.
  String? lineType;

  /// Gets or sets the status.
  String? status;

  /// Gets or sets the line number.
  num? lineNumber;

  /// Gets or sets the release number.
  num? releaseNumber;

  /// Gets or sets the line po reference.
  String? linePOReference;

  /// Gets or sets the description.
  String? description;

  /// Gets or sets the warehouse.
  String? warehouse;

  /// Gets or sets the notes.
  String? notes;

  /// Gets or sets the qty ordered.
  num? qtyOrdered;

  /// Gets or sets the qty shipped.
  num? qtyShipped;

  /// Gets or sets the unit of measure.
  String? unitOfMeasure;

  /// Gets or sets the unit of measure display.
  String? unitOfMeasureDisplay;

  /// Gets or sets the unit of measure description.
  String? unitOfMeasureDescription;

  /// Gets or sets the inventory availability information.
  Availability? availability;

  /// Gets or sets the inventory qty ordered.
  num? inventoryQtyOrdered;

  /// Gets or sets the inventory qty shipped.
  num? inventoryQtyShipped;

  num? unitPrice;

  /// Gets or sets the unit net price.
  num? unitNetPrice;

  /// Gets or sets the Quantity UnitNetPrice
  num? extendedUnitNetPrice;

  /// Gets or sets the discount percent.
  num? discountPercent;

  num? discountAmount;

  /// Gets or sets the unit discount amount.
  num? unitDiscountAmount;

  num? promotionAmountApplied;

  /// Gets or sets the total discount amount.
  num? totalDiscountAmount;

  num? lineTotal;

  /// Gets or sets the total regular price.
  num? totalRegularPrice;

  /// Gets or sets the unit list price.
  num? unitListPrice;

  /// Gets or sets the unit regular price.
  num? unitRegularPrice;

  /// Gets or sets the unit cost.
  num? unitCost;

  /// Gets or sets the other charges.
  num? orderLineOtherCharges;

  num? taxRate;

  num? taxAmount;

  /// Gets or sets the return reason.
  String? returnReason;

  /// Gets or sets the return qty requested.
  num? rmaQtyRequested;

  /// Gets or sets the return qty received.
  num? rmaQtyReceived;

  String? unitPriceDisplay;

  /// Gets or sets the unit net price display.
  String? unitNetPriceDisplay;

  /// Gets or sets the Formatted Quantity UnitNetPrice
  String? extendedUnitNetPriceDisplay;

  String? discountAmountDisplay;

  /// Gets or sets the unit discount amount display.
  String? unitDiscountAmountDisplay;

  /// Gets or sets the total discount amount display.
  String? totalDiscountAmountDisplay;

  String? lineTotalDisplay;

  /// Gets or sets the total regular price display.
  String? totalRegularPriceDisplay;

  /// Gets or sets the unit list price display.
  String? unitListPriceDisplay;

  /// Gets or sets the unit regular price display.
  String? unitRegularPriceDisplay;

  /// Gets or sets the unit cost display.
  String? unitCostDisplay;

  /// Gets or sets the other charges display.
  String? orderLineOtherChargesDisplay;

  /// Gets or sets the cost codes.
  String? costCode;

  /// Gets or sets a value indicating whether this instance can add to cart.
  bool? canAddToCart;

  /// Gets or sets a value indicating whether this instance is active product.
  bool? isActiveProduct;

  /// Gets or sets the section options.
  List<SectionOptionDto>? sectionOptions;

  /// Gets or sets the sale price label.
  String? salePriceLabel;

  bool? canAddToWishlist;

  Brand? brand;

  num? netPriceWithVat;

  String? netPriceWithVatDisplay;

  num? unitPriceWithVat;

  String? unitPriceWithVatDisplay;

  String? vmiBinNumber;

  OrderLine({
    this.id,
    this.productId,
    this.productUri,
    this.mediumImagePath,
    this.altText,
    this.productName,
    this.manufacturerItem,
    this.customerName,
    this.shortDescription,
    this.productErpNumber,
    this.customerProductNumber,
    this.requiredDate,
    this.lastShipDate,
    this.customerNumber,
    this.customerSequence,
    this.lineType,
    this.status,
    this.lineNumber,
    this.releaseNumber,
    this.linePOReference,
    this.description,
    this.warehouse,
    this.notes,
    this.qtyOrdered,
    this.qtyShipped,
    this.unitOfMeasure,
    this.unitOfMeasureDisplay,
    this.unitOfMeasureDescription,
    this.availability,
    this.inventoryQtyOrdered,
    this.inventoryQtyShipped,
    this.unitPrice,
    this.unitNetPrice,
    this.extendedUnitNetPrice,
    this.discountPercent,
    this.discountAmount,
    this.unitDiscountAmount,
    this.promotionAmountApplied,
    this.totalDiscountAmount,
    this.lineTotal,
    this.totalRegularPrice,
    this.unitListPrice,
    this.unitRegularPrice,
    this.unitCost,
    this.orderLineOtherCharges,
    this.taxRate,
    this.taxAmount,
    this.returnReason,
    this.rmaQtyRequested,
    this.rmaQtyReceived,
    this.unitPriceDisplay,
    this.unitNetPriceDisplay,
    this.extendedUnitNetPriceDisplay,
    this.discountAmountDisplay,
    this.unitDiscountAmountDisplay,
    this.totalDiscountAmountDisplay,
    this.lineTotalDisplay,
    this.totalRegularPriceDisplay,
    this.unitListPriceDisplay,
    this.unitRegularPriceDisplay,
    this.unitCostDisplay,
    this.orderLineOtherChargesDisplay,
    this.costCode,
    this.canAddToCart,
    this.isActiveProduct,
    this.sectionOptions,
    this.salePriceLabel,
    this.canAddToWishlist,
    this.brand,
    this.netPriceWithVat,
    this.netPriceWithVatDisplay,
    this.unitPriceWithVat,
    this.unitPriceWithVatDisplay,
    this.vmiBinNumber,
  });

  factory OrderLine.fromJson(Map<String, dynamic> json) =>
      _$OrderLineFromJson(json);

  Map<String, dynamic> toJson() => _$OrderLineToJson(this);
}
