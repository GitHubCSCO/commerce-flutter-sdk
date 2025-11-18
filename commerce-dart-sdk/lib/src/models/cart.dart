// ignore_for_file: public_member_api_docs, sort_constructors_first, unintended_html_in_doc_comment
import 'package:optimizely_commerce_api/src/utils/key_value_pair.dart';

import 'models.dart';

part 'cart.g.dart';

@JsonSerializable()
class Cart extends BaseModel {
  /// Gets or sets the cart lines URI.
  String? cartLinesUri;

  /// Gets or sets the identifier.
  String? id;

  /// Gets or sets the status.
  String? status;

  /// Gets or sets the status.
  String? statusDisplay;

  /// Gets or sets the type.
  String? type;

  /// Gets or sets the type display.
  String? typeDisplay;

  /// Gets or sets the order number.
  String? orderNumber;

  /// Gets or sets the erp order number.
  String? erpOrderNumber;

  /// Gets or sets the order date.
  DateTime? orderDate;

  /// Gets or sets the bill to.
  BillTo? billTo;

  /// Gets or sets the ship to.
  ShipTo? shipTo;

  /// Gets or sets the user label.
  String? userLabel;

  /// Gets or sets the user roles.
  String? userRoles;

  /// Gets or sets the ship to label.
  String? shipToLabel;

  /// Gets or sets the notes.
  String? notes;

  /// Gets or sets the carrier.
  CarrierDto? carrier;

  /// Gets or sets the ship via.
  ShipViaDto? shipVia;

  /// Gets or sets the payment method.
  PaymentMethodDto? paymentMethod;

  /// Gets or sets the fulfillment method.
  String? fulfillmentMethod;

  /// Gets or sets the po number.
  String? poNumber;

  /// Gets or sets the promotion code.
  String? promotionCode;

  /// Gets or sets the name of the initiated by user.
  String? initiatedByUserName;

  /// Gets or sets the total quantity ordered.
  int? totalQtyOrdered;

  /// Gets or sets the line count.
  int? lineCount;

  /// Gets or sets the total count display.
  int? totalCountDisplay;

  /// Gets or sets the quote required count.
  int? quoteRequiredCount;

  /// Gets or sets the order sub total.
  num? orderSubTotal;

  /// Gets or sets the order sub total display.
  String? orderSubTotalDisplay;

  /// Gets or sets the order sub total with out product discounts.
  num? orderSubTotalWithOutProductDiscounts;

  /// Gets or sets the order sub total with out product discounts display.
  String? orderSubTotalWithOutProductDiscountsDisplay;

  /// Gets or sets the total tax.
  num? totalTax;

  /// Gets or sets the total tax display.
  String? totalTaxDisplay;

  /// Gets or sets the shipping and handling.
  num? shippingAndHandling;

  /// Gets or sets the shipping and handling display.
  String? shippingAndHandlingDisplay;

  /// Gets or sets the shipping charges display.
  String? shippingChargesDisplay;

  /// Gets or sets the handling charges display.
  String? handlingChargesDisplay;

  /// Gets or sets the other charges display.
  String? otherChargesDisplay;

  /// Gets or sets the order grand total.
  num? orderGrandTotal;

  /// Gets or sets the order grand total display.
  String? orderGrandTotalDisplay;

  /// Gets or sets the cost code label.
  String? costCodeLabel;

  /// Gets or sets a value indicating whether this instance is authenticated.
  bool? isAuthenticated;

  /// Gets or sets a value indicating whether this instance is a guest order.
  bool? isGuestOrder;

  /// Gets or sets a value indicating whether this instance is sales person.
  bool? isSalesperson;

  /// Gets or sets a value indicating whether this instance is subscribed.
  bool? isSubscribed;

  /// Gets or sets a value indicating whether [requires po number].
  bool? requiresPoNumber;

  /// Gets or sets a value indicating whether this instance can shop.
  bool? displayContinueShoppingLink;

  /// Gets or sets a value indicating whether this instance can modify order.
  bool? canModifyOrder;

  /// Gets or sets a value indicating whether this instance can save order.
  bool? canSaveOrder;

  /// Gets or sets a value indicating whether this instance can bypass checkout address.
  bool? canBypassCheckoutAddress;

  /// Gets or sets a value indicating whether this instance can requisition.
  bool? canRequisition;

  /// Gets or sets a value indicating whether this instance can request quote.
  bool? canRequestQuote;

  /// Gets or sets a value indicating whether this instance can edit cost code.
  bool? canEditCostCode;

  /// Gets or sets a value indicating whether [show tax and shipping].
  bool? showTaxAndShipping;

  /// Gets or sets a value indicating whether [show line notes].
  bool? showLineNotes;

  /// Gets or sets a value indicating whether [show cost code].
  bool? showCostCode;

  /// Gets or sets a value indicating whether [show subscription in footer].
  bool? showNewsletterSignup;

  /// Gets or sets a value indicating whether [show po number].
  bool? showPoNumber;

  /// Gets or sets a value indicating whether [show credit card].
  bool? showCreditCard;

  /// Gets or sets a value indicating whether [show pay pal].
  bool? showPayPal;

  /// Gets or sets a value indicating whether this instance is awaiting approval.
  bool? isAwaitingApproval;

  /// Gets or sets a value indicating whether [requires approval].
  bool? requiresApproval;

  /// Gets or sets the approver reason.
  String? approverReason;

  /// Gets or sets a value indicating whether the user has an assigned approver.
  bool? hasApprover;

  /// Gets or sets the name of the primary salesperson.
  String? salespersonName;

  /// Gets or sets the payment options.
  PaymentOptionsDto? paymentOptions;

  /// Gets or sets the cost codes.
  List<CostCodeDto>? costCodes;

  /// Gets or sets the carriers.
  List<CarrierDto>? carriers;

  /// Gets or sets the cart lines.
  List<CartLine>? cartLines;

  /// Gets or sets the customer order taxes.
  List<CustomerOrderTaxDto>? customerOrderTaxes;

  /// Gets or sets the can check out.
  bool? canCheckOut;

  /// Gets or sets whether cart has insufficient inventory.
  bool? hasInsufficientInventory;

  /// Gets or sets the currency symbol.
  String? currencySymbol;

  /// Gets or sets a value delivery date with date time offset formated String?. For example "2019-02-04T11:13:19-06:00".
  String? requestedDeliveryDate;

  /// Gets the current delivery date displayed in correct format defined by your session context.
  DateTime? requestedDeliveryDateDisplay;

  /// Gets or sets a value delivery date with date time offset formated String?. For example "2019-02-04T11:13:19-06:00" .
  String? requestedPickUpDate;

  /// Gets the current pick up date displayed in correct format defined by your session context.
  DateTime? requestedPickUpDateDisplay;

  /// Gets or sets the cart not priced.
  bool? cartNotPriced;

  /// Gets or sets the messages.
  List<String?>? messages;

  CreditCardBillingAddress? creditCardBillingAddress;

  List<Product>? alsoPurchasedProducts;

  String? taxFailureReason;

  bool? failedToGetRealTimeInventory;

  bool? unassignCart;

  String? customerVatNumber;

  String? vmiLocationId;

  DefaultWarehouseDto? defaultWarehouse;
  Cart({
    this.cartLinesUri,
    this.id,
    this.status,
    this.statusDisplay,
    this.type,
    this.typeDisplay,
    this.orderNumber,
    this.erpOrderNumber,
    this.orderDate,
    this.billTo,
    this.shipTo,
    this.userLabel,
    this.userRoles,
    this.shipToLabel,
    this.notes,
    this.carrier,
    this.shipVia,
    this.paymentMethod,
    this.fulfillmentMethod,
    this.poNumber,
    this.promotionCode,
    this.initiatedByUserName,
    this.totalQtyOrdered,
    this.lineCount,
    this.totalCountDisplay,
    this.quoteRequiredCount,
    this.orderSubTotal,
    this.orderSubTotalDisplay,
    this.orderSubTotalWithOutProductDiscounts,
    this.orderSubTotalWithOutProductDiscountsDisplay,
    this.totalTax,
    this.totalTaxDisplay,
    this.shippingAndHandling,
    this.shippingAndHandlingDisplay,
    this.shippingChargesDisplay,
    this.handlingChargesDisplay,
    this.otherChargesDisplay,
    this.orderGrandTotal,
    this.orderGrandTotalDisplay,
    this.costCodeLabel,
    this.isAuthenticated,
    this.isGuestOrder,
    this.isSalesperson,
    this.isSubscribed,
    this.requiresPoNumber,
    this.displayContinueShoppingLink,
    this.canModifyOrder,
    this.canSaveOrder,
    this.canBypassCheckoutAddress,
    this.canRequisition,
    this.canRequestQuote,
    this.canEditCostCode,
    this.showTaxAndShipping,
    this.showLineNotes,
    this.showCostCode,
    this.showNewsletterSignup,
    this.showPoNumber,
    this.showCreditCard,
    this.showPayPal,
    this.isAwaitingApproval,
    this.requiresApproval,
    this.approverReason,
    this.hasApprover,
    this.salespersonName,
    this.paymentOptions,
    this.costCodes,
    this.carriers,
    this.cartLines,
    this.customerOrderTaxes,
    this.canCheckOut,
    this.hasInsufficientInventory,
    this.currencySymbol,
    this.requestedDeliveryDate,
    this.requestedDeliveryDateDisplay,
    this.requestedPickUpDate,
    this.requestedPickUpDateDisplay,
    this.cartNotPriced,
    this.messages,
    this.creditCardBillingAddress,
    this.alsoPurchasedProducts,
    this.taxFailureReason,
    this.failedToGetRealTimeInventory,
    this.unassignCart,
    this.customerVatNumber,
    this.vmiLocationId,
    this.defaultWarehouse,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);

  Map<String, dynamic> toJson() => _$CartToJson(this);
}

@JsonSerializable()
class CarrierDto {
  /// Gets or sets the carrier id.
  String? id;

  /// Gets or sets the description.
  String? description;

  /// Gets or sets the collection of <see cref="ShipViaDto" />.
  List<ShipViaDto>? shipVias;

  CarrierDto({this.id, this.description, this.shipVias});

  factory CarrierDto.fromJson(Map<String, dynamic> json) =>
      _$CarrierDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CarrierDtoToJson(this);
}

@JsonSerializable()
class ShipViaDto {
  /// Gets or sets the ship via identifier.
  String? id;

  /// Gets or sets the description.
  String? description;

  /// Gets or sets a value indicating whether is default.
  bool? isDefault;

  ShipViaDto({this.id, this.description, this.isDefault});

  factory ShipViaDto.fromJson(Map<String, dynamic> json) =>
      _$ShipViaDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ShipViaDtoToJson(this);
}

@JsonSerializable()
class PaymentMethodDto {
  /// Gets or sets the name.
  String? name;

  /// Gets or sets the description.
  String? description;

  /// Gets or sets a value indicating whether this instance is credit card.
  bool? isCreditCard;

  /// Gets or sets a value indicating whether this instance is payment profile.
  bool? isPaymentProfile;

  /// Gets or sets a value the card type of the paymentMethod.
  String? cardType;

  PaymentMethodDto({
    this.name,
    this.description,
    this.isCreditCard,
    this.isPaymentProfile,
    this.cardType,
  });

  factory PaymentMethodDto.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentMethodDtoToJson(this);
}

@JsonSerializable()
class PaymentOptionsDto {
  /// Gets or sets the payment terms.
  List<PaymentMethodDto>? paymentMethods;

  /// Gets or sets the card types.
  List<KeyValuePair<String, String>>? cardTypes;

  /// Gets or sets the expiration months.
  List<KeyValuePair<String, int>>? expirationMonths;

  /// Gets or sets the expiration years.
  List<KeyValuePair<int, int>>? expirationYears;

  /// Gets or sets the credit card.
  CreditCardDto? creditCard;

  /// Gets or sets a value indicating whether this instance can store payment profile.
  bool? canStorePaymentProfile;

  /// Gets or sets a value indicating whether to store card info to payment profile if the payment gateway supports it.
  bool? storePaymentProfile;

  /// Gets or sets a value indicating whether this instance is pay pal.
  bool? isPayPal;

  /// Gets or sets the pay pal payer identifier.
  String? payPalPayerId;

  /// Gets or sets the pay pal token.
  String? payPalToken;

  /// Gets or sets the pay pal payment url.
  String? payPalPaymentUrl;

  PaymentOptionsDto({
    this.paymentMethods,
    this.cardTypes,
    this.expirationMonths,
    this.expirationYears,
    this.creditCard,
    this.canStorePaymentProfile,
    this.storePaymentProfile,
    this.isPayPal,
    this.payPalPayerId,
    this.payPalToken,
    this.payPalPaymentUrl,
  });

  factory PaymentOptionsDto.fromJson(Map<String, dynamic> json) =>
      _$PaymentOptionsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentOptionsDtoToJson(this);
}

@JsonSerializable()
class CreditCardDto {
  /// Gets or sets the type.
  String? cardType;

  /// Gets or sets the name.
  String? cardHolderName;

  /// Gets or sets the card number.
  String? cardNumber;

  /// Gets or sets the expiration month.
  int? expirationMonth;

  /// Gets or sets the expiration year.
  int? expirationYear;

  /// Gets or sets the security code.
  String? securityCode;

  /// Gets or sets the browser info.
  String? browserInfo;

  CreditCardDto({
    this.cardType,
    this.cardHolderName,
    this.cardNumber,
    this.expirationMonth,
    this.expirationYear,
    this.securityCode,
    this.browserInfo,
  });

  factory CreditCardDto.fromJson(Map<String, dynamic> json) =>
      _$CreditCardDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CreditCardDtoToJson(this);
}

@JsonSerializable()
class CostCodeDto {
  /// Gets or sets the cost code.
  String? costCode;

  /// Gets or sets the description.
  String? description;

  CostCodeDto({this.costCode, this.description});

  factory CostCodeDto.fromJson(Map<String, dynamic> json) =>
      _$CostCodeDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CostCodeDtoToJson(this);
}

@JsonSerializable()
class CustomerOrderTaxDto {
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

  CustomerOrderTaxDto({
    this.taxCode,
    this.taxDescription,
    this.taxRate,
    this.taxAmount,
    this.taxAmountDisplay,
    this.sortOrder,
  });

  factory CustomerOrderTaxDto.fromJson(Map<String, dynamic> json) =>
      _$CustomerOrderTaxDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerOrderTaxDtoToJson(this);
}

@JsonSerializable()
class DefaultWarehouseDto {
  /// Gets or sets the ship via identifier.
  String? id;

  /// Gets or sets the name.
  String? name;

  /// Gets or sets the address1.
  String? address1;

  String? address2;

  String? city;

  String? postalCode;

  String? state;

  String? description;

  DefaultWarehouseDto({
    this.id,
    this.name,
    this.address1,
    this.address2,
    this.city,
    this.postalCode,
    this.state,
    this.description,
  });

  factory DefaultWarehouseDto.fromJson(Map<String, dynamic> json) =>
      _$DefaultWarehouseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$DefaultWarehouseDtoToJson(this);
}

@JsonSerializable()
class CartLineCollectionDto {
  List<CartLine>? cartLines;

  bool? notAllAddedToCart;

  Pagination? pagination;

  CartLineCollectionDto({
    this.cartLines,
    this.notAllAddedToCart,
    this.pagination,
  });

  factory CartLineCollectionDto.fromJson(Map<String, dynamic> json) =>
      _$CartLineCollectionDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CartLineCollectionDtoToJson(this);
}

@JsonSerializable()
class CartCollectionModel extends BaseModel {
  List<Cart>? carts;

  Pagination? pagination;

  CartCollectionModel({this.carts, this.pagination});

  factory CartCollectionModel.fromJson(Map<String, dynamic> json) =>
      _$CartCollectionModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartCollectionModelToJson(this);
}
