// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Invoice _$InvoiceFromJson(Map<String, dynamic> json) => Invoice(
      btAddress1: json['btAddress1'] as String?,
      btAddress2: json['btAddress2'] as String?,
      billToCity: json['billToCity'] as String?,
      btCompanyName: json['btCompanyName'] as String?,
      btCountry: json['btCountry'] as String?,
      billToPostalCode: json['billToPostalCode'] as String?,
      billToState: json['billToState'] as String?,
      currencyCode: json['currencyCode'] as String?,
      currentBalance: json['currentBalance'] as num?,
      currentBalanceDisplay: json['currentBalanceDisplay'] as String?,
      customerNumber: json['customerNumber'] as String?,
      customerPO: json['customerPO'] as String?,
      customerSequence: json['customerSequence'] as String?,
      discountAmount: json['discountAmount'] as num?,
      discountAmountDisplay: json['discountAmountDisplay'] as String?,
      dueDate: json['dueDate'] == null
          ? null
          : DateTime.parse(json['dueDate'] as String),
      id: json['id'] as String?,
      invoiceDate: json['invoiceDate'] == null
          ? null
          : DateTime.parse(json['invoiceDate'] as String),
      invoiceLines: (json['invoiceLines'] as List<dynamic>?)
          ?.map((e) => InvoiceLine.fromJson(e as Map<String, dynamic>))
          .toList(),
      invoiceNumber: json['invoiceNumber'] as String?,
      invoiceHistoryTaxes: (json['invoiceHistoryTaxes'] as List<dynamic>?)
          ?.map((e) => InvoiceTaxModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      invoiceTotal: json['invoiceTotal'] as num?,
      invoiceTotalDisplay: json['invoiceTotalDisplay'] as String?,
      invoiceType: json['invoiceType'] as String?,
      isOpen: json['isOpen'] as bool?,
      message: json['message'] as String?,
      notes: json['notes'] as String?,
      orderTotalDisplay: json['orderTotalDisplay'] as String?,
      otherCharges: json['otherCharges'] as num?,
      otherChargesDisplay: json['otherChargesDisplay'] as String?,
      productTotal: json['productTotal'] as num?,
      productTotalDisplay: json['productTotalDisplay'] as String?,
      properties: (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      salesperson: json['salesperson'] as String?,
      shipCode: json['shipCode'] as String?,
      shippingAndHandling: json['shippingAndHandling'] as num?,
      shippingAndHandlingDisplay: json['shippingAndHandlingDisplay'] as String?,
      shipViaDescription: json['shipViaDescription'] as String?,
      stAddress1: json['stAddress1'] as String?,
      stAddress2: json['stAddress2'] as String?,
      status: json['status'] as String?,
      shipToCity: json['shipToCity'] as String?,
      stCompanyName: json['stCompanyName'] as String?,
      stCountry: json['stCountry'] as String?,
      shipToPostalCode: json['shipToPostalCode'] as String?,
      shipToState: json['shipToState'] as String?,
      success: json['success'] as bool?,
      taxAmount: json['taxAmount'] as num?,
      taxAmountDisplay: json['taxAmountDisplay'] as String?,
      terms: json['terms'] as String?,
    );

Map<String, dynamic> _$InvoiceToJson(Invoice instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('btAddress1', instance.btAddress1);
  writeNotNull('btAddress2', instance.btAddress2);
  writeNotNull('billToCity', instance.billToCity);
  writeNotNull('btCompanyName', instance.btCompanyName);
  writeNotNull('btCountry', instance.btCountry);
  writeNotNull('billToPostalCode', instance.billToPostalCode);
  writeNotNull('billToState', instance.billToState);
  writeNotNull('currencyCode', instance.currencyCode);
  writeNotNull('currentBalance', instance.currentBalance);
  writeNotNull('currentBalanceDisplay', instance.currentBalanceDisplay);
  writeNotNull('customerNumber', instance.customerNumber);
  writeNotNull('customerPO', instance.customerPO);
  writeNotNull('customerSequence', instance.customerSequence);
  writeNotNull('discountAmount', instance.discountAmount);
  writeNotNull('discountAmountDisplay', instance.discountAmountDisplay);
  writeNotNull('dueDate', instance.dueDate?.toIso8601String());
  writeNotNull('id', instance.id);
  writeNotNull('invoiceDate', instance.invoiceDate?.toIso8601String());
  writeNotNull(
      'invoiceLines', instance.invoiceLines?.map((e) => e.toJson()).toList());
  writeNotNull('invoiceNumber', instance.invoiceNumber);
  writeNotNull('invoiceHistoryTaxes',
      instance.invoiceHistoryTaxes?.map((e) => e.toJson()).toList());
  writeNotNull('invoiceTotal', instance.invoiceTotal);
  writeNotNull('invoiceTotalDisplay', instance.invoiceTotalDisplay);
  writeNotNull('invoiceType', instance.invoiceType);
  writeNotNull('isOpen', instance.isOpen);
  writeNotNull('message', instance.message);
  writeNotNull('notes', instance.notes);
  writeNotNull('orderTotalDisplay', instance.orderTotalDisplay);
  writeNotNull('otherCharges', instance.otherCharges);
  writeNotNull('otherChargesDisplay', instance.otherChargesDisplay);
  writeNotNull('productTotal', instance.productTotal);
  writeNotNull('productTotalDisplay', instance.productTotalDisplay);
  writeNotNull('properties', instance.properties);
  writeNotNull('salesperson', instance.salesperson);
  writeNotNull('shipCode', instance.shipCode);
  writeNotNull('shippingAndHandling', instance.shippingAndHandling);
  writeNotNull(
      'shippingAndHandlingDisplay', instance.shippingAndHandlingDisplay);
  writeNotNull('shipViaDescription', instance.shipViaDescription);
  writeNotNull('stAddress1', instance.stAddress1);
  writeNotNull('stAddress2', instance.stAddress2);
  writeNotNull('status', instance.status);
  writeNotNull('shipToCity', instance.shipToCity);
  writeNotNull('stCompanyName', instance.stCompanyName);
  writeNotNull('stCountry', instance.stCountry);
  writeNotNull('shipToPostalCode', instance.shipToPostalCode);
  writeNotNull('shipToState', instance.shipToState);
  writeNotNull('success', instance.success);
  writeNotNull('taxAmount', instance.taxAmount);
  writeNotNull('taxAmountDisplay', instance.taxAmountDisplay);
  writeNotNull('terms', instance.terms);
  return val;
}

InvoiceLine _$InvoiceLineFromJson(Map<String, dynamic> json) => InvoiceLine(
      altText: json['altText'] as String?,
      customerName: json['customerName'] as String?,
      customerProductNumber: json['customerProductNumber'] as String?,
      description: json['description'] as String?,
      discountAmount: json['discountAmount'] as num?,
      discountAmountDisplay: json['discountAmountDisplay'] as String?,
      discountPercent: json['discountPercent'] as num?,
      erpOrderNumber: json['erpOrderNumber'] as String?,
      id: json['id'] as String?,
      lineNumber: json['lineNumber'] as String?,
      linePOReference: json['linePOReference'] as String?,
      lineTotal: json['lineTotal'] as num?,
      lineTotalDisplay: json['lineTotalDisplay'] as String?,
      lineType: json['lineType'] as String?,
      manufacturerItem: json['manufacturerItem'] as String?,
      mediumImagePath: json['mediumImagePath'] as String?,
      message: json['message'] as String?,
      notes: json['notes'] as String?,
      productErpNumber: json['productErpNumber'] as String?,
      productName: json['productName'] as String?,
      productUri: json['productUri'] as String?,
      properties: (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      qtyInvoiced: json['qtyInvoiced'] as num?,
      releaseNumber: json['releaseNumber'] as num?,
      shipmentNumber: json['shipmentNumber'] as String?,
      shortDescription: json['shortDescription'] as String?,
      success: json['success'] as bool?,
      unitOfMeasure: json['unitOfMeasure'] as String?,
      unitPrice: json['unitPrice'] as num?,
      unitPriceDisplay: json['unitPriceDisplay'] as String?,
      warehouse: json['warehouse'] as String?,
      brand: json['brand'] == null
          ? null
          : Brand.fromJson(json['brand'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$InvoiceLineToJson(InvoiceLine instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('altText', instance.altText);
  writeNotNull('customerName', instance.customerName);
  writeNotNull('customerProductNumber', instance.customerProductNumber);
  writeNotNull('description', instance.description);
  writeNotNull('discountAmount', instance.discountAmount);
  writeNotNull('discountAmountDisplay', instance.discountAmountDisplay);
  writeNotNull('discountPercent', instance.discountPercent);
  writeNotNull('erpOrderNumber', instance.erpOrderNumber);
  writeNotNull('id', instance.id);
  writeNotNull('lineNumber', instance.lineNumber);
  writeNotNull('linePOReference', instance.linePOReference);
  writeNotNull('lineTotal', instance.lineTotal);
  writeNotNull('lineTotalDisplay', instance.lineTotalDisplay);
  writeNotNull('lineType', instance.lineType);
  writeNotNull('manufacturerItem', instance.manufacturerItem);
  writeNotNull('mediumImagePath', instance.mediumImagePath);
  writeNotNull('message', instance.message);
  writeNotNull('notes', instance.notes);
  writeNotNull('productErpNumber', instance.productErpNumber);
  writeNotNull('productName', instance.productName);
  writeNotNull('productUri', instance.productUri);
  writeNotNull('properties', instance.properties);
  writeNotNull('qtyInvoiced', instance.qtyInvoiced);
  writeNotNull('releaseNumber', instance.releaseNumber);
  writeNotNull('shipmentNumber', instance.shipmentNumber);
  writeNotNull('shortDescription', instance.shortDescription);
  writeNotNull('success', instance.success);
  writeNotNull('unitOfMeasure', instance.unitOfMeasure);
  writeNotNull('unitPrice', instance.unitPrice);
  writeNotNull('unitPriceDisplay', instance.unitPriceDisplay);
  writeNotNull('warehouse', instance.warehouse);
  writeNotNull('brand', instance.brand?.toJson());
  return val;
}

InvoiceTaxModel _$InvoiceTaxModelFromJson(Map<String, dynamic> json) =>
    InvoiceTaxModel(
      id: json['id'] as String?,
      message: json['message'] as String?,
      properties: (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      sortOrder: (json['sortOrder'] as num?)?.toInt(),
      success: json['success'] as bool?,
      taxAmount: json['taxAmount'] as num?,
      taxAmountDisplay: json['taxAmountDisplay'] as String?,
      taxCode: json['taxCode'] as String?,
      taxDescription: json['taxDescription'] as String?,
      taxRate: json['taxRate'] as num?,
    );

Map<String, dynamic> _$InvoiceTaxModelToJson(InvoiceTaxModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('message', instance.message);
  writeNotNull('properties', instance.properties);
  writeNotNull('sortOrder', instance.sortOrder);
  writeNotNull('success', instance.success);
  writeNotNull('taxAmount', instance.taxAmount);
  writeNotNull('taxAmountDisplay', instance.taxAmountDisplay);
  writeNotNull('taxCode', instance.taxCode);
  writeNotNull('taxDescription', instance.taxDescription);
  writeNotNull('taxRate', instance.taxRate);
  return val;
}
