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

Map<String, dynamic> _$InvoiceToJson(Invoice instance) => <String, dynamic>{
      if (instance.btAddress1 case final value?) 'btAddress1': value,
      if (instance.btAddress2 case final value?) 'btAddress2': value,
      if (instance.billToCity case final value?) 'billToCity': value,
      if (instance.btCompanyName case final value?) 'btCompanyName': value,
      if (instance.btCountry case final value?) 'btCountry': value,
      if (instance.billToPostalCode case final value?)
        'billToPostalCode': value,
      if (instance.billToState case final value?) 'billToState': value,
      if (instance.currencyCode case final value?) 'currencyCode': value,
      if (instance.currentBalance case final value?) 'currentBalance': value,
      if (instance.currentBalanceDisplay case final value?)
        'currentBalanceDisplay': value,
      if (instance.customerNumber case final value?) 'customerNumber': value,
      if (instance.customerPO case final value?) 'customerPO': value,
      if (instance.customerSequence case final value?)
        'customerSequence': value,
      if (instance.discountAmount case final value?) 'discountAmount': value,
      if (instance.discountAmountDisplay case final value?)
        'discountAmountDisplay': value,
      if (instance.dueDate?.toIso8601String() case final value?)
        'dueDate': value,
      if (instance.id case final value?) 'id': value,
      if (instance.invoiceDate?.toIso8601String() case final value?)
        'invoiceDate': value,
      if (instance.invoiceLines?.map((e) => e.toJson()).toList()
          case final value?)
        'invoiceLines': value,
      if (instance.invoiceNumber case final value?) 'invoiceNumber': value,
      if (instance.invoiceHistoryTaxes?.map((e) => e.toJson()).toList()
          case final value?)
        'invoiceHistoryTaxes': value,
      if (instance.invoiceTotal case final value?) 'invoiceTotal': value,
      if (instance.invoiceTotalDisplay case final value?)
        'invoiceTotalDisplay': value,
      if (instance.invoiceType case final value?) 'invoiceType': value,
      if (instance.isOpen case final value?) 'isOpen': value,
      if (instance.message case final value?) 'message': value,
      if (instance.notes case final value?) 'notes': value,
      if (instance.orderTotalDisplay case final value?)
        'orderTotalDisplay': value,
      if (instance.otherCharges case final value?) 'otherCharges': value,
      if (instance.otherChargesDisplay case final value?)
        'otherChargesDisplay': value,
      if (instance.productTotal case final value?) 'productTotal': value,
      if (instance.productTotalDisplay case final value?)
        'productTotalDisplay': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.salesperson case final value?) 'salesperson': value,
      if (instance.shipCode case final value?) 'shipCode': value,
      if (instance.shippingAndHandling case final value?)
        'shippingAndHandling': value,
      if (instance.shippingAndHandlingDisplay case final value?)
        'shippingAndHandlingDisplay': value,
      if (instance.shipViaDescription case final value?)
        'shipViaDescription': value,
      if (instance.stAddress1 case final value?) 'stAddress1': value,
      if (instance.stAddress2 case final value?) 'stAddress2': value,
      if (instance.status case final value?) 'status': value,
      if (instance.shipToCity case final value?) 'shipToCity': value,
      if (instance.stCompanyName case final value?) 'stCompanyName': value,
      if (instance.stCountry case final value?) 'stCountry': value,
      if (instance.shipToPostalCode case final value?)
        'shipToPostalCode': value,
      if (instance.shipToState case final value?) 'shipToState': value,
      if (instance.success case final value?) 'success': value,
      if (instance.taxAmount case final value?) 'taxAmount': value,
      if (instance.taxAmountDisplay case final value?)
        'taxAmountDisplay': value,
      if (instance.terms case final value?) 'terms': value,
    };

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

Map<String, dynamic> _$InvoiceLineToJson(InvoiceLine instance) =>
    <String, dynamic>{
      if (instance.altText case final value?) 'altText': value,
      if (instance.customerName case final value?) 'customerName': value,
      if (instance.customerProductNumber case final value?)
        'customerProductNumber': value,
      if (instance.description case final value?) 'description': value,
      if (instance.discountAmount case final value?) 'discountAmount': value,
      if (instance.discountAmountDisplay case final value?)
        'discountAmountDisplay': value,
      if (instance.discountPercent case final value?) 'discountPercent': value,
      if (instance.erpOrderNumber case final value?) 'erpOrderNumber': value,
      if (instance.id case final value?) 'id': value,
      if (instance.lineNumber case final value?) 'lineNumber': value,
      if (instance.linePOReference case final value?) 'linePOReference': value,
      if (instance.lineTotal case final value?) 'lineTotal': value,
      if (instance.lineTotalDisplay case final value?)
        'lineTotalDisplay': value,
      if (instance.lineType case final value?) 'lineType': value,
      if (instance.manufacturerItem case final value?)
        'manufacturerItem': value,
      if (instance.mediumImagePath case final value?) 'mediumImagePath': value,
      if (instance.message case final value?) 'message': value,
      if (instance.notes case final value?) 'notes': value,
      if (instance.productErpNumber case final value?)
        'productErpNumber': value,
      if (instance.productName case final value?) 'productName': value,
      if (instance.productUri case final value?) 'productUri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.qtyInvoiced case final value?) 'qtyInvoiced': value,
      if (instance.releaseNumber case final value?) 'releaseNumber': value,
      if (instance.shipmentNumber case final value?) 'shipmentNumber': value,
      if (instance.shortDescription case final value?)
        'shortDescription': value,
      if (instance.success case final value?) 'success': value,
      if (instance.unitOfMeasure case final value?) 'unitOfMeasure': value,
      if (instance.unitPrice case final value?) 'unitPrice': value,
      if (instance.unitPriceDisplay case final value?)
        'unitPriceDisplay': value,
      if (instance.warehouse case final value?) 'warehouse': value,
      if (instance.brand?.toJson() case final value?) 'brand': value,
    };

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

Map<String, dynamic> _$InvoiceTaxModelToJson(InvoiceTaxModel instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.message case final value?) 'message': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.sortOrder case final value?) 'sortOrder': value,
      if (instance.success case final value?) 'success': value,
      if (instance.taxAmount case final value?) 'taxAmount': value,
      if (instance.taxAmountDisplay case final value?)
        'taxAmountDisplay': value,
      if (instance.taxCode case final value?) 'taxCode': value,
      if (instance.taxDescription case final value?) 'taxDescription': value,
      if (instance.taxRate case final value?) 'taxRate': value,
    };
