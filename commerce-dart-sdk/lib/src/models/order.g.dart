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

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.erpOrderNumber case final value?) 'erpOrderNumber': value,
      if (instance.webOrderNumber case final value?) 'webOrderNumber': value,
      if (instance.orderDate?.toIso8601String() case final value?)
        'orderDate': value,
      if (instance.status case final value?) 'status': value,
      if (instance.statusDisplay case final value?) 'statusDisplay': value,
      if (instance.customerNumber case final value?) 'customerNumber': value,
      if (instance.customerSequence case final value?)
        'customerSequence': value,
      if (instance.customerPO case final value?) 'customerPO': value,
      if (instance.currencyCode case final value?) 'currencyCode': value,
      if (instance.currencySymbol case final value?) 'currencySymbol': value,
      if (instance.terms case final value?) 'terms': value,
      if (instance.shipCode case final value?) 'shipCode': value,
      if (instance.salesperson case final value?) 'salesperson': value,
      if (instance.btCompanyName case final value?) 'btCompanyName': value,
      if (instance.btAddress1 case final value?) 'btAddress1': value,
      if (instance.btAddress2 case final value?) 'btAddress2': value,
      if (instance.billToCity case final value?) 'billToCity': value,
      if (instance.billToState case final value?) 'billToState': value,
      if (instance.billToPostalCode case final value?)
        'billToPostalCode': value,
      if (instance.btCountry case final value?) 'btCountry': value,
      if (instance.stCompanyName case final value?) 'stCompanyName': value,
      if (instance.stAddress1 case final value?) 'stAddress1': value,
      if (instance.stAddress2 case final value?) 'stAddress2': value,
      if (instance.stAddress3 case final value?) 'stAddress3': value,
      if (instance.stAddress4 case final value?) 'stAddress4': value,
      if (instance.shipToCity case final value?) 'shipToCity': value,
      if (instance.shipToState case final value?) 'shipToState': value,
      if (instance.shipToPostalCode case final value?)
        'shipToPostalCode': value,
      if (instance.stCountry case final value?) 'stCountry': value,
      if (instance.notes case final value?) 'notes': value,
      if (instance.productTotal case final value?) 'productTotal': value,
      if (instance.orderSubTotal case final value?) 'orderSubTotal': value,
      if (instance.orderDiscountAmount case final value?)
        'orderDiscountAmount': value,
      if (instance.productDiscountAmount case final value?)
        'productDiscountAmount': value,
      if (instance.shippingAndHandling case final value?)
        'shippingAndHandling': value,
      if (instance.shippingCharges case final value?) 'shippingCharges': value,
      if (instance.handlingCharges case final value?) 'handlingCharges': value,
      if (instance.otherCharges case final value?) 'otherCharges': value,
      if (instance.taxAmount case final value?) 'taxAmount': value,
      if (instance.orderTotal case final value?) 'orderTotal': value,
      if (instance.modifyDate?.toIso8601String() case final value?)
        'modifyDate': value,
      if (instance.requestedDeliveryDateDisplay?.toIso8601String()
          case final value?)
        'requestedDeliveryDateDisplay': value,
      if (instance.orderLines?.map((e) => e.toJson()).toList()
          case final value?)
        'orderLines': value,
      if (instance.orderPromotions?.map((e) => e.toJson()).toList()
          case final value?)
        'orderPromotions': value,
      if (instance.shipmentPackages?.map((e) => e.toJson()).toList()
          case final value?)
        'shipmentPackages': value,
      if (instance.returnReasons case final value?) 'returnReasons': value,
      if (instance.orderHistoryTaxes?.map((e) => e.toJson()).toList()
          case final value?)
        'orderHistoryTaxes': value,
      if (instance.productTotalDisplay case final value?)
        'productTotalDisplay': value,
      if (instance.orderSubTotalDisplay case final value?)
        'orderSubTotalDisplay': value,
      if (instance.orderGrandTotalDisplay case final value?)
        'orderGrandTotalDisplay': value,
      if (instance.orderDiscountAmountDisplay case final value?)
        'orderDiscountAmountDisplay': value,
      if (instance.productDiscountAmountDisplay case final value?)
        'productDiscountAmountDisplay': value,
      if (instance.taxAmountDisplay case final value?)
        'taxAmountDisplay': value,
      if (instance.totalTaxDisplay case final value?) 'totalTaxDisplay': value,
      if (instance.shippingAndHandlingDisplay case final value?)
        'shippingAndHandlingDisplay': value,
      if (instance.shippingChargesDisplay case final value?)
        'shippingChargesDisplay': value,
      if (instance.handlingChargesDisplay case final value?)
        'handlingChargesDisplay': value,
      if (instance.otherChargesDisplay case final value?)
        'otherChargesDisplay': value,
      if (instance.canAddToCart case final value?) 'canAddToCart': value,
      if (instance.canAddAllToCart case final value?) 'canAddAllToCart': value,
      if (instance.showTaxAndShipping case final value?)
        'showTaxAndShipping': value,
      if (instance.shipViaDescription case final value?)
        'shipViaDescription': value,
      if (instance.fulfillmentMethod case final value?)
        'fulfillmentMethod': value,
      if (instance.vmiLocationId case final value?) 'vmiLocationId': value,
      if (instance.vmiLocationName case final value?) 'vmiLocationName': value,
    };

OrderHistoryTaxDto _$OrderHistoryTaxDtoFromJson(Map<String, dynamic> json) =>
    OrderHistoryTaxDto(
      taxCode: json['taxCode'] as String?,
      taxDescription: json['taxDescription'] as String?,
      taxRate: json['taxRate'] as num?,
      taxAmount: json['taxAmount'] as num?,
      taxAmountDisplay: json['taxAmountDisplay'] as String?,
      sortOrder: (json['sortOrder'] as num?)?.toInt(),
    );

Map<String, dynamic> _$OrderHistoryTaxDtoToJson(OrderHistoryTaxDto instance) =>
    <String, dynamic>{
      if (instance.taxCode case final value?) 'taxCode': value,
      if (instance.taxDescription case final value?) 'taxDescription': value,
      if (instance.taxRate case final value?) 'taxRate': value,
      if (instance.taxAmount case final value?) 'taxAmount': value,
      if (instance.taxAmountDisplay case final value?)
        'taxAmountDisplay': value,
      if (instance.sortOrder case final value?) 'sortOrder': value,
    };

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

Map<String, dynamic> _$ShipmentPackageDtoToJson(ShipmentPackageDto instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.shipmentDate?.toIso8601String() case final value?)
        'shipmentDate': value,
      if (instance.carrier case final value?) 'carrier': value,
      if (instance.shipVia case final value?) 'shipVia': value,
      if (instance.trackingUrl case final value?) 'trackingUrl': value,
      if (instance.trackingNumber case final value?) 'trackingNumber': value,
      if (instance.packSlip case final value?) 'packSlip': value,
    };

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

Map<String, dynamic> _$OrderStatusMappingToJson(OrderStatusMapping instance) =>
    <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.id case final value?) 'id': value,
      if (instance.erpOrderStatus case final value?) 'erpOrderStatus': value,
      if (instance.displayName case final value?) 'displayName': value,
      if (instance.isDefault case final value?) 'isDefault': value,
      if (instance.allowRma case final value?) 'allowRma': value,
      if (instance.allowCancellation case final value?)
        'allowCancellation': value,
    };
