import 'models.dart';

part 'invoice.g.dart';

@JsonSerializable()
class Invoice {
  String? btAddress1;
  String? btAddress2;
  String? billToCity;
  String? btCompanyName;
  String? btCountry;
  String? billToPostalCode;
  String? billToState;
  String? currencyCode;
  num? currentBalance;
  String? currentBalanceDisplay;
  String? customerNumber;
  String? customerPO;
  String? customerSequence;
  num? discountAmount;
  String? discountAmountDisplay;
  DateTime? dueDate;
  String? id;
  DateTime? invoiceDate;
  List<InvoiceLine>? invoiceLines;
  String? invoiceNumber;
  List<InvoiceTaxModel>? invoiceHistoryTaxes;
  num? invoiceTotal;
  String? invoiceTotalDisplay;
  String? invoiceType;
  bool? isOpen;
  String? message;
  String? notes;
  String? orderTotalDisplay;
  num? otherCharges;
  String? otherChargesDisplay;
  num? productTotal;
  String? productTotalDisplay;
  Map<String, String>? properties;
  String? salesperson;
  String? shipCode;
  num? shippingAndHandling;
  String? shippingAndHandlingDisplay;
  String? shipViaDescription;
  String? stAddress1;
  String? stAddress2;
  String? status;
  String? shipToCity;
  String? stCompanyName;
  String? stCountry;
  String? shipToPostalCode;
  String? shipToState;
  bool? success;
  num? taxAmount;
  String? taxAmountDisplay;
  String? terms;

  Invoice({
    this.btAddress1,
    this.btAddress2,
    this.billToCity,
    this.btCompanyName,
    this.btCountry,
    this.billToPostalCode,
    this.billToState,
    this.currencyCode,
    this.currentBalance,
    this.currentBalanceDisplay,
    this.customerNumber,
    this.customerPO,
    this.customerSequence,
    this.discountAmount,
    this.discountAmountDisplay,
    this.dueDate,
    this.id,
    this.invoiceDate,
    this.invoiceLines,
    this.invoiceNumber,
    this.invoiceHistoryTaxes,
    this.invoiceTotal,
    this.invoiceTotalDisplay,
    this.invoiceType,
    this.isOpen,
    this.message,
    this.notes,
    this.orderTotalDisplay,
    this.otherCharges,
    this.otherChargesDisplay,
    this.productTotal,
    this.productTotalDisplay,
    this.properties,
    this.salesperson,
    this.shipCode,
    this.shippingAndHandling,
    this.shippingAndHandlingDisplay,
    this.shipViaDescription,
    this.stAddress1,
    this.stAddress2,
    this.status,
    this.shipToCity,
    this.stCompanyName,
    this.stCountry,
    this.shipToPostalCode,
    this.shipToState,
    this.success,
    this.taxAmount,
    this.taxAmountDisplay,
    this.terms,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) =>
      _$InvoiceFromJson(json);

  Map<String, dynamic> toJson() => _$InvoiceToJson(this);
}

@JsonSerializable()
class InvoiceLine {
  String? altText;
  String? customerName;
  String? customerProductNumber;
  String? description;
  num? discountAmount;
  String? discountAmountDisplay;
  num? discountPercent;
  String? erpOrderNumber;
  String? id;
  String? lineNumber;
  String? linePOReference;
  num? lineTotal;
  String? lineTotalDisplay;
  String? lineType;
  String? manufacturerItem;
  String? mediumImagePath;
  String? message;
  String? notes;
  String? productErpNumber;
  String? productName;
  String? productUri;
  Map<String, String>? properties;
  num? qtyInvoiced;
  num? releaseNumber;
  String? shipmentNumber;
  String? shortDescription;
  bool? success;
  String? unitOfMeasure;
  num? unitPrice;
  String? unitPriceDisplay;
  String? warehouse;
  Brand? brand;

  InvoiceLine({
    this.altText,
    this.customerName,
    this.customerProductNumber,
    this.description,
    this.discountAmount,
    this.discountAmountDisplay,
    this.discountPercent,
    this.erpOrderNumber,
    this.id,
    this.lineNumber,
    this.linePOReference,
    this.lineTotal,
    this.lineTotalDisplay,
    this.lineType,
    this.manufacturerItem,
    this.mediumImagePath,
    this.message,
    this.notes,
    this.productErpNumber,
    this.productName,
    this.productUri,
    this.properties,
    this.qtyInvoiced,
    this.releaseNumber,
    this.shipmentNumber,
    this.shortDescription,
    this.success,
    this.unitOfMeasure,
    this.unitPrice,
    this.unitPriceDisplay,
    this.warehouse,
    this.brand,
  });

  factory InvoiceLine.fromJson(Map<String, dynamic> json) =>
      _$InvoiceLineFromJson(json);

  Map<String, dynamic> toJson() => _$InvoiceLineToJson(this);
}

@JsonSerializable()
class InvoiceTaxModel {
  String? id;
  String? message;
  Map<String, String>? properties;
  int? sortOrder;
  bool? success;
  num? taxAmount;
  String? taxAmountDisplay;
  String? taxCode;
  String? taxDescription;
  num? taxRate;

  InvoiceTaxModel({
    this.id,
    this.message,
    this.properties,
    this.sortOrder,
    this.success,
    this.taxAmount,
    this.taxAmountDisplay,
    this.taxCode,
    this.taxDescription,
    this.taxRate,
  });

  factory InvoiceTaxModel.fromJson(Map<String, dynamic> json) =>
      _$InvoiceTaxModelFromJson(json);

  Map<String, dynamic> toJson() => _$InvoiceTaxModelToJson(this);
}
