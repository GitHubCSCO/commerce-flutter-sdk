// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      billToCity: json['billToCity'] as String?,
      billToPostalCode: json['billToPostalCode'] as String?,
      billToState: json['billToState'] as String?,
      btAddress1: json['btAddress1'] as String?,
      btAddress2: json['btAddress2'] as String?,
      btCompanyName: json['btCompanyName'] as String?,
      btCountry: json['btCountry'] as String?,
      canAddAllToCart: json['canAddAllToCart'] as bool?,
      canAddToCart: json['canAddToCart'] as bool?,
      currencyCode: json['currencyCode'] as String?,
      currencySymbol: json['currencySymbol'] as String?,
      customerNumber: json['customerNumber'] as String?,
      customerPO: json['customerPO'] as String?,
      customerSequence: json['customerSequence'] as String?,
      erpOrderNumber: json['erpOrderNumber'] as String?,
      fulfillmentMethod: json['fulfillmentMethod'] as String?,
      handlingCharges: json['handlingCharges'] as num?,
      handlingChargesDisplay: json['handlingChargesDisplay'] as String?,
      id: json['id'] as String?,
      modifyDate: json['modifyDate'] == null
          ? null
          : DateTime.parse(json['modifyDate'] as String),
      notes: json['notes'] as String?,
      orderDate: json['orderDate'] == null
          ? null
          : DateTime.parse(json['orderDate'] as String),
      orderDiscountAmount: json['orderDiscountAmount'] as num?,
      orderDiscountAmountDisplay: json['orderDiscountAmountDisplay'] as String?,
      orderGrandTotalDisplay: json['orderGrandTotalDisplay'] as String?,
      orderHistoryTaxes: (json['orderHistoryTaxes'] as List<dynamic>?)
          ?.map((e) => OrderHistoryTaxDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      orderLines: (json['orderLines'] as List<dynamic>?)
          ?.map((e) => OrderLine.fromJson(e as Map<String, dynamic>))
          .toList(),
      orderPromotions: (json['orderPromotions'] as List<dynamic>?)
          ?.map((e) => OrderPromotion.fromJson(e as Map<String, dynamic>))
          .toList(),
      orderSubTotal: json['orderSubTotal'] as num?,
      orderSubTotalDisplay: json['orderSubTotalDisplay'] as String?,
      orderTotal: json['orderTotal'] as num?,
      otherCharges: json['otherCharges'] as num?,
      otherChargesDisplay: json['otherChargesDisplay'] as String?,
      productDiscountAmount: json['productDiscountAmount'] as num?,
      productDiscountAmountDisplay:
          json['productDiscountAmountDisplay'] as String?,
      productTotal: json['productTotal'] as num?,
      productTotalDisplay: json['productTotalDisplay'] as String?,
      requestedDeliveryDateDisplay: json['requestedDeliveryDateDisplay'] == null
          ? null
          : DateTime.parse(json['requestedDeliveryDateDisplay'] as String),
      returnReasons: (json['returnReasons'] as List<dynamic>?)
          ?.map((e) => e as String?)
          .toList(),
      salesperson: json['salesperson'] as String?,
      shipCode: json['shipCode'] as String?,
      shipToCity: json['shipToCity'] as String?,
      shipToPostalCode: json['shipToPostalCode'] as String?,
      shipToState: json['shipToState'] as String?,
      shipViaDescription: json['shipViaDescription'] as String?,
      shipmentPackages: (json['shipmentPackages'] as List<dynamic>?)
          ?.map((e) => ShipmentPackageDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      shippingAndHandling: json['shippingAndHandling'] as num?,
      shippingAndHandlingDisplay: json['shippingAndHandlingDisplay'] as String?,
      shippingCharges: json['shippingCharges'] as num?,
      shippingChargesDisplay: json['shippingChargesDisplay'] as String?,
      showTaxAndShipping: json['showTaxAndShipping'] as bool?,
      stAddress1: json['stAddress1'] as String?,
      stAddress2: json['stAddress2'] as String?,
      stAddress3: json['stAddress3'] as String?,
      stAddress4: json['stAddress4'] as String?,
      stCompanyName: json['stCompanyName'] as String?,
      stCountry: json['stCountry'] as String?,
      status: json['status'] as String?,
      statusDisplay: json['statusDisplay'] as String?,
      taxAmount: json['taxAmount'] as num?,
      taxAmountDisplay: json['taxAmountDisplay'] as String?,
      terms: json['terms'] as String?,
      totalTaxDisplay: json['totalTaxDisplay'] as String?,
      vmiLocationId: json['vmiLocationId'] as String?,
      vmiLocationName: json['vmiLocationName'] as String?,
      webOrderNumber: json['webOrderNumber'] as String?,
    );

Map<String, dynamic> _$OrderToJson(Order instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('erpOrderNumber', instance.erpOrderNumber);
  writeNotNull('webOrderNumber', instance.webOrderNumber);
  writeNotNull('orderDate', instance.orderDate?.toIso8601String());
  writeNotNull('status', instance.status);
  writeNotNull('statusDisplay', instance.statusDisplay);
  writeNotNull('customerNumber', instance.customerNumber);
  writeNotNull('customerSequence', instance.customerSequence);
  writeNotNull('customerPO', instance.customerPO);
  writeNotNull('currencyCode', instance.currencyCode);
  writeNotNull('currencySymbol', instance.currencySymbol);
  writeNotNull('terms', instance.terms);
  writeNotNull('shipCode', instance.shipCode);
  writeNotNull('salesperson', instance.salesperson);
  writeNotNull('btCompanyName', instance.btCompanyName);
  writeNotNull('btAddress1', instance.btAddress1);
  writeNotNull('btAddress2', instance.btAddress2);
  writeNotNull('billToCity', instance.billToCity);
  writeNotNull('billToState', instance.billToState);
  writeNotNull('billToPostalCode', instance.billToPostalCode);
  writeNotNull('btCountry', instance.btCountry);
  writeNotNull('stCompanyName', instance.stCompanyName);
  writeNotNull('stAddress1', instance.stAddress1);
  writeNotNull('stAddress2', instance.stAddress2);
  writeNotNull('stAddress3', instance.stAddress3);
  writeNotNull('stAddress4', instance.stAddress4);
  writeNotNull('shipToCity', instance.shipToCity);
  writeNotNull('shipToState', instance.shipToState);
  writeNotNull('shipToPostalCode', instance.shipToPostalCode);
  writeNotNull('stCountry', instance.stCountry);
  writeNotNull('notes', instance.notes);
  writeNotNull('productTotal', instance.productTotal);
  writeNotNull('orderSubTotal', instance.orderSubTotal);
  writeNotNull('orderDiscountAmount', instance.orderDiscountAmount);
  writeNotNull('productDiscountAmount', instance.productDiscountAmount);
  writeNotNull('shippingAndHandling', instance.shippingAndHandling);
  writeNotNull('shippingCharges', instance.shippingCharges);
  writeNotNull('handlingCharges', instance.handlingCharges);
  writeNotNull('otherCharges', instance.otherCharges);
  writeNotNull('taxAmount', instance.taxAmount);
  writeNotNull('orderTotal', instance.orderTotal);
  writeNotNull('modifyDate', instance.modifyDate?.toIso8601String());
  writeNotNull('requestedDeliveryDateDisplay',
      instance.requestedDeliveryDateDisplay?.toIso8601String());
  writeNotNull(
      'orderLines', instance.orderLines?.map((e) => e.toJson()).toList());
  writeNotNull('orderPromotions',
      instance.orderPromotions?.map((e) => e.toJson()).toList());
  writeNotNull('shipmentPackages',
      instance.shipmentPackages?.map((e) => e.toJson()).toList());
  writeNotNull('returnReasons', instance.returnReasons);
  writeNotNull('orderHistoryTaxes',
      instance.orderHistoryTaxes?.map((e) => e.toJson()).toList());
  writeNotNull('productTotalDisplay', instance.productTotalDisplay);
  writeNotNull('orderSubTotalDisplay', instance.orderSubTotalDisplay);
  writeNotNull('orderGrandTotalDisplay', instance.orderGrandTotalDisplay);
  writeNotNull(
      'orderDiscountAmountDisplay', instance.orderDiscountAmountDisplay);
  writeNotNull(
      'productDiscountAmountDisplay', instance.productDiscountAmountDisplay);
  writeNotNull('taxAmountDisplay', instance.taxAmountDisplay);
  writeNotNull('totalTaxDisplay', instance.totalTaxDisplay);
  writeNotNull(
      'shippingAndHandlingDisplay', instance.shippingAndHandlingDisplay);
  writeNotNull('shippingChargesDisplay', instance.shippingChargesDisplay);
  writeNotNull('handlingChargesDisplay', instance.handlingChargesDisplay);
  writeNotNull('otherChargesDisplay', instance.otherChargesDisplay);
  writeNotNull('canAddToCart', instance.canAddToCart);
  writeNotNull('canAddAllToCart', instance.canAddAllToCart);
  writeNotNull('showTaxAndShipping', instance.showTaxAndShipping);
  writeNotNull('shipViaDescription', instance.shipViaDescription);
  writeNotNull('fulfillmentMethod', instance.fulfillmentMethod);
  writeNotNull('vmiLocationId', instance.vmiLocationId);
  writeNotNull('vmiLocationName', instance.vmiLocationName);
  return val;
}

OrderHistoryTaxDto _$OrderHistoryTaxDtoFromJson(Map<String, dynamic> json) =>
    OrderHistoryTaxDto(
      taxCode: json['taxCode'] as String?,
      taxDescription: json['taxDescription'] as String?,
      taxRate: json['taxRate'] as num?,
      taxAmount: json['taxAmount'] as num?,
      taxAmountDisplay: json['taxAmountDisplay'] as String?,
      sortOrder: (json['sortOrder'] as num?)?.toInt(),
    );

Map<String, dynamic> _$OrderHistoryTaxDtoToJson(OrderHistoryTaxDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('taxCode', instance.taxCode);
  writeNotNull('taxDescription', instance.taxDescription);
  writeNotNull('taxRate', instance.taxRate);
  writeNotNull('taxAmount', instance.taxAmount);
  writeNotNull('taxAmountDisplay', instance.taxAmountDisplay);
  writeNotNull('sortOrder', instance.sortOrder);
  return val;
}

ShipmentPackageDto _$ShipmentPackageDtoFromJson(Map<String, dynamic> json) =>
    ShipmentPackageDto(
      id: json['id'] as String?,
      shipmentDate: json['shipmentDate'] == null
          ? null
          : DateTime.parse(json['shipmentDate'] as String),
      carrier: json['carrier'] as String?,
      shipVia: json['shipVia'] as String?,
      trackingUrl: json['trackingUrl'] as String?,
      trackingNumber: json['trackingNumber'] as String?,
      packSlip: json['packSlip'] as String?,
    );

Map<String, dynamic> _$ShipmentPackageDtoToJson(ShipmentPackageDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('shipmentDate', instance.shipmentDate?.toIso8601String());
  writeNotNull('carrier', instance.carrier);
  writeNotNull('shipVia', instance.shipVia);
  writeNotNull('trackingUrl', instance.trackingUrl);
  writeNotNull('trackingNumber', instance.trackingNumber);
  writeNotNull('packSlip', instance.packSlip);
  return val;
}

OrderStatusMapping _$OrderStatusMappingFromJson(Map<String, dynamic> json) =>
    OrderStatusMapping(
      id: json['id'] as String?,
      erpOrderStatus: json['erpOrderStatus'] as String?,
      displayName: json['displayName'] as String?,
      isDefault: json['isDefault'] as bool?,
      allowRma: json['allowRma'] as bool?,
      allowCancellation: json['allowCancellation'] as bool?,
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$OrderStatusMappingToJson(OrderStatusMapping instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uri', instance.uri);
  writeNotNull('properties', instance.properties);
  writeNotNull('id', instance.id);
  writeNotNull('erpOrderStatus', instance.erpOrderStatus);
  writeNotNull('displayName', instance.displayName);
  writeNotNull('isDefault', instance.isDefault);
  writeNotNull('allowRma', instance.allowRma);
  writeNotNull('allowCancellation', instance.allowCancellation);
  return val;
}
