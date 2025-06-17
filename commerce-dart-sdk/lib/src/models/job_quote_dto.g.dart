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

Map<String, dynamic> _$JobQuoteDtoToJson(JobQuoteDto instance) =>
    <String, dynamic>{
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
      if (instance.jobQuoteId case final value?) 'jobQuoteId': value,
      if (instance.isEditable case final value?) 'isEditable': value,
      if (instance.expirationDate?.toIso8601String() case final value?)
        'expirationDate': value,
      if (instance.jobName case final value?) 'jobName': value,
      if (instance.jobQuoteLineCollection?.map((e) => e.toJson()).toList()
          case final value?)
        'jobQuoteLineCollection': value,
      if (instance.customerName case final value?) 'customerName': value,
      if (instance.shipToFullAddress case final value?)
        'shipToFullAddress': value,
      if (instance.orderTotal case final value?) 'orderTotal': value,
      if (instance.orderTotalDisplay case final value?)
        'orderTotalDisplay': value,
    };

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

Map<String, dynamic> _$JobQuoteLineToJson(JobQuoteLine instance) =>
    <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.productId case final value?) 'productId': value,
      if (instance.qtyOrdered case final value?) 'qtyOrdered': value,
      if (instance.unitOfMeasure case final value?) 'unitOfMeasure': value,
      if (instance.notes case final value?) 'notes': value,
      if (instance.vmiBinId case final value?) 'vmiBinId': value,
      if (instance.allowZeroPricing case final value?)
        'allowZeroPricing': value,
      if (instance.sectionOptions?.map((e) => e.toJson()).toList()
          case final value?)
        'sectionOptions': value,
      if (instance.productUri case final value?) 'productUri': value,
      if (instance.id case final value?) 'id': value,
      if (instance.line case final value?) 'line': value,
      if (instance.requisitionId case final value?) 'requisitionId': value,
      if (instance.smallImagePath case final value?) 'smallImagePath': value,
      if (instance.altText case final value?) 'altText': value,
      if (instance.productName case final value?) 'productName': value,
      if (instance.manufacturerItem case final value?)
        'manufacturerItem': value,
      if (instance.customerName case final value?) 'customerName': value,
      if (instance.shortDescription case final value?)
        'shortDescription': value,
      if (instance.erpNumber case final value?) 'erpNumber': value,
      if (instance.unitOfMeasureDisplay case final value?)
        'unitOfMeasureDisplay': value,
      if (instance.unitOfMeasureDescription case final value?)
        'unitOfMeasureDescription': value,
      if (instance.baseUnitOfMeasure case final value?)
        'baseUnitOfMeasure': value,
      if (instance.baseUnitOfMeasureDisplay case final value?)
        'baseUnitOfMeasureDisplay': value,
      if (instance.qtyPerBaseUnitOfMeasure case final value?)
        'qtyPerBaseUnitOfMeasure': value,
      if (instance.costCode case final value?) 'costCode': value,
      if (instance.qtyLeft case final value?) 'qtyLeft': value,
      if (instance.pricing?.toJson() case final value?) 'pricing': value,
      if (instance.isPromotionItem case final value?) 'isPromotionItem': value,
      if (instance.isDiscounted case final value?) 'isDiscounted': value,
      if (instance.isFixedConfiguration case final value?)
        'isFixedConfiguration': value,
      if (instance.quoteRequired case final value?) 'quoteRequired': value,
      if (instance.breakPrices?.map((e) => e.toJson()).toList()
          case final value?)
        'breakPrices': value,
      if (instance.availability?.toJson() case final value?)
        'availability': value,
      if (instance.qtyOnHand case final value?) 'qtyOnHand': value,
      if (instance.canAddToCart case final value?) 'canAddToCart': value,
      if (instance.isQtyAdjusted case final value?) 'isQtyAdjusted': value,
      if (instance.hasInsufficientInventory case final value?)
        'hasInsufficientInventory': value,
      if (instance.canBackOrder case final value?) 'canBackOrder': value,
      if (instance.salePriceLabel case final value?) 'salePriceLabel': value,
      if (instance.isSubscription case final value?) 'isSubscription': value,
      if (instance.productSubscription?.toJson() case final value?)
        'productSubscription': value,
      if (instance.isRestricted case final value?) 'isRestricted': value,
      if (instance.isActive case final value?) 'isActive': value,
      if (instance.brand?.toJson() case final value?) 'brand': value,
      if (instance.pricingRfq?.toJson() case final value?) 'pricingRfq': value,
      if (instance.maxQty case final value?) 'maxQty': value,
      if (instance.qtySold case final value?) 'qtySold': value,
      if (instance.qtyRequested case final value?) 'qtyRequested': value,
    };
