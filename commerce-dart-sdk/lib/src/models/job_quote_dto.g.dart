// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_quote_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobQuoteDto _$JobQuoteDtoFromJson(Map<String, dynamic> json) => JobQuoteDto(
      jobQuoteId: json['jobQuoteId'] as String?,
      isEditable: json['isEditable'] as bool?,
      expirationDate: json['expirationDate'] == null
          ? null
          : DateTime.parse(json['expirationDate'] as String),
      jobName: json['jobName'] as String?,
      jobQuoteLineCollection: (json['jobQuoteLineCollection'] as List<dynamic>?)
          ?.map((e) => JobQuoteLine.fromJson(e as Map<String, dynamic>))
          .toList(),
      customerName: json['customerName'] as String?,
      shipToFullAddress: json['shipToFullAddress'] as String?,
      orderTotal: json['orderTotal'] as num?,
      orderTotalDisplay: json['orderTotalDisplay'] as String?,
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      )
      ..cartLinesUri = json['cartLinesUri'] as String?
      ..id = json['id'] as String?
      ..status = json['status'] as String?
      ..statusDisplay = json['statusDisplay'] as String?
      ..type = json['type'] as String?
      ..typeDisplay = json['typeDisplay'] as String?
      ..orderNumber = json['orderNumber'] as String?
      ..erpOrderNumber = json['erpOrderNumber'] as String?
      ..orderDate = json['orderDate'] == null
          ? null
          : DateTime.parse(json['orderDate'] as String)
      ..billTo = json['billTo'] == null
          ? null
          : BillTo.fromJson(json['billTo'] as Map<String, dynamic>)
      ..shipTo = json['shipTo'] == null
          ? null
          : ShipTo.fromJson(json['shipTo'] as Map<String, dynamic>)
      ..userLabel = json['userLabel'] as String?
      ..userRoles = json['userRoles'] as String?
      ..shipToLabel = json['shipToLabel'] as String?
      ..notes = json['notes'] as String?
      ..carrier = json['carrier'] == null
          ? null
          : CarrierDto.fromJson(json['carrier'] as Map<String, dynamic>)
      ..shipVia = json['shipVia'] == null
          ? null
          : ShipViaDto.fromJson(json['shipVia'] as Map<String, dynamic>)
      ..paymentMethod = json['paymentMethod'] == null
          ? null
          : PaymentMethodDto.fromJson(
              json['paymentMethod'] as Map<String, dynamic>)
      ..fulfillmentMethod = json['fulfillmentMethod'] as String?
      ..poNumber = json['poNumber'] as String?
      ..promotionCode = json['promotionCode'] as String?
      ..initiatedByUserName = json['initiatedByUserName'] as String?
      ..totalQtyOrdered = (json['totalQtyOrdered'] as num?)?.toInt()
      ..lineCount = (json['lineCount'] as num?)?.toInt()
      ..totalCountDisplay = (json['totalCountDisplay'] as num?)?.toInt()
      ..quoteRequiredCount = (json['quoteRequiredCount'] as num?)?.toInt()
      ..orderSubTotal = json['orderSubTotal'] as num?
      ..orderSubTotalDisplay = json['orderSubTotalDisplay'] as String?
      ..orderSubTotalWithOutProductDiscounts =
          json['orderSubTotalWithOutProductDiscounts'] as num?
      ..orderSubTotalWithOutProductDiscountsDisplay =
          json['orderSubTotalWithOutProductDiscountsDisplay'] as String?
      ..totalTax = json['totalTax'] as num?
      ..totalTaxDisplay = json['totalTaxDisplay'] as String?
      ..shippingAndHandling = json['shippingAndHandling'] as num?
      ..shippingAndHandlingDisplay =
          json['shippingAndHandlingDisplay'] as String?
      ..shippingChargesDisplay = json['shippingChargesDisplay'] as String?
      ..handlingChargesDisplay = json['handlingChargesDisplay'] as String?
      ..otherChargesDisplay = json['otherChargesDisplay'] as String?
      ..orderGrandTotal = json['orderGrandTotal'] as num?
      ..orderGrandTotalDisplay = json['orderGrandTotalDisplay'] as String?
      ..costCodeLabel = json['costCodeLabel'] as String?
      ..isAuthenticated = json['isAuthenticated'] as bool?
      ..isGuestOrder = json['isGuestOrder'] as bool?
      ..isSalesperson = json['isSalesperson'] as bool?
      ..isSubscribed = json['isSubscribed'] as bool?
      ..requiresPoNumber = json['requiresPoNumber'] as bool?
      ..displayContinueShoppingLink =
          json['displayContinueShoppingLink'] as bool?
      ..canModifyOrder = json['canModifyOrder'] as bool?
      ..canSaveOrder = json['canSaveOrder'] as bool?
      ..canBypassCheckoutAddress = json['canBypassCheckoutAddress'] as bool?
      ..canRequisition = json['canRequisition'] as bool?
      ..canRequestQuote = json['canRequestQuote'] as bool?
      ..canEditCostCode = json['canEditCostCode'] as bool?
      ..showTaxAndShipping = json['showTaxAndShipping'] as bool?
      ..showLineNotes = json['showLineNotes'] as bool?
      ..showCostCode = json['showCostCode'] as bool?
      ..showNewsletterSignup = json['showNewsletterSignup'] as bool?
      ..showPoNumber = json['showPoNumber'] as bool?
      ..showCreditCard = json['showCreditCard'] as bool?
      ..showPayPal = json['showPayPal'] as bool?
      ..isAwaitingApproval = json['isAwaitingApproval'] as bool?
      ..requiresApproval = json['requiresApproval'] as bool?
      ..approverReason = json['approverReason'] as String?
      ..hasApprover = json['hasApprover'] as bool?
      ..salespersonName = json['salespersonName'] as String?
      ..paymentOptions = json['paymentOptions'] == null
          ? null
          : PaymentOptionsDto.fromJson(
              json['paymentOptions'] as Map<String, dynamic>)
      ..costCodes = (json['costCodes'] as List<dynamic>?)
          ?.map((e) => CostCodeDto.fromJson(e as Map<String, dynamic>))
          .toList()
      ..carriers = (json['carriers'] as List<dynamic>?)
          ?.map((e) => CarrierDto.fromJson(e as Map<String, dynamic>))
          .toList()
      ..cartLines = (json['cartLines'] as List<dynamic>?)
          ?.map((e) => CartLine.fromJson(e as Map<String, dynamic>))
          .toList()
      ..customerOrderTaxes = (json['customerOrderTaxes'] as List<dynamic>?)
          ?.map((e) => CustomerOrderTaxDto.fromJson(e as Map<String, dynamic>))
          .toList()
      ..canCheckOut = json['canCheckOut'] as bool?
      ..hasInsufficientInventory = json['hasInsufficientInventory'] as bool?
      ..currencySymbol = json['currencySymbol'] as String?
      ..requestedDeliveryDate = json['requestedDeliveryDate'] as String?
      ..requestedDeliveryDateDisplay =
          json['requestedDeliveryDateDisplay'] == null
              ? null
              : DateTime.parse(json['requestedDeliveryDateDisplay'] as String)
      ..requestedPickUpDate = json['requestedPickUpDate'] as String?
      ..requestedPickUpDateDisplay = json['requestedPickUpDateDisplay'] == null
          ? null
          : DateTime.parse(json['requestedPickUpDateDisplay'] as String)
      ..cartNotPriced = json['cartNotPriced'] as bool?
      ..messages = (json['messages'] as List<dynamic>?)
          ?.map((e) => e as String?)
          .toList()
      ..creditCardBillingAddress = json['creditCardBillingAddress'] == null
          ? null
          : CreditCardBillingAddress.fromJson(
              json['creditCardBillingAddress'] as Map<String, dynamic>)
      ..alsoPurchasedProducts =
          (json['alsoPurchasedProducts'] as List<dynamic>?)
              ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
              .toList()
      ..taxFailureReason = json['taxFailureReason'] as String?
      ..failedToGetRealTimeInventory =
          json['failedToGetRealTimeInventory'] as bool?
      ..unassignCart = json['unassignCart'] as bool?
      ..customerVatNumber = json['customerVatNumber'] as String?
      ..vmiLocationId = json['vmiLocationId'] as String?
      ..defaultWarehouse = json['defaultWarehouse'] == null
          ? null
          : DefaultWarehouseDto.fromJson(
              json['defaultWarehouse'] as Map<String, dynamic>);

Map<String, dynamic> _$JobQuoteDtoToJson(JobQuoteDto instance) {
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
  writeNotNull('jobQuoteId', instance.jobQuoteId);
  writeNotNull('isEditable', instance.isEditable);
  writeNotNull('expirationDate', instance.expirationDate?.toIso8601String());
  writeNotNull('jobName', instance.jobName);
  writeNotNull('jobQuoteLineCollection',
      instance.jobQuoteLineCollection?.map((e) => e.toJson()).toList());
  writeNotNull('customerName', instance.customerName);
  writeNotNull('shipToFullAddress', instance.shipToFullAddress);
  writeNotNull('orderTotal', instance.orderTotal);
  writeNotNull('orderTotalDisplay', instance.orderTotalDisplay);
  return val;
}

JobQuoteLine _$JobQuoteLineFromJson(Map<String, dynamic> json) => JobQuoteLine(
      pricingRfq: json['pricingRfq'] == null
          ? null
          : PricingRfq.fromJson(json['pricingRfq'] as Map<String, dynamic>),
      maxQty: json['maxQty'] as num?,
      qtySold: json['qtySold'] as num?,
      qtyRequested: json['qtyRequested'] as num?,
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      )
      ..productId = json['productId'] as String?
      ..qtyOrdered = json['qtyOrdered'] as num?
      ..unitOfMeasure = json['unitOfMeasure'] as String?
      ..notes = json['notes'] as String?
      ..vmiBinId = json['vmiBinId'] as String?
      ..allowZeroPricing = json['allowZeroPricing'] as bool?
      ..sectionOptions = (json['sectionOptions'] as List<dynamic>?)
          ?.map((e) => SectionOptionDto.fromJson(e as Map<String, dynamic>))
          .toList()
      ..productUri = json['productUri'] as String?
      ..id = json['id'] as String?
      ..line = (json['line'] as num?)?.toInt()
      ..requisitionId = json['requisitionId'] as String?
      ..smallImagePath = json['smallImagePath'] as String?
      ..altText = json['altText'] as String?
      ..productName = json['productName'] as String?
      ..manufacturerItem = json['manufacturerItem'] as String?
      ..customerName = json['customerName'] as String?
      ..shortDescription = json['shortDescription'] as String?
      ..erpNumber = json['erpNumber'] as String?
      ..unitOfMeasureDisplay = json['unitOfMeasureDisplay'] as String?
      ..unitOfMeasureDescription = json['unitOfMeasureDescription'] as String?
      ..baseUnitOfMeasure = json['baseUnitOfMeasure'] as String?
      ..baseUnitOfMeasureDisplay = json['baseUnitOfMeasureDisplay'] as String?
      ..qtyPerBaseUnitOfMeasure = json['qtyPerBaseUnitOfMeasure'] as num?
      ..costCode = json['costCode'] as String?
      ..qtyLeft = json['qtyLeft'] as num?
      ..pricing = json['pricing'] == null
          ? null
          : ProductPrice.fromJson(json['pricing'] as Map<String, dynamic>)
      ..isPromotionItem = json['isPromotionItem'] as bool?
      ..isDiscounted = json['isDiscounted'] as bool?
      ..isFixedConfiguration = json['isFixedConfiguration'] as bool?
      ..quoteRequired = json['quoteRequired'] as bool?
      ..breakPrices = (json['breakPrices'] as List<dynamic>?)
          ?.map((e) => BreakPriceDto.fromJson(e as Map<String, dynamic>))
          .toList()
      ..availability = json['availability'] == null
          ? null
          : Availability.fromJson(json['availability'] as Map<String, dynamic>)
      ..qtyOnHand = json['qtyOnHand'] as num?
      ..canAddToCart = json['canAddToCart'] as bool?
      ..isQtyAdjusted = json['isQtyAdjusted'] as bool?
      ..hasInsufficientInventory = json['hasInsufficientInventory'] as bool?
      ..canBackOrder = json['canBackOrder'] as bool?
      ..salePriceLabel = json['salePriceLabel'] as String?
      ..isSubscription = json['isSubscription'] as bool?
      ..productSubscription = json['productSubscription'] == null
          ? null
          : ProductSubscriptionDto.fromJson(
              json['productSubscription'] as Map<String, dynamic>)
      ..isRestricted = json['isRestricted'] as bool?
      ..isActive = json['isActive'] as bool?
      ..brand = json['brand'] == null
          ? null
          : Brand.fromJson(json['brand'] as Map<String, dynamic>);

Map<String, dynamic> _$JobQuoteLineToJson(JobQuoteLine instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uri', instance.uri);
  writeNotNull('properties', instance.properties);
  writeNotNull('productId', instance.productId);
  writeNotNull('qtyOrdered', instance.qtyOrdered);
  writeNotNull('unitOfMeasure', instance.unitOfMeasure);
  writeNotNull('notes', instance.notes);
  writeNotNull('vmiBinId', instance.vmiBinId);
  writeNotNull('allowZeroPricing', instance.allowZeroPricing);
  writeNotNull('sectionOptions',
      instance.sectionOptions?.map((e) => e.toJson()).toList());
  writeNotNull('productUri', instance.productUri);
  writeNotNull('id', instance.id);
  writeNotNull('line', instance.line);
  writeNotNull('requisitionId', instance.requisitionId);
  writeNotNull('smallImagePath', instance.smallImagePath);
  writeNotNull('altText', instance.altText);
  writeNotNull('productName', instance.productName);
  writeNotNull('manufacturerItem', instance.manufacturerItem);
  writeNotNull('customerName', instance.customerName);
  writeNotNull('shortDescription', instance.shortDescription);
  writeNotNull('erpNumber', instance.erpNumber);
  writeNotNull('unitOfMeasureDisplay', instance.unitOfMeasureDisplay);
  writeNotNull('unitOfMeasureDescription', instance.unitOfMeasureDescription);
  writeNotNull('baseUnitOfMeasure', instance.baseUnitOfMeasure);
  writeNotNull('baseUnitOfMeasureDisplay', instance.baseUnitOfMeasureDisplay);
  writeNotNull('qtyPerBaseUnitOfMeasure', instance.qtyPerBaseUnitOfMeasure);
  writeNotNull('costCode', instance.costCode);
  writeNotNull('qtyLeft', instance.qtyLeft);
  writeNotNull('pricing', instance.pricing?.toJson());
  writeNotNull('isPromotionItem', instance.isPromotionItem);
  writeNotNull('isDiscounted', instance.isDiscounted);
  writeNotNull('isFixedConfiguration', instance.isFixedConfiguration);
  writeNotNull('quoteRequired', instance.quoteRequired);
  writeNotNull(
      'breakPrices', instance.breakPrices?.map((e) => e.toJson()).toList());
  writeNotNull('availability', instance.availability?.toJson());
  writeNotNull('qtyOnHand', instance.qtyOnHand);
  writeNotNull('canAddToCart', instance.canAddToCart);
  writeNotNull('isQtyAdjusted', instance.isQtyAdjusted);
  writeNotNull('hasInsufficientInventory', instance.hasInsufficientInventory);
  writeNotNull('canBackOrder', instance.canBackOrder);
  writeNotNull('salePriceLabel', instance.salePriceLabel);
  writeNotNull('isSubscription', instance.isSubscription);
  writeNotNull('productSubscription', instance.productSubscription?.toJson());
  writeNotNull('isRestricted', instance.isRestricted);
  writeNotNull('isActive', instance.isActive);
  writeNotNull('brand', instance.brand?.toJson());
  writeNotNull('pricingRfq', instance.pricingRfq?.toJson());
  writeNotNull('maxQty', instance.maxQty);
  writeNotNull('qtySold', instance.qtySold);
  writeNotNull('qtyRequested', instance.qtyRequested);
  return val;
}
