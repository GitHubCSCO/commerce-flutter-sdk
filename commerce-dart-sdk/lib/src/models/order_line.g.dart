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

Map<String, dynamic> _$OrderLineToJson(OrderLine instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uri', instance.uri);
  writeNotNull('properties', instance.properties);
  writeNotNull('id', instance.id);
  writeNotNull('productId', instance.productId);
  writeNotNull('productUri', instance.productUri);
  writeNotNull('mediumImagePath', instance.mediumImagePath);
  writeNotNull('altText', instance.altText);
  writeNotNull('productName', instance.productName);
  writeNotNull('manufacturerItem', instance.manufacturerItem);
  writeNotNull('customerName', instance.customerName);
  writeNotNull('shortDescription', instance.shortDescription);
  writeNotNull('productErpNumber', instance.productErpNumber);
  writeNotNull('customerProductNumber', instance.customerProductNumber);
  writeNotNull('requiredDate', instance.requiredDate?.toIso8601String());
  writeNotNull('lastShipDate', instance.lastShipDate?.toIso8601String());
  writeNotNull('customerNumber', instance.customerNumber);
  writeNotNull('customerSequence', instance.customerSequence);
  writeNotNull('lineType', instance.lineType);
  writeNotNull('status', instance.status);
  writeNotNull('lineNumber', instance.lineNumber);
  writeNotNull('releaseNumber', instance.releaseNumber);
  writeNotNull('linePOReference', instance.linePOReference);
  writeNotNull('description', instance.description);
  writeNotNull('warehouse', instance.warehouse);
  writeNotNull('notes', instance.notes);
  writeNotNull('qtyOrdered', instance.qtyOrdered);
  writeNotNull('qtyShipped', instance.qtyShipped);
  writeNotNull('unitOfMeasure', instance.unitOfMeasure);
  writeNotNull('unitOfMeasureDisplay', instance.unitOfMeasureDisplay);
  writeNotNull('unitOfMeasureDescription', instance.unitOfMeasureDescription);
  writeNotNull('availability', instance.availability?.toJson());
  writeNotNull('inventoryQtyOrdered', instance.inventoryQtyOrdered);
  writeNotNull('inventoryQtyShipped', instance.inventoryQtyShipped);
  writeNotNull('unitPrice', instance.unitPrice);
  writeNotNull('unitNetPrice', instance.unitNetPrice);
  writeNotNull('extendedUnitNetPrice', instance.extendedUnitNetPrice);
  writeNotNull('discountPercent', instance.discountPercent);
  writeNotNull('discountAmount', instance.discountAmount);
  writeNotNull('unitDiscountAmount', instance.unitDiscountAmount);
  writeNotNull('promotionAmountApplied', instance.promotionAmountApplied);
  writeNotNull('totalDiscountAmount', instance.totalDiscountAmount);
  writeNotNull('lineTotal', instance.lineTotal);
  writeNotNull('totalRegularPrice', instance.totalRegularPrice);
  writeNotNull('unitListPrice', instance.unitListPrice);
  writeNotNull('unitRegularPrice', instance.unitRegularPrice);
  writeNotNull('unitCost', instance.unitCost);
  writeNotNull('orderLineOtherCharges', instance.orderLineOtherCharges);
  writeNotNull('taxRate', instance.taxRate);
  writeNotNull('taxAmount', instance.taxAmount);
  writeNotNull('returnReason', instance.returnReason);
  writeNotNull('rmaQtyRequested', instance.rmaQtyRequested);
  writeNotNull('rmaQtyReceived', instance.rmaQtyReceived);
  writeNotNull('unitPriceDisplay', instance.unitPriceDisplay);
  writeNotNull('unitNetPriceDisplay', instance.unitNetPriceDisplay);
  writeNotNull(
      'extendedUnitNetPriceDisplay', instance.extendedUnitNetPriceDisplay);
  writeNotNull('discountAmountDisplay', instance.discountAmountDisplay);
  writeNotNull('unitDiscountAmountDisplay', instance.unitDiscountAmountDisplay);
  writeNotNull(
      'totalDiscountAmountDisplay', instance.totalDiscountAmountDisplay);
  writeNotNull('lineTotalDisplay', instance.lineTotalDisplay);
  writeNotNull('totalRegularPriceDisplay', instance.totalRegularPriceDisplay);
  writeNotNull('unitListPriceDisplay', instance.unitListPriceDisplay);
  writeNotNull('unitRegularPriceDisplay', instance.unitRegularPriceDisplay);
  writeNotNull('unitCostDisplay', instance.unitCostDisplay);
  writeNotNull(
      'orderLineOtherChargesDisplay', instance.orderLineOtherChargesDisplay);
  writeNotNull('costCode', instance.costCode);
  writeNotNull('canAddToCart', instance.canAddToCart);
  writeNotNull('isActiveProduct', instance.isActiveProduct);
  writeNotNull('sectionOptions',
      instance.sectionOptions?.map((e) => e.toJson()).toList());
  writeNotNull('salePriceLabel', instance.salePriceLabel);
  writeNotNull('canAddToWishlist', instance.canAddToWishlist);
  writeNotNull('brand', instance.brand?.toJson());
  writeNotNull('netPriceWithVat', instance.netPriceWithVat);
  writeNotNull('netPriceWithVatDisplay', instance.netPriceWithVatDisplay);
  writeNotNull('unitPriceWithVat', instance.unitPriceWithVat);
  writeNotNull('unitPriceWithVatDisplay', instance.unitPriceWithVatDisplay);
  writeNotNull('vmiBinNumber', instance.vmiBinNumber);
  return val;
}
