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

Map<String, dynamic> _$CartToJson(Cart instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uri', instance.uri);
  writeNotNull('properties', instance.properties);
  writeNotNull('cartLinesUri', instance.cartLinesUri);
  writeNotNull('id', instance.id);
  writeNotNull('status', instance.status);
  writeNotNull('statusDisplay', instance.statusDisplay);
  writeNotNull('type', instance.type);
  writeNotNull('typeDisplay', instance.typeDisplay);
  writeNotNull('orderNumber', instance.orderNumber);
  writeNotNull('erpOrderNumber', instance.erpOrderNumber);
  writeNotNull('orderDate', instance.orderDate?.toIso8601String());
  writeNotNull('billTo', instance.billTo?.toJson());
  writeNotNull('shipTo', instance.shipTo?.toJson());
  writeNotNull('userLabel', instance.userLabel);
  writeNotNull('userRoles', instance.userRoles);
  writeNotNull('shipToLabel', instance.shipToLabel);
  writeNotNull('notes', instance.notes);
  writeNotNull('carrier', instance.carrier?.toJson());
  writeNotNull('shipVia', instance.shipVia?.toJson());
  writeNotNull('paymentMethod', instance.paymentMethod?.toJson());
  writeNotNull('fulfillmentMethod', instance.fulfillmentMethod);
  writeNotNull('poNumber', instance.poNumber);
  writeNotNull('promotionCode', instance.promotionCode);
  writeNotNull('initiatedByUserName', instance.initiatedByUserName);
  writeNotNull('totalQtyOrdered', instance.totalQtyOrdered);
  writeNotNull('lineCount', instance.lineCount);
  writeNotNull('totalCountDisplay', instance.totalCountDisplay);
  writeNotNull('quoteRequiredCount', instance.quoteRequiredCount);
  writeNotNull('orderSubTotal', instance.orderSubTotal);
  writeNotNull('orderSubTotalDisplay', instance.orderSubTotalDisplay);
  writeNotNull('orderSubTotalWithOutProductDiscounts',
      instance.orderSubTotalWithOutProductDiscounts);
  writeNotNull('orderSubTotalWithOutProductDiscountsDisplay',
      instance.orderSubTotalWithOutProductDiscountsDisplay);
  writeNotNull('totalTax', instance.totalTax);
  writeNotNull('totalTaxDisplay', instance.totalTaxDisplay);
  writeNotNull('shippingAndHandling', instance.shippingAndHandling);
  writeNotNull(
      'shippingAndHandlingDisplay', instance.shippingAndHandlingDisplay);
  writeNotNull('shippingChargesDisplay', instance.shippingChargesDisplay);
  writeNotNull('handlingChargesDisplay', instance.handlingChargesDisplay);
  writeNotNull('otherChargesDisplay', instance.otherChargesDisplay);
  writeNotNull('orderGrandTotal', instance.orderGrandTotal);
  writeNotNull('orderGrandTotalDisplay', instance.orderGrandTotalDisplay);
  writeNotNull('costCodeLabel', instance.costCodeLabel);
  writeNotNull('isAuthenticated', instance.isAuthenticated);
  writeNotNull('isGuestOrder', instance.isGuestOrder);
  writeNotNull('isSalesperson', instance.isSalesperson);
  writeNotNull('isSubscribed', instance.isSubscribed);
  writeNotNull('requiresPoNumber', instance.requiresPoNumber);
  writeNotNull(
      'displayContinueShoppingLink', instance.displayContinueShoppingLink);
  writeNotNull('canModifyOrder', instance.canModifyOrder);
  writeNotNull('canSaveOrder', instance.canSaveOrder);
  writeNotNull('canBypassCheckoutAddress', instance.canBypassCheckoutAddress);
  writeNotNull('canRequisition', instance.canRequisition);
  writeNotNull('canRequestQuote', instance.canRequestQuote);
  writeNotNull('canEditCostCode', instance.canEditCostCode);
  writeNotNull('showTaxAndShipping', instance.showTaxAndShipping);
  writeNotNull('showLineNotes', instance.showLineNotes);
  writeNotNull('showCostCode', instance.showCostCode);
  writeNotNull('showNewsletterSignup', instance.showNewsletterSignup);
  writeNotNull('showPoNumber', instance.showPoNumber);
  writeNotNull('showCreditCard', instance.showCreditCard);
  writeNotNull('showPayPal', instance.showPayPal);
  writeNotNull('isAwaitingApproval', instance.isAwaitingApproval);
  writeNotNull('requiresApproval', instance.requiresApproval);
  writeNotNull('approverReason', instance.approverReason);
  writeNotNull('hasApprover', instance.hasApprover);
  writeNotNull('salespersonName', instance.salespersonName);
  writeNotNull('paymentOptions', instance.paymentOptions?.toJson());
  writeNotNull(
      'costCodes', instance.costCodes?.map((e) => e.toJson()).toList());
  writeNotNull('carriers', instance.carriers?.map((e) => e.toJson()).toList());
  writeNotNull(
      'cartLines', instance.cartLines?.map((e) => e.toJson()).toList());
  writeNotNull('customerOrderTaxes',
      instance.customerOrderTaxes?.map((e) => e.toJson()).toList());
  writeNotNull('canCheckOut', instance.canCheckOut);
  writeNotNull('hasInsufficientInventory', instance.hasInsufficientInventory);
  writeNotNull('currencySymbol', instance.currencySymbol);
  writeNotNull('requestedDeliveryDate', instance.requestedDeliveryDate);
  writeNotNull('requestedDeliveryDateDisplay',
      instance.requestedDeliveryDateDisplay?.toIso8601String());
  writeNotNull('requestedPickUpDate', instance.requestedPickUpDate);
  writeNotNull('requestedPickUpDateDisplay',
      instance.requestedPickUpDateDisplay?.toIso8601String());
  writeNotNull('cartNotPriced', instance.cartNotPriced);
  writeNotNull('messages', instance.messages);
  writeNotNull(
      'creditCardBillingAddress', instance.creditCardBillingAddress?.toJson());
  writeNotNull('alsoPurchasedProducts',
      instance.alsoPurchasedProducts?.map((e) => e.toJson()).toList());
  writeNotNull('taxFailureReason', instance.taxFailureReason);
  writeNotNull(
      'failedToGetRealTimeInventory', instance.failedToGetRealTimeInventory);
  writeNotNull('unassignCart', instance.unassignCart);
  writeNotNull('customerVatNumber', instance.customerVatNumber);
  writeNotNull('vmiLocationId', instance.vmiLocationId);
  writeNotNull('defaultWarehouse', instance.defaultWarehouse?.toJson());
  return val;
}

CarrierDto _$CarrierDtoFromJson(Map<String, dynamic> json) => CarrierDto(
      id: json['id'] as String?,
      description: json['description'] as String?,
      shipVias: (json['shipVias'] as List<dynamic>?)
          ?.map((e) => ShipViaDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CarrierDtoToJson(CarrierDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('description', instance.description);
  writeNotNull('shipVias', instance.shipVias?.map((e) => e.toJson()).toList());
  return val;
}

ShipViaDto _$ShipViaDtoFromJson(Map<String, dynamic> json) => ShipViaDto(
      id: json['id'] as String?,
      description: json['description'] as String?,
      isDefault: json['isDefault'] as bool?,
    );

Map<String, dynamic> _$ShipViaDtoToJson(ShipViaDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('description', instance.description);
  writeNotNull('isDefault', instance.isDefault);
  return val;
}

PaymentMethodDto _$PaymentMethodDtoFromJson(Map<String, dynamic> json) =>
    PaymentMethodDto(
      name: json['name'] as String?,
      description: json['description'] as String?,
      isCreditCard: json['isCreditCard'] as bool?,
      isPaymentProfile: json['isPaymentProfile'] as bool?,
      cardType: json['cardType'] as String?,
    );

Map<String, dynamic> _$PaymentMethodDtoToJson(PaymentMethodDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  writeNotNull('description', instance.description);
  writeNotNull('isCreditCard', instance.isCreditCard);
  writeNotNull('isPaymentProfile', instance.isPaymentProfile);
  writeNotNull('cardType', instance.cardType);
  return val;
}

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

Map<String, dynamic> _$PaymentOptionsDtoToJson(PaymentOptionsDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('paymentMethods',
      instance.paymentMethods?.map((e) => e.toJson()).toList());
  writeNotNull(
      'cardTypes', instance.cardTypes?.map((e) => e.toJson()).toList());
  writeNotNull('expirationMonths',
      instance.expirationMonths?.map((e) => e.toJson()).toList());
  writeNotNull('expirationYears',
      instance.expirationYears?.map((e) => e.toJson()).toList());
  writeNotNull('creditCard', instance.creditCard?.toJson());
  writeNotNull('canStorePaymentProfile', instance.canStorePaymentProfile);
  writeNotNull('storePaymentProfile', instance.storePaymentProfile);
  writeNotNull('isPayPal', instance.isPayPal);
  writeNotNull('payPalPayerId', instance.payPalPayerId);
  writeNotNull('payPalToken', instance.payPalToken);
  writeNotNull('payPalPaymentUrl', instance.payPalPaymentUrl);
  return val;
}

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

Map<String, dynamic> _$CreditCardDtoToJson(CreditCardDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('cardType', instance.cardType);
  writeNotNull('cardHolderName', instance.cardHolderName);
  writeNotNull('cardNumber', instance.cardNumber);
  writeNotNull('expirationMonth', instance.expirationMonth);
  writeNotNull('expirationYear', instance.expirationYear);
  writeNotNull('securityCode', instance.securityCode);
  writeNotNull('browserInfo', instance.browserInfo);
  return val;
}

CostCodeDto _$CostCodeDtoFromJson(Map<String, dynamic> json) => CostCodeDto(
      costCode: json['costCode'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$CostCodeDtoToJson(CostCodeDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('costCode', instance.costCode);
  writeNotNull('description', instance.description);
  return val;
}

CustomerOrderTaxDto _$CustomerOrderTaxDtoFromJson(Map<String, dynamic> json) =>
    CustomerOrderTaxDto(
      taxCode: json['taxCode'] as String?,
      taxDescription: json['taxDescription'] as String?,
      taxRate: json['taxRate'] as num?,
      taxAmount: json['taxAmount'] as num?,
      taxAmountDisplay: json['taxAmountDisplay'] as String?,
      sortOrder: (json['sortOrder'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CustomerOrderTaxDtoToJson(CustomerOrderTaxDto instance) {
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

Map<String, dynamic> _$DefaultWarehouseDtoToJson(DefaultWarehouseDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('address1', instance.address1);
  writeNotNull('address2', instance.address2);
  writeNotNull('city', instance.city);
  writeNotNull('postalCode', instance.postalCode);
  writeNotNull('state', instance.state);
  writeNotNull('description', instance.description);
  return val;
}

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
    CartLineCollectionDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'cartLines', instance.cartLines?.map((e) => e.toJson()).toList());
  writeNotNull('notAllAddedToCart', instance.notAllAddedToCart);
  writeNotNull('pagination', instance.pagination?.toJson());
  return val;
}

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

Map<String, dynamic> _$CartCollectionModelToJson(CartCollectionModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uri', instance.uri);
  writeNotNull('properties', instance.properties);
  writeNotNull('carts', instance.carts?.map((e) => e.toJson()).toList());
  writeNotNull('pagination', instance.pagination?.toJson());
  return val;
}
