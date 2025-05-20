import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'order.g.dart';

@JsonSerializable()
class Order {
  /// Gets or sets the order history identifier.
  String? id;

  /// Gets or sets the erp order number.
  String? erpOrderNumber;

  /// Gets or sets the web order number.
  String? webOrderNumber;

  /// Gets or sets the order date.
  DateTime? orderDate;

  /// Gets or sets the status.
  String? status;

  /// Gets or sets the status display.
  String? statusDisplay;

  /// Gets or sets the customer number.
  String? customerNumber;

  /// Gets or sets the customer sequence.
  String? customerSequence;

  /// Gets or sets the customer po.
  String? customerPO;

  /// Gets or sets the currency code.
  String? currencyCode;

  /// Gets or sets the currency symbol.
  String? currencySymbol;

  /// Gets or sets the terms.
  String? terms;

  /// Gets or sets the ship code.
  String? shipCode;

  /// Gets or sets the salesperson.
  String? salesperson;

  /// Gets or sets the name of the BT company.
  String? btCompanyName;

  /// Gets or sets the BT address1.
  String? btAddress1;

  /// Gets or sets the BT address2.
  String? btAddress2;

  /// Gets or sets the bill to city.
  String? billToCity;

  /// Gets or sets the state of the bill to.
  String? billToState;

  /// Gets or sets the bill to postal code.
  String? billToPostalCode;

  /// Gets or sets the BT country.
  String? btCountry;

  /// Gets or sets the name of the st company.
  String? stCompanyName;

  /// Gets or sets the st address1.
  String? stAddress1;

  /// Gets or sets the st address2.
  String? stAddress2;

  String? stAddress3;

  String? stAddress4;

  /// Gets or sets the ship to city.
  String? shipToCity;

  /// Gets or sets the state of the ship to.
  String? shipToState;

  /// Gets or sets the ship to postal code.
  String? shipToPostalCode;

  /// Gets or sets the st country.
  String? stCountry;

  /// Gets or sets the notes.
  String? notes;

  /// Gets or sets the product total.
  num? productTotal;

  /// Gets or sets the order sub total.
  num? orderSubTotal;

  /// Gets or sets the order discount amount.
  num? orderDiscountAmount;

  /// Gets or sets the product discount amount.
  num? productDiscountAmount;

  num? shippingAndHandling;

  /// Gets the shipping charges.
  num? shippingCharges;

  /// Gets the handling charges.
  num? handlingCharges;

  /// Gets or sets the other charges.
  num? otherCharges;

  /// Gets or sets the tax amount.
  num? taxAmount;

  /// Gets or sets the order total.
  num? orderTotal;

  /// Gets or sets the modify date.
  DateTime? modifyDate;

  /// Gets or sets the requested delivery date.
  DateTime? requestedDeliveryDateDisplay;

  /// Gets or sets the order history lines.
  List<OrderLine>? orderLines;

  /// Gets or sets the order history promotions.
  List<OrderPromotion>? orderPromotions;

  /// Gets or sets the shipment packages.
  List<ShipmentPackageDto>? shipmentPackages;

  /// Gets or sets the return reason codes.
  List<String?>? returnReasons;

  /// Gets or sets the order history taxes.
  List<OrderHistoryTaxDto>? orderHistoryTaxes;

  /// Gets or sets the product total display.
  String? productTotalDisplay;

  /// Gets or sets the order sub total display.
  String? orderSubTotalDisplay;

  /// Gets or sets the order total including product total, taxes, shipping and handling, discounts, and other charges.
  String? orderGrandTotalDisplay;

  /// Gets or sets the order discount amount display.
  String? orderDiscountAmountDisplay;

  /// Gets or sets the product discount amount display.
  String? productDiscountAmountDisplay;

  String? taxAmountDisplay;

  /// Gets or sets the formatted display of the order tax amount.
  String? totalTaxDisplay;

  /// Gets or sets the shipping and handling display.
  String? shippingAndHandlingDisplay;

  /// Gets or sets the shipping charges display.
  String? shippingChargesDisplay;

  /// Gets or sets the handling charges display.
  String? handlingChargesDisplay;

  /// Gets or sets the other charges display.
  String? otherChargesDisplay;

  /// Gets or sets a value indicating whether this instance can add to cart.
  bool? canAddToCart;

  /// Gets or sets a value indicating whether all line items can be added to a cart.
  bool? canAddAllToCart;

  /// Indicates whether or not to display taxes and shipping and handling charges where this order appears in the user int?erface.
  bool? showTaxAndShipping;

  String? shipViaDescription;

  String? fulfillmentMethod;

  String? vmiLocationId;

  String? vmiLocationName;

  @JsonKey(includeFromJson: false, includeToJson: false)
  bool? showWebOrderNumber;

  @JsonKey(includeFromJson: false, includeToJson: false)
  bool? showPoNumber;

  @JsonKey(includeFromJson: false, includeToJson: false)
  bool? showTermsCode;

  @JsonKey(includeFromJson: false, includeToJson: false)
  String? orderNumberLabel;

  @JsonKey(includeFromJson: false, includeToJson: false)
  String? webOrderNumberLabel;

  @JsonKey(includeFromJson: false, includeToJson: false)
  String? poNumberLabel;

  @JsonKey(includeFromJson: false, includeToJson: false)
  String? get orderNumber =>
      erpOrderNumber!.isNullOrEmpty ? webOrderNumber : erpOrderNumber;

  Order({
    this.billToCity,
    this.billToPostalCode,
    this.billToState,
    this.btAddress1,
    this.btAddress2,
    this.btCompanyName,
    this.btCountry,
    this.canAddAllToCart,
    this.canAddToCart,
    this.currencyCode,
    this.currencySymbol,
    this.customerNumber,
    this.customerPO,
    this.customerSequence,
    this.erpOrderNumber,
    this.fulfillmentMethod,
    this.handlingCharges,
    this.handlingChargesDisplay,
    this.id,
    this.modifyDate,
    this.notes,
    this.orderDate,
    this.orderDiscountAmount,
    this.orderDiscountAmountDisplay,
    this.orderGrandTotalDisplay,
    this.orderHistoryTaxes,
    this.orderLines,
    this.orderNumberLabel,
    this.orderPromotions,
    this.orderSubTotal,
    this.orderSubTotalDisplay,
    this.orderTotal,
    this.otherCharges,
    this.otherChargesDisplay,
    this.poNumberLabel,
    this.productDiscountAmount,
    this.productDiscountAmountDisplay,
    this.productTotal,
    this.productTotalDisplay,
    this.requestedDeliveryDateDisplay,
    this.returnReasons,
    this.salesperson,
    this.shipCode,
    this.shipToCity,
    this.shipToPostalCode,
    this.shipToState,
    this.shipViaDescription,
    this.shipmentPackages,
    this.shippingAndHandling,
    this.shippingAndHandlingDisplay,
    this.shippingCharges,
    this.shippingChargesDisplay,
    this.showPoNumber,
    this.showTaxAndShipping,
    this.showTermsCode,
    this.showWebOrderNumber,
    this.stAddress1,
    this.stAddress2,
    this.stAddress3,
    this.stAddress4,
    this.stCompanyName,
    this.stCountry,
    this.status,
    this.statusDisplay,
    this.taxAmount,
    this.taxAmountDisplay,
    this.terms,
    this.totalTaxDisplay,
    this.vmiLocationId,
    this.vmiLocationName,
    this.webOrderNumber,
    this.webOrderNumberLabel,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}

@JsonSerializable()
class OrderHistoryTaxDto {
  /// Gets or sets the tax code.
  String? taxCode;

  /// Gets or sets the tax description.
  String? taxDescription;

  /// Gets or sets the tax rate.
  num? taxRate;

  /// Gets or sets the tax amount.
  num? taxAmount;

  /// Gets or sets the tax amount display.
  String? taxAmountDisplay;

  /// Gets or sets the sort order.
  int? sortOrder;

  OrderHistoryTaxDto({
    this.taxCode,
    this.taxDescription,
    this.taxRate,
    this.taxAmount,
    this.taxAmountDisplay,
    this.sortOrder,
  });

  factory OrderHistoryTaxDto.fromJson(Map<String, dynamic> json) =>
      _$OrderHistoryTaxDtoFromJson(json);

  Map<String, dynamic> toJson() => _$OrderHistoryTaxDtoToJson(this);
}

@JsonSerializable()
class ShipmentPackageDto {
  /// Gets or sets the id.
  String? id;

  /// Gets or sets the shipment date.
  DateTime? shipmentDate;

  /// Gets or sets the carrier.
  String? carrier;

  /// Gets or sets the ship via.
  String? shipVia;

  /// Gets or sets the tracking url.
  String? trackingUrl;

  /// Gets or sets the tracking number.
  String? trackingNumber;

  /// Gets or sets the pack slip.
  String? packSlip;

  @JsonKey(includeFromJson: false, includeToJson: false)
  String? trackButtonTitle;

  @JsonKey(includeFromJson: false, includeToJson: false)
  String? shipDateTitle;

  ShipmentPackageDto({
    this.id,
    this.shipmentDate,
    this.carrier,
    this.shipVia,
    this.trackingUrl,
    this.trackingNumber,
    this.packSlip,
    this.trackButtonTitle,
    this.shipDateTitle,
  });

  factory ShipmentPackageDto.fromJson(Map<String, dynamic> json) =>
      _$ShipmentPackageDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ShipmentPackageDtoToJson(this);
}

@JsonSerializable()
class OrderStatusMapping extends BaseModel {
  /// Gets or sets the id.
  String? id;

  /// Gets or sets the erp order status.
  String? erpOrderStatus;

  /// Gets or sets the display name.
  String? displayName;

  /// Gets or sets a value indicating whether is default.
  bool? isDefault;

  /// Gets or sets a value indicating whether allow rma.
  bool? allowRma;

  /// Gets or sets a value indicating whether allow cancellation.
  bool? allowCancellation;

  OrderStatusMapping({
    this.id,
    this.erpOrderStatus,
    this.displayName,
    this.isDefault,
    this.allowRma,
    this.allowCancellation,
  });

  factory OrderStatusMapping.fromJson(Map<String, dynamic> json) =>
      _$OrderStatusMappingFromJson(json);

  Map<String, dynamic> toJson() => _$OrderStatusMappingToJson(this);
}
