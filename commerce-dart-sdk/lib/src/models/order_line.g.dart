// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_line.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderLine _$OrderLineFromJson(Map<String, dynamic> json) => OrderLine(
      id: json['id'] as String?,
      productId: json['productId'] as String?,
      productUri: json['productUri'] as String?,
      mediumImagePath: json['mediumImagePath'] as String?,
      altText: json['altText'] as String?,
      productName: json['productName'] as String?,
      manufacturerItem: json['manufacturerItem'] as String?,
      customerName: json['customerName'] as String?,
      shortDescription: json['shortDescription'] as String?,
      productErpNumber: json['productErpNumber'] as String?,
      customerProductNumber: json['customerProductNumber'] as String?,
      requiredDate: json['requiredDate'] == null
          ? null
          : DateTime.parse(json['requiredDate'] as String),
      lastShipDate: json['lastShipDate'] == null
          ? null
          : DateTime.parse(json['lastShipDate'] as String),
      customerNumber: json['customerNumber'] as String?,
      customerSequence: json['customerSequence'] as String?,
      lineType: json['lineType'] as String?,
      status: json['status'] as String?,
      lineNumber: json['lineNumber'] as num?,
      releaseNumber: json['releaseNumber'] as num?,
      linePOReference: json['linePOReference'] as String?,
      description: json['description'] as String?,
      warehouse: json['warehouse'] as String?,
      notes: json['notes'] as String?,
      qtyOrdered: json['qtyOrdered'] as num?,
      qtyShipped: json['qtyShipped'] as num?,
      unitOfMeasure: json['unitOfMeasure'] as String?,
      unitOfMeasureDisplay: json['unitOfMeasureDisplay'] as String?,
      unitOfMeasureDescription: json['unitOfMeasureDescription'] as String?,
      availability: json['availability'] == null
          ? null
          : Availability.fromJson(json['availability'] as Map<String, dynamic>),
      inventoryQtyOrdered: json['inventoryQtyOrdered'] as num?,
      inventoryQtyShipped: json['inventoryQtyShipped'] as num?,
      unitPrice: json['unitPrice'] as num?,
      unitNetPrice: json['unitNetPrice'] as num?,
      extendedUnitNetPrice: json['extendedUnitNetPrice'] as num?,
      discountPercent: json['discountPercent'] as num?,
      discountAmount: json['discountAmount'] as num?,
      unitDiscountAmount: json['unitDiscountAmount'] as num?,
      promotionAmountApplied: json['promotionAmountApplied'] as num?,
      totalDiscountAmount: json['totalDiscountAmount'] as num?,
      lineTotal: json['lineTotal'] as num?,
      totalRegularPrice: json['totalRegularPrice'] as num?,
      unitListPrice: json['unitListPrice'] as num?,
      unitRegularPrice: json['unitRegularPrice'] as num?,
      unitCost: json['unitCost'] as num?,
      orderLineOtherCharges: json['orderLineOtherCharges'] as num?,
      taxRate: json['taxRate'] as num?,
      taxAmount: json['taxAmount'] as num?,
      returnReason: json['returnReason'] as String?,
      rmaQtyRequested: json['rmaQtyRequested'] as num?,
      rmaQtyReceived: json['rmaQtyReceived'] as num?,
      unitPriceDisplay: json['unitPriceDisplay'] as String?,
      unitNetPriceDisplay: json['unitNetPriceDisplay'] as String?,
      extendedUnitNetPriceDisplay:
          json['extendedUnitNetPriceDisplay'] as String?,
      discountAmountDisplay: json['discountAmountDisplay'] as String?,
      unitDiscountAmountDisplay: json['unitDiscountAmountDisplay'] as String?,
      totalDiscountAmountDisplay: json['totalDiscountAmountDisplay'] as String?,
      lineTotalDisplay: json['lineTotalDisplay'] as String?,
      totalRegularPriceDisplay: json['totalRegularPriceDisplay'] as String?,
      unitListPriceDisplay: json['unitListPriceDisplay'] as String?,
      unitRegularPriceDisplay: json['unitRegularPriceDisplay'] as String?,
      unitCostDisplay: json['unitCostDisplay'] as String?,
      orderLineOtherChargesDisplay:
          json['orderLineOtherChargesDisplay'] as String?,
      costCode: json['costCode'] as String?,
      canAddToCart: json['canAddToCart'] as bool?,
      isActiveProduct: json['isActiveProduct'] as bool?,
      sectionOptions: (json['sectionOptions'] as List<dynamic>?)
          ?.map((e) => SectionOptionDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      salePriceLabel: json['salePriceLabel'] as String?,
      canAddToWishlist: json['canAddToWishlist'] as bool?,
      brand: json['brand'] == null
          ? null
          : Brand.fromJson(json['brand'] as Map<String, dynamic>),
      netPriceWithVat: json['netPriceWithVat'] as num?,
      netPriceWithVatDisplay: json['netPriceWithVatDisplay'] as String?,
      unitPriceWithVat: json['unitPriceWithVat'] as num?,
      unitPriceWithVatDisplay: json['unitPriceWithVatDisplay'] as String?,
      vmiBinNumber: json['vmiBinNumber'] as String?,
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$OrderLineToJson(OrderLine instance) => <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.id case final value?) 'id': value,
      if (instance.productId case final value?) 'productId': value,
      if (instance.productUri case final value?) 'productUri': value,
      if (instance.mediumImagePath case final value?) 'mediumImagePath': value,
      if (instance.altText case final value?) 'altText': value,
      if (instance.productName case final value?) 'productName': value,
      if (instance.manufacturerItem case final value?)
        'manufacturerItem': value,
      if (instance.customerName case final value?) 'customerName': value,
      if (instance.shortDescription case final value?)
        'shortDescription': value,
      if (instance.productErpNumber case final value?)
        'productErpNumber': value,
      if (instance.customerProductNumber case final value?)
        'customerProductNumber': value,
      if (instance.requiredDate?.toIso8601String() case final value?)
        'requiredDate': value,
      if (instance.lastShipDate?.toIso8601String() case final value?)
        'lastShipDate': value,
      if (instance.customerNumber case final value?) 'customerNumber': value,
      if (instance.customerSequence case final value?)
        'customerSequence': value,
      if (instance.lineType case final value?) 'lineType': value,
      if (instance.status case final value?) 'status': value,
      if (instance.lineNumber case final value?) 'lineNumber': value,
      if (instance.releaseNumber case final value?) 'releaseNumber': value,
      if (instance.linePOReference case final value?) 'linePOReference': value,
      if (instance.description case final value?) 'description': value,
      if (instance.warehouse case final value?) 'warehouse': value,
      if (instance.notes case final value?) 'notes': value,
      if (instance.qtyOrdered case final value?) 'qtyOrdered': value,
      if (instance.qtyShipped case final value?) 'qtyShipped': value,
      if (instance.unitOfMeasure case final value?) 'unitOfMeasure': value,
      if (instance.unitOfMeasureDisplay case final value?)
        'unitOfMeasureDisplay': value,
      if (instance.unitOfMeasureDescription case final value?)
        'unitOfMeasureDescription': value,
      if (instance.availability?.toJson() case final value?)
        'availability': value,
      if (instance.inventoryQtyOrdered case final value?)
        'inventoryQtyOrdered': value,
      if (instance.inventoryQtyShipped case final value?)
        'inventoryQtyShipped': value,
      if (instance.unitPrice case final value?) 'unitPrice': value,
      if (instance.unitNetPrice case final value?) 'unitNetPrice': value,
      if (instance.extendedUnitNetPrice case final value?)
        'extendedUnitNetPrice': value,
      if (instance.discountPercent case final value?) 'discountPercent': value,
      if (instance.discountAmount case final value?) 'discountAmount': value,
      if (instance.unitDiscountAmount case final value?)
        'unitDiscountAmount': value,
      if (instance.promotionAmountApplied case final value?)
        'promotionAmountApplied': value,
      if (instance.totalDiscountAmount case final value?)
        'totalDiscountAmount': value,
      if (instance.lineTotal case final value?) 'lineTotal': value,
      if (instance.totalRegularPrice case final value?)
        'totalRegularPrice': value,
      if (instance.unitListPrice case final value?) 'unitListPrice': value,
      if (instance.unitRegularPrice case final value?)
        'unitRegularPrice': value,
      if (instance.unitCost case final value?) 'unitCost': value,
      if (instance.orderLineOtherCharges case final value?)
        'orderLineOtherCharges': value,
      if (instance.taxRate case final value?) 'taxRate': value,
      if (instance.taxAmount case final value?) 'taxAmount': value,
      if (instance.returnReason case final value?) 'returnReason': value,
      if (instance.rmaQtyRequested case final value?) 'rmaQtyRequested': value,
      if (instance.rmaQtyReceived case final value?) 'rmaQtyReceived': value,
      if (instance.unitPriceDisplay case final value?)
        'unitPriceDisplay': value,
      if (instance.unitNetPriceDisplay case final value?)
        'unitNetPriceDisplay': value,
      if (instance.extendedUnitNetPriceDisplay case final value?)
        'extendedUnitNetPriceDisplay': value,
      if (instance.discountAmountDisplay case final value?)
        'discountAmountDisplay': value,
      if (instance.unitDiscountAmountDisplay case final value?)
        'unitDiscountAmountDisplay': value,
      if (instance.totalDiscountAmountDisplay case final value?)
        'totalDiscountAmountDisplay': value,
      if (instance.lineTotalDisplay case final value?)
        'lineTotalDisplay': value,
      if (instance.totalRegularPriceDisplay case final value?)
        'totalRegularPriceDisplay': value,
      if (instance.unitListPriceDisplay case final value?)
        'unitListPriceDisplay': value,
      if (instance.unitRegularPriceDisplay case final value?)
        'unitRegularPriceDisplay': value,
      if (instance.unitCostDisplay case final value?) 'unitCostDisplay': value,
      if (instance.orderLineOtherChargesDisplay case final value?)
        'orderLineOtherChargesDisplay': value,
      if (instance.costCode case final value?) 'costCode': value,
      if (instance.canAddToCart case final value?) 'canAddToCart': value,
      if (instance.isActiveProduct case final value?) 'isActiveProduct': value,
      if (instance.sectionOptions?.map((e) => e.toJson()).toList()
          case final value?)
        'sectionOptions': value,
      if (instance.salePriceLabel case final value?) 'salePriceLabel': value,
      if (instance.canAddToWishlist case final value?)
        'canAddToWishlist': value,
      if (instance.brand?.toJson() case final value?) 'brand': value,
      if (instance.netPriceWithVat case final value?) 'netPriceWithVat': value,
      if (instance.netPriceWithVatDisplay case final value?)
        'netPriceWithVatDisplay': value,
      if (instance.unitPriceWithVat case final value?)
        'unitPriceWithVat': value,
      if (instance.unitPriceWithVatDisplay case final value?)
        'unitPriceWithVatDisplay': value,
      if (instance.vmiBinNumber case final value?) 'vmiBinNumber': value,
    };
