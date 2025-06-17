// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cart _$CartFromJson(Map<String, dynamic> json) => Cart(
      cartLinesUri: json['cartLinesUri'] as String?,
      id: json['id'] as String?,
      status: json['status'] as String?,
      statusDisplay: json['statusDisplay'] as String?,
      type: json['type'] as String?,
      typeDisplay: json['typeDisplay'] as String?,
      orderNumber: json['orderNumber'] as String?,
      erpOrderNumber: json['erpOrderNumber'] as String?,
      orderDate: json['orderDate'] == null
          ? null
          : DateTime.parse(json['orderDate'] as String),
      billTo: json['billTo'] == null
          ? null
          : BillTo.fromJson(json['billTo'] as Map<String, dynamic>),
      shipTo: json['shipTo'] == null
          ? null
          : ShipTo.fromJson(json['shipTo'] as Map<String, dynamic>),
      userLabel: json['userLabel'] as String?,
      userRoles: json['userRoles'] as String?,
      shipToLabel: json['shipToLabel'] as String?,
      notes: json['notes'] as String?,
      carrier: json['carrier'] == null
          ? null
          : CarrierDto.fromJson(json['carrier'] as Map<String, dynamic>),
      shipVia: json['shipVia'] == null
          ? null
          : ShipViaDto.fromJson(json['shipVia'] as Map<String, dynamic>),
      paymentMethod: json['paymentMethod'] == null
          ? null
          : PaymentMethodDto.fromJson(
              json['paymentMethod'] as Map<String, dynamic>),
      fulfillmentMethod: json['fulfillmentMethod'] as String?,
      poNumber: json['poNumber'] as String?,
      promotionCode: json['promotionCode'] as String?,
      initiatedByUserName: json['initiatedByUserName'] as String?,
      totalQtyOrdered: (json['totalQtyOrdered'] as num?)?.toInt(),
      lineCount: (json['lineCount'] as num?)?.toInt(),
      totalCountDisplay: (json['totalCountDisplay'] as num?)?.toInt(),
      quoteRequiredCount: (json['quoteRequiredCount'] as num?)?.toInt(),
      orderSubTotal: json['orderSubTotal'] as num?,
      orderSubTotalDisplay: json['orderSubTotalDisplay'] as String?,
      orderSubTotalWithOutProductDiscounts:
          json['orderSubTotalWithOutProductDiscounts'] as num?,
      orderSubTotalWithOutProductDiscountsDisplay:
          json['orderSubTotalWithOutProductDiscountsDisplay'] as String?,
      totalTax: json['totalTax'] as num?,
      totalTaxDisplay: json['totalTaxDisplay'] as String?,
      shippingAndHandling: json['shippingAndHandling'] as num?,
      shippingAndHandlingDisplay: json['shippingAndHandlingDisplay'] as String?,
      shippingChargesDisplay: json['shippingChargesDisplay'] as String?,
      handlingChargesDisplay: json['handlingChargesDisplay'] as String?,
      otherChargesDisplay: json['otherChargesDisplay'] as String?,
      orderGrandTotal: json['orderGrandTotal'] as num?,
      orderGrandTotalDisplay: json['orderGrandTotalDisplay'] as String?,
      costCodeLabel: json['costCodeLabel'] as String?,
      isAuthenticated: json['isAuthenticated'] as bool?,
      isGuestOrder: json['isGuestOrder'] as bool?,
      isSalesperson: json['isSalesperson'] as bool?,
      isSubscribed: json['isSubscribed'] as bool?,
      requiresPoNumber: json['requiresPoNumber'] as bool?,
      displayContinueShoppingLink: json['displayContinueShoppingLink'] as bool?,
      canModifyOrder: json['canModifyOrder'] as bool?,
      canSaveOrder: json['canSaveOrder'] as bool?,
      canBypassCheckoutAddress: json['canBypassCheckoutAddress'] as bool?,
      canRequisition: json['canRequisition'] as bool?,
      canRequestQuote: json['canRequestQuote'] as bool?,
      canEditCostCode: json['canEditCostCode'] as bool?,
      showTaxAndShipping: json['showTaxAndShipping'] as bool?,
      showLineNotes: json['showLineNotes'] as bool?,
      showCostCode: json['showCostCode'] as bool?,
      showNewsletterSignup: json['showNewsletterSignup'] as bool?,
      showPoNumber: json['showPoNumber'] as bool?,
      showCreditCard: json['showCreditCard'] as bool?,
      showPayPal: json['showPayPal'] as bool?,
      isAwaitingApproval: json['isAwaitingApproval'] as bool?,
      requiresApproval: json['requiresApproval'] as bool?,
      approverReason: json['approverReason'] as String?,
      hasApprover: json['hasApprover'] as bool?,
      salespersonName: json['salespersonName'] as String?,
      paymentOptions: json['paymentOptions'] == null
          ? null
          : PaymentOptionsDto.fromJson(
              json['paymentOptions'] as Map<String, dynamic>),
      costCodes: (json['costCodes'] as List<dynamic>?)
          ?.map((e) => CostCodeDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      carriers: (json['carriers'] as List<dynamic>?)
          ?.map((e) => CarrierDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      cartLines: (json['cartLines'] as List<dynamic>?)
          ?.map((e) => CartLine.fromJson(e as Map<String, dynamic>))
          .toList(),
      customerOrderTaxes: (json['customerOrderTaxes'] as List<dynamic>?)
          ?.map((e) => CustomerOrderTaxDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      canCheckOut: json['canCheckOut'] as bool?,
      hasInsufficientInventory: json['hasInsufficientInventory'] as bool?,
      currencySymbol: json['currencySymbol'] as String?,
      requestedDeliveryDate: json['requestedDeliveryDate'] as String?,
      requestedDeliveryDateDisplay: json['requestedDeliveryDateDisplay'] == null
          ? null
          : DateTime.parse(json['requestedDeliveryDateDisplay'] as String),
      requestedPickUpDate: json['requestedPickUpDate'] as String?,
      requestedPickUpDateDisplay: json['requestedPickUpDateDisplay'] == null
          ? null
          : DateTime.parse(json['requestedPickUpDateDisplay'] as String),
      cartNotPriced: json['cartNotPriced'] as bool?,
      messages: (json['messages'] as List<dynamic>?)
          ?.map((e) => e as String?)
          .toList(),
      creditCardBillingAddress: json['creditCardBillingAddress'] == null
          ? null
          : CreditCardBillingAddress.fromJson(
              json['creditCardBillingAddress'] as Map<String, dynamic>),
      alsoPurchasedProducts: (json['alsoPurchasedProducts'] as List<dynamic>?)
          ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
      taxFailureReason: json['taxFailureReason'] as String?,
      failedToGetRealTimeInventory:
          json['failedToGetRealTimeInventory'] as bool?,
      unassignCart: json['unassignCart'] as bool?,
      customerVatNumber: json['customerVatNumber'] as String?,
      vmiLocationId: json['vmiLocationId'] as String?,
      defaultWarehouse: json['defaultWarehouse'] == null
          ? null
          : DefaultWarehouseDto.fromJson(
              json['defaultWarehouse'] as Map<String, dynamic>),
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$CartToJson(Cart instance) => <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.cartLinesUri case final value?) 'cartLinesUri': value,
      if (instance.id case final value?) 'id': value,
      if (instance.status case final value?) 'status': value,
      if (instance.statusDisplay case final value?) 'statusDisplay': value,
      if (instance.type case final value?) 'type': value,
      if (instance.typeDisplay case final value?) 'typeDisplay': value,
      if (instance.orderNumber case final value?) 'orderNumber': value,
      if (instance.erpOrderNumber case final value?) 'erpOrderNumber': value,
      if (instance.orderDate?.toIso8601String() case final value?)
        'orderDate': value,
      if (instance.billTo?.toJson() case final value?) 'billTo': value,
      if (instance.shipTo?.toJson() case final value?) 'shipTo': value,
      if (instance.userLabel case final value?) 'userLabel': value,
      if (instance.userRoles case final value?) 'userRoles': value,
      if (instance.shipToLabel case final value?) 'shipToLabel': value,
      if (instance.notes case final value?) 'notes': value,
      if (instance.carrier?.toJson() case final value?) 'carrier': value,
      if (instance.shipVia?.toJson() case final value?) 'shipVia': value,
      if (instance.paymentMethod?.toJson() case final value?)
        'paymentMethod': value,
      if (instance.fulfillmentMethod case final value?)
        'fulfillmentMethod': value,
      if (instance.poNumber case final value?) 'poNumber': value,
      if (instance.promotionCode case final value?) 'promotionCode': value,
      if (instance.initiatedByUserName case final value?)
        'initiatedByUserName': value,
      if (instance.totalQtyOrdered case final value?) 'totalQtyOrdered': value,
      if (instance.lineCount case final value?) 'lineCount': value,
      if (instance.totalCountDisplay case final value?)
        'totalCountDisplay': value,
      if (instance.quoteRequiredCount case final value?)
        'quoteRequiredCount': value,
      if (instance.orderSubTotal case final value?) 'orderSubTotal': value,
      if (instance.orderSubTotalDisplay case final value?)
        'orderSubTotalDisplay': value,
      if (instance.orderSubTotalWithOutProductDiscounts case final value?)
        'orderSubTotalWithOutProductDiscounts': value,
      if (instance.orderSubTotalWithOutProductDiscountsDisplay
          case final value?)
        'orderSubTotalWithOutProductDiscountsDisplay': value,
      if (instance.totalTax case final value?) 'totalTax': value,
      if (instance.totalTaxDisplay case final value?) 'totalTaxDisplay': value,
      if (instance.shippingAndHandling case final value?)
        'shippingAndHandling': value,
      if (instance.shippingAndHandlingDisplay case final value?)
        'shippingAndHandlingDisplay': value,
      if (instance.shippingChargesDisplay case final value?)
        'shippingChargesDisplay': value,
      if (instance.handlingChargesDisplay case final value?)
        'handlingChargesDisplay': value,
      if (instance.otherChargesDisplay case final value?)
        'otherChargesDisplay': value,
      if (instance.orderGrandTotal case final value?) 'orderGrandTotal': value,
      if (instance.orderGrandTotalDisplay case final value?)
        'orderGrandTotalDisplay': value,
      if (instance.costCodeLabel case final value?) 'costCodeLabel': value,
      if (instance.isAuthenticated case final value?) 'isAuthenticated': value,
      if (instance.isGuestOrder case final value?) 'isGuestOrder': value,
      if (instance.isSalesperson case final value?) 'isSalesperson': value,
      if (instance.isSubscribed case final value?) 'isSubscribed': value,
      if (instance.requiresPoNumber case final value?)
        'requiresPoNumber': value,
      if (instance.displayContinueShoppingLink case final value?)
        'displayContinueShoppingLink': value,
      if (instance.canModifyOrder case final value?) 'canModifyOrder': value,
      if (instance.canSaveOrder case final value?) 'canSaveOrder': value,
      if (instance.canBypassCheckoutAddress case final value?)
        'canBypassCheckoutAddress': value,
      if (instance.canRequisition case final value?) 'canRequisition': value,
      if (instance.canRequestQuote case final value?) 'canRequestQuote': value,
      if (instance.canEditCostCode case final value?) 'canEditCostCode': value,
      if (instance.showTaxAndShipping case final value?)
        'showTaxAndShipping': value,
      if (instance.showLineNotes case final value?) 'showLineNotes': value,
      if (instance.showCostCode case final value?) 'showCostCode': value,
      if (instance.showNewsletterSignup case final value?)
        'showNewsletterSignup': value,
      if (instance.showPoNumber case final value?) 'showPoNumber': value,
      if (instance.showCreditCard case final value?) 'showCreditCard': value,
      if (instance.showPayPal case final value?) 'showPayPal': value,
      if (instance.isAwaitingApproval case final value?)
        'isAwaitingApproval': value,
      if (instance.requiresApproval case final value?)
        'requiresApproval': value,
      if (instance.approverReason case final value?) 'approverReason': value,
      if (instance.hasApprover case final value?) 'hasApprover': value,
      if (instance.salespersonName case final value?) 'salespersonName': value,
      if (instance.paymentOptions?.toJson() case final value?)
        'paymentOptions': value,
      if (instance.costCodes?.map((e) => e.toJson()).toList() case final value?)
        'costCodes': value,
      if (instance.carriers?.map((e) => e.toJson()).toList() case final value?)
        'carriers': value,
      if (instance.cartLines?.map((e) => e.toJson()).toList() case final value?)
        'cartLines': value,
      if (instance.customerOrderTaxes?.map((e) => e.toJson()).toList()
          case final value?)
        'customerOrderTaxes': value,
      if (instance.canCheckOut case final value?) 'canCheckOut': value,
      if (instance.hasInsufficientInventory case final value?)
        'hasInsufficientInventory': value,
      if (instance.currencySymbol case final value?) 'currencySymbol': value,
      if (instance.requestedDeliveryDate case final value?)
        'requestedDeliveryDate': value,
      if (instance.requestedDeliveryDateDisplay?.toIso8601String()
          case final value?)
        'requestedDeliveryDateDisplay': value,
      if (instance.requestedPickUpDate case final value?)
        'requestedPickUpDate': value,
      if (instance.requestedPickUpDateDisplay?.toIso8601String()
          case final value?)
        'requestedPickUpDateDisplay': value,
      if (instance.cartNotPriced case final value?) 'cartNotPriced': value,
      if (instance.messages case final value?) 'messages': value,
      if (instance.creditCardBillingAddress?.toJson() case final value?)
        'creditCardBillingAddress': value,
      if (instance.alsoPurchasedProducts?.map((e) => e.toJson()).toList()
          case final value?)
        'alsoPurchasedProducts': value,
      if (instance.taxFailureReason case final value?)
        'taxFailureReason': value,
      if (instance.failedToGetRealTimeInventory case final value?)
        'failedToGetRealTimeInventory': value,
      if (instance.unassignCart case final value?) 'unassignCart': value,
      if (instance.customerVatNumber case final value?)
        'customerVatNumber': value,
      if (instance.vmiLocationId case final value?) 'vmiLocationId': value,
      if (instance.defaultWarehouse?.toJson() case final value?)
        'defaultWarehouse': value,
    };

CarrierDto _$CarrierDtoFromJson(Map<String, dynamic> json) => CarrierDto(
      id: json['id'] as String?,
      description: json['description'] as String?,
      shipVias: (json['shipVias'] as List<dynamic>?)
          ?.map((e) => ShipViaDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CarrierDtoToJson(CarrierDto instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.description case final value?) 'description': value,
      if (instance.shipVias?.map((e) => e.toJson()).toList() case final value?)
        'shipVias': value,
    };

ShipViaDto _$ShipViaDtoFromJson(Map<String, dynamic> json) => ShipViaDto(
      id: json['id'] as String?,
      description: json['description'] as String?,
      isDefault: json['isDefault'] as bool?,
    );

Map<String, dynamic> _$ShipViaDtoToJson(ShipViaDto instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.description case final value?) 'description': value,
      if (instance.isDefault case final value?) 'isDefault': value,
    };

PaymentMethodDto _$PaymentMethodDtoFromJson(Map<String, dynamic> json) =>
    PaymentMethodDto(
      name: json['name'] as String?,
      description: json['description'] as String?,
      isCreditCard: json['isCreditCard'] as bool?,
      isPaymentProfile: json['isPaymentProfile'] as bool?,
      cardType: json['cardType'] as String?,
    );

Map<String, dynamic> _$PaymentMethodDtoToJson(PaymentMethodDto instance) =>
    <String, dynamic>{
      if (instance.name case final value?) 'name': value,
      if (instance.description case final value?) 'description': value,
      if (instance.isCreditCard case final value?) 'isCreditCard': value,
      if (instance.isPaymentProfile case final value?)
        'isPaymentProfile': value,
      if (instance.cardType case final value?) 'cardType': value,
    };

PaymentOptionsDto _$PaymentOptionsDtoFromJson(Map<String, dynamic> json) =>
    PaymentOptionsDto(
      paymentMethods: (json['paymentMethods'] as List<dynamic>?)
          ?.map((e) => PaymentMethodDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      cardTypes: (json['cardTypes'] as List<dynamic>?)
          ?.map((e) =>
              KeyValuePair<String, String>.fromJson(e as Map<String, dynamic>))
          .toList(),
      expirationMonths: (json['expirationMonths'] as List<dynamic>?)
          ?.map((e) =>
              KeyValuePair<String, int>.fromJson(e as Map<String, dynamic>))
          .toList(),
      expirationYears: (json['expirationYears'] as List<dynamic>?)
          ?.map(
              (e) => KeyValuePair<int, int>.fromJson(e as Map<String, dynamic>))
          .toList(),
      creditCard: json['creditCard'] == null
          ? null
          : CreditCardDto.fromJson(json['creditCard'] as Map<String, dynamic>),
      canStorePaymentProfile: json['canStorePaymentProfile'] as bool?,
      storePaymentProfile: json['storePaymentProfile'] as bool?,
      isPayPal: json['isPayPal'] as bool?,
      payPalPayerId: json['payPalPayerId'] as String?,
      payPalToken: json['payPalToken'] as String?,
      payPalPaymentUrl: json['payPalPaymentUrl'] as String?,
    );

Map<String, dynamic> _$PaymentOptionsDtoToJson(PaymentOptionsDto instance) =>
    <String, dynamic>{
      if (instance.paymentMethods?.map((e) => e.toJson()).toList()
          case final value?)
        'paymentMethods': value,
      if (instance.cardTypes?.map((e) => e.toJson()).toList() case final value?)
        'cardTypes': value,
      if (instance.expirationMonths?.map((e) => e.toJson()).toList()
          case final value?)
        'expirationMonths': value,
      if (instance.expirationYears?.map((e) => e.toJson()).toList()
          case final value?)
        'expirationYears': value,
      if (instance.creditCard?.toJson() case final value?) 'creditCard': value,
      if (instance.canStorePaymentProfile case final value?)
        'canStorePaymentProfile': value,
      if (instance.storePaymentProfile case final value?)
        'storePaymentProfile': value,
      if (instance.isPayPal case final value?) 'isPayPal': value,
      if (instance.payPalPayerId case final value?) 'payPalPayerId': value,
      if (instance.payPalToken case final value?) 'payPalToken': value,
      if (instance.payPalPaymentUrl case final value?)
        'payPalPaymentUrl': value,
    };

CreditCardDto _$CreditCardDtoFromJson(Map<String, dynamic> json) =>
    CreditCardDto(
      cardType: json['cardType'] as String?,
      cardHolderName: json['cardHolderName'] as String?,
      cardNumber: json['cardNumber'] as String?,
      expirationMonth: (json['expirationMonth'] as num?)?.toInt(),
      expirationYear: (json['expirationYear'] as num?)?.toInt(),
      securityCode: json['securityCode'] as String?,
      browserInfo: json['browserInfo'] as String?,
    );

Map<String, dynamic> _$CreditCardDtoToJson(CreditCardDto instance) =>
    <String, dynamic>{
      if (instance.cardType case final value?) 'cardType': value,
      if (instance.cardHolderName case final value?) 'cardHolderName': value,
      if (instance.cardNumber case final value?) 'cardNumber': value,
      if (instance.expirationMonth case final value?) 'expirationMonth': value,
      if (instance.expirationYear case final value?) 'expirationYear': value,
      if (instance.securityCode case final value?) 'securityCode': value,
      if (instance.browserInfo case final value?) 'browserInfo': value,
    };

CostCodeDto _$CostCodeDtoFromJson(Map<String, dynamic> json) => CostCodeDto(
      costCode: json['costCode'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$CostCodeDtoToJson(CostCodeDto instance) =>
    <String, dynamic>{
      if (instance.costCode case final value?) 'costCode': value,
      if (instance.description case final value?) 'description': value,
    };

CustomerOrderTaxDto _$CustomerOrderTaxDtoFromJson(Map<String, dynamic> json) =>
    CustomerOrderTaxDto(
      taxCode: json['taxCode'] as String?,
      taxDescription: json['taxDescription'] as String?,
      taxRate: json['taxRate'] as num?,
      taxAmount: json['taxAmount'] as num?,
      taxAmountDisplay: json['taxAmountDisplay'] as String?,
      sortOrder: (json['sortOrder'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CustomerOrderTaxDtoToJson(
        CustomerOrderTaxDto instance) =>
    <String, dynamic>{
      if (instance.taxCode case final value?) 'taxCode': value,
      if (instance.taxDescription case final value?) 'taxDescription': value,
      if (instance.taxRate case final value?) 'taxRate': value,
      if (instance.taxAmount case final value?) 'taxAmount': value,
      if (instance.taxAmountDisplay case final value?)
        'taxAmountDisplay': value,
      if (instance.sortOrder case final value?) 'sortOrder': value,
    };

DefaultWarehouseDto _$DefaultWarehouseDtoFromJson(Map<String, dynamic> json) =>
    DefaultWarehouseDto(
      id: json['id'] as String?,
      name: json['name'] as String?,
      address1: json['address1'] as String?,
      address2: json['address2'] as String?,
      city: json['city'] as String?,
      postalCode: json['postalCode'] as String?,
      state: json['state'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$DefaultWarehouseDtoToJson(
        DefaultWarehouseDto instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.name case final value?) 'name': value,
      if (instance.address1 case final value?) 'address1': value,
      if (instance.address2 case final value?) 'address2': value,
      if (instance.city case final value?) 'city': value,
      if (instance.postalCode case final value?) 'postalCode': value,
      if (instance.state case final value?) 'state': value,
      if (instance.description case final value?) 'description': value,
    };

CartLineCollectionDto _$CartLineCollectionDtoFromJson(
        Map<String, dynamic> json) =>
    CartLineCollectionDto(
      cartLines: (json['cartLines'] as List<dynamic>?)
          ?.map((e) => CartLine.fromJson(e as Map<String, dynamic>))
          .toList(),
      notAllAddedToCart: json['notAllAddedToCart'] as bool?,
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CartLineCollectionDtoToJson(
        CartLineCollectionDto instance) =>
    <String, dynamic>{
      if (instance.cartLines?.map((e) => e.toJson()).toList() case final value?)
        'cartLines': value,
      if (instance.notAllAddedToCart case final value?)
        'notAllAddedToCart': value,
      if (instance.pagination?.toJson() case final value?) 'pagination': value,
    };

CartCollectionModel _$CartCollectionModelFromJson(Map<String, dynamic> json) =>
    CartCollectionModel(
      carts: (json['carts'] as List<dynamic>?)
          ?.map((e) => Cart.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$CartCollectionModelToJson(
        CartCollectionModel instance) =>
    <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.carts?.map((e) => e.toJson()).toList() case final value?)
        'carts': value,
      if (instance.pagination?.toJson() case final value?) 'pagination': value,
    };
