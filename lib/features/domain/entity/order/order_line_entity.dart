import 'package:equatable/equatable.dart';

import 'package:commerce_flutter_sdk/features/domain/entity/availability_entity.dart';
import 'package:commerce_flutter_sdk/features/domain/entity/brand.dart';
import 'package:commerce_flutter_sdk/features/domain/entity/cart_line_entity.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class OrderLineEntity extends Equatable {
  final String? id;
  final String? productId;
  final String? productUri;
  final String? mediumImagePath;
  final String? altText;
  final String? productName;
  final String? manufacturerItem;
  final String? customerName;
  final String? shortDescription;
  final String? productErpNumber;
  final String? customerProductNumber;
  final DateTime? requiredDate;
  final DateTime? lastShipDate;
  final String? customerNumber;
  final String? customerSequence;
  final String? lineType;
  final String? status;
  final num? lineNumber;
  final num? releaseNumber;
  final String? linePOReference;
  final String? description;
  final String? warehouse;
  final String? notes;
  final num? qtyOrdered;
  final num? qtyShipped;
  final String? unitOfMeasure;
  final String? unitOfMeasureDisplay;
  final String? unitOfMeasureDescription;
  final AvailabilityEntity? availability;
  final num? inventoryQtyOrdered;
  final num? inventoryQtyShipped;
  final num? unitPrice;
  final num? unitNetPrice;
  final num? extendedUnitNetPrice;
  final num? discountPercent;
  final num? discountAmount;
  final num? unitDiscountAmount;
  final num? promotionAmountApplied;
  final num? totalDiscountAmount;
  final num? lineTotal;
  final num? totalRegularPrice;
  final num? unitListPrice;
  final num? unitRegularPrice;
  final num? unitCost;
  final num? orderLineOtherCharges;
  final num? taxRate;
  final num? taxAmount;
  final String? returnReason;
  final num? rmaQtyRequested;
  final num? rmaQtyReceived;
  final String? unitPriceDisplay;
  final String? unitNetPriceDisplay;
  final String? extendedUnitNetPriceDisplay;
  final String? discountAmountDisplay;
  final String? unitDiscountAmountDisplay;
  final String? totalDiscountAmountDisplay;
  final String? lineTotalDisplay;
  final String? totalRegularPriceDisplay;
  final String? unitListPriceDisplay;
  final String? unitRegularPriceDisplay;
  final String? unitCostDisplay;
  final String? orderLineOtherChargesDisplay;
  final String? costCode;
  final bool? canAddToCart;
  final bool? isActiveProduct;
  final List<SectionOptionEntity>? sectionOptions;
  final String? salePriceLabel;
  final bool? canAddToWishlist;
  final BrandEntity? brand;
  final num? netPriceWithVat;
  final String? netPriceWithVatDisplay;
  final num? unitPriceWithVat;
  final String? unitPriceWithVatDisplay;
  final String? vmiBinNumber;
  final Properties? properties;

  const OrderLineEntity({
    this.id,
    this.productId,
    this.productUri,
    this.mediumImagePath,
    this.altText,
    this.productName,
    this.manufacturerItem,
    this.customerName,
    this.shortDescription,
    this.productErpNumber,
    this.customerProductNumber,
    this.requiredDate,
    this.lastShipDate,
    this.customerNumber,
    this.customerSequence,
    this.lineType,
    this.status,
    this.lineNumber,
    this.releaseNumber,
    this.linePOReference,
    this.description,
    this.warehouse,
    this.notes,
    this.qtyOrdered,
    this.qtyShipped,
    this.unitOfMeasure,
    this.unitOfMeasureDisplay,
    this.unitOfMeasureDescription,
    this.availability,
    this.inventoryQtyOrdered,
    this.inventoryQtyShipped,
    this.unitPrice,
    this.unitNetPrice,
    this.extendedUnitNetPrice,
    this.discountPercent,
    this.discountAmount,
    this.unitDiscountAmount,
    this.promotionAmountApplied,
    this.totalDiscountAmount,
    this.lineTotal,
    this.totalRegularPrice,
    this.unitListPrice,
    this.unitRegularPrice,
    this.unitCost,
    this.orderLineOtherCharges,
    this.taxRate,
    this.taxAmount,
    this.returnReason,
    this.rmaQtyRequested,
    this.rmaQtyReceived,
    this.unitPriceDisplay,
    this.unitNetPriceDisplay,
    this.extendedUnitNetPriceDisplay,
    this.discountAmountDisplay,
    this.unitDiscountAmountDisplay,
    this.totalDiscountAmountDisplay,
    this.lineTotalDisplay,
    this.totalRegularPriceDisplay,
    this.unitListPriceDisplay,
    this.unitRegularPriceDisplay,
    this.unitCostDisplay,
    this.orderLineOtherChargesDisplay,
    this.costCode,
    this.canAddToCart,
    this.isActiveProduct,
    this.sectionOptions,
    this.salePriceLabel,
    this.canAddToWishlist,
    this.brand,
    this.netPriceWithVat,
    this.netPriceWithVatDisplay,
    this.unitPriceWithVat,
    this.unitPriceWithVatDisplay,
    this.vmiBinNumber,
    this.properties,
  });

  @override
  List<Object?> get props => [
        id,
        productId,
        productUri,
        mediumImagePath,
        altText,
        productName,
        manufacturerItem,
        customerName,
        shortDescription,
        productErpNumber,
        customerProductNumber,
        requiredDate,
        lastShipDate,
        customerNumber,
        customerSequence,
        lineType,
        status,
        lineNumber,
        releaseNumber,
        linePOReference,
        description,
        warehouse,
        notes,
        qtyOrdered,
        qtyShipped,
        unitOfMeasure,
        unitOfMeasureDisplay,
        unitOfMeasureDescription,
        availability,
        inventoryQtyOrdered,
        inventoryQtyShipped,
        unitPrice,
        unitNetPrice,
        extendedUnitNetPrice,
        discountPercent,
        discountAmount,
        unitDiscountAmount,
        promotionAmountApplied,
        totalDiscountAmount,
        lineTotal,
        totalRegularPrice,
        unitListPrice,
        unitRegularPrice,
        unitCost,
        orderLineOtherCharges,
        taxRate,
        taxAmount,
        returnReason,
        rmaQtyRequested,
        rmaQtyReceived,
        unitPriceDisplay,
        unitNetPriceDisplay,
        extendedUnitNetPriceDisplay,
        discountAmountDisplay,
        unitDiscountAmountDisplay,
        totalDiscountAmountDisplay,
        lineTotalDisplay,
        totalRegularPriceDisplay,
        unitListPriceDisplay,
        unitRegularPriceDisplay,
        unitCostDisplay,
        orderLineOtherChargesDisplay,
        costCode,
        canAddToCart,
        isActiveProduct,
        sectionOptions,
        salePriceLabel,
        canAddToWishlist,
        brand,
        netPriceWithVat,
        netPriceWithVatDisplay,
        unitPriceWithVat,
        unitPriceWithVatDisplay,
        vmiBinNumber,
        properties,
      ];

  OrderLineEntity copyWith({
    String? id,
    String? productId,
    String? productUri,
    String? mediumImagePath,
    String? altText,
    String? productName,
    String? manufacturerItem,
    String? customerName,
    String? shortDescription,
    String? productErpNumber,
    String? customerProductNumber,
    DateTime? requiredDate,
    DateTime? lastShipDate,
    String? customerNumber,
    String? customerSequence,
    String? lineType,
    String? status,
    num? lineNumber,
    num? releaseNumber,
    String? linePOReference,
    String? description,
    String? warehouse,
    String? notes,
    num? qtyOrdered,
    num? qtyShipped,
    String? unitOfMeasure,
    String? unitOfMeasureDisplay,
    String? unitOfMeasureDescription,
    AvailabilityEntity? availability,
    num? inventoryQtyOrdered,
    num? inventoryQtyShipped,
    num? unitPrice,
    num? unitNetPrice,
    num? extendedUnitNetPrice,
    num? discountPercent,
    num? discountAmount,
    num? unitDiscountAmount,
    num? promotionAmountApplied,
    num? totalDiscountAmount,
    num? lineTotal,
    num? totalRegularPrice,
    num? unitListPrice,
    num? unitRegularPrice,
    num? unitCost,
    num? orderLineOtherCharges,
    num? taxRate,
    num? taxAmount,
    String? returnReason,
    num? rmaQtyRequested,
    num? rmaQtyReceived,
    String? unitPriceDisplay,
    String? unitNetPriceDisplay,
    String? extendedUnitNetPriceDisplay,
    String? discountAmountDisplay,
    String? unitDiscountAmountDisplay,
    String? totalDiscountAmountDisplay,
    String? lineTotalDisplay,
    String? totalRegularPriceDisplay,
    String? unitListPriceDisplay,
    String? unitRegularPriceDisplay,
    String? unitCostDisplay,
    String? orderLineOtherChargesDisplay,
    String? costCode,
    bool? canAddToCart,
    bool? isActiveProduct,
    List<SectionOptionEntity>? sectionOptions,
    String? salePriceLabel,
    bool? canAddToWishlist,
    BrandEntity? brand,
    num? netPriceWithVat,
    String? netPriceWithVatDisplay,
    num? unitPriceWithVat,
    String? unitPriceWithVatDisplay,
    String? vmiBinNumber,
    Properties? properties,
  }) {
    return OrderLineEntity(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      productUri: productUri ?? this.productUri,
      mediumImagePath: mediumImagePath ?? this.mediumImagePath,
      altText: altText ?? this.altText,
      productName: productName ?? this.productName,
      manufacturerItem: manufacturerItem ?? this.manufacturerItem,
      customerName: customerName ?? this.customerName,
      shortDescription: shortDescription ?? this.shortDescription,
      productErpNumber: productErpNumber ?? this.productErpNumber,
      customerProductNumber:
          customerProductNumber ?? this.customerProductNumber,
      requiredDate: requiredDate ?? this.requiredDate,
      lastShipDate: lastShipDate ?? this.lastShipDate,
      customerNumber: customerNumber ?? this.customerNumber,
      customerSequence: customerSequence ?? this.customerSequence,
      lineType: lineType ?? this.lineType,
      status: status ?? this.status,
      lineNumber: lineNumber ?? this.lineNumber,
      releaseNumber: releaseNumber ?? this.releaseNumber,
      linePOReference: linePOReference ?? this.linePOReference,
      description: description ?? this.description,
      warehouse: warehouse ?? this.warehouse,
      notes: notes ?? this.notes,
      qtyOrdered: qtyOrdered ?? this.qtyOrdered,
      qtyShipped: qtyShipped ?? this.qtyShipped,
      unitOfMeasure: unitOfMeasure ?? this.unitOfMeasure,
      unitOfMeasureDisplay: unitOfMeasureDisplay ?? this.unitOfMeasureDisplay,
      unitOfMeasureDescription:
          unitOfMeasureDescription ?? this.unitOfMeasureDescription,
      availability: availability ?? this.availability,
      inventoryQtyOrdered: inventoryQtyOrdered ?? this.inventoryQtyOrdered,
      inventoryQtyShipped: inventoryQtyShipped ?? this.inventoryQtyShipped,
      unitPrice: unitPrice ?? this.unitPrice,
      unitNetPrice: unitNetPrice ?? this.unitNetPrice,
      extendedUnitNetPrice: extendedUnitNetPrice ?? this.extendedUnitNetPrice,
      discountPercent: discountPercent ?? this.discountPercent,
      discountAmount: discountAmount ?? this.discountAmount,
      unitDiscountAmount: unitDiscountAmount ?? this.unitDiscountAmount,
      promotionAmountApplied:
          promotionAmountApplied ?? this.promotionAmountApplied,
      totalDiscountAmount: totalDiscountAmount ?? this.totalDiscountAmount,
      lineTotal: lineTotal ?? this.lineTotal,
      totalRegularPrice: totalRegularPrice ?? this.totalRegularPrice,
      unitListPrice: unitListPrice ?? this.unitListPrice,
      unitRegularPrice: unitRegularPrice ?? this.unitRegularPrice,
      unitCost: unitCost ?? this.unitCost,
      orderLineOtherCharges:
          orderLineOtherCharges ?? this.orderLineOtherCharges,
      taxRate: taxRate ?? this.taxRate,
      taxAmount: taxAmount ?? this.taxAmount,
      returnReason: returnReason ?? this.returnReason,
      rmaQtyRequested: rmaQtyRequested ?? this.rmaQtyRequested,
      rmaQtyReceived: rmaQtyReceived ?? this.rmaQtyReceived,
      unitPriceDisplay: unitPriceDisplay ?? this.unitPriceDisplay,
      unitNetPriceDisplay: unitNetPriceDisplay ?? this.unitNetPriceDisplay,
      extendedUnitNetPriceDisplay:
          extendedUnitNetPriceDisplay ?? this.extendedUnitNetPriceDisplay,
      discountAmountDisplay:
          discountAmountDisplay ?? this.discountAmountDisplay,
      unitDiscountAmountDisplay:
          unitDiscountAmountDisplay ?? this.unitDiscountAmountDisplay,
      totalDiscountAmountDisplay:
          totalDiscountAmountDisplay ?? this.totalDiscountAmountDisplay,
      lineTotalDisplay: lineTotalDisplay ?? this.lineTotalDisplay,
      totalRegularPriceDisplay:
          totalRegularPriceDisplay ?? this.totalRegularPriceDisplay,
      unitListPriceDisplay: unitListPriceDisplay ?? this.unitListPriceDisplay,
      unitRegularPriceDisplay:
          unitRegularPriceDisplay ?? this.unitRegularPriceDisplay,
      unitCostDisplay: unitCostDisplay ?? this.unitCostDisplay,
      orderLineOtherChargesDisplay:
          orderLineOtherChargesDisplay ?? this.orderLineOtherChargesDisplay,
      costCode: costCode ?? this.costCode,
      canAddToCart: canAddToCart ?? this.canAddToCart,
      isActiveProduct: isActiveProduct ?? this.isActiveProduct,
      sectionOptions: sectionOptions ?? this.sectionOptions,
      salePriceLabel: salePriceLabel ?? this.salePriceLabel,
      canAddToWishlist: canAddToWishlist ?? this.canAddToWishlist,
      brand: brand ?? this.brand,
      netPriceWithVat: netPriceWithVat ?? this.netPriceWithVat,
      netPriceWithVatDisplay:
          netPriceWithVatDisplay ?? this.netPriceWithVatDisplay,
      unitPriceWithVat: unitPriceWithVat ?? this.unitPriceWithVat,
      unitPriceWithVatDisplay:
          unitPriceWithVatDisplay ?? this.unitPriceWithVatDisplay,
      vmiBinNumber: vmiBinNumber ?? this.vmiBinNumber,
      properties: properties ?? this.properties,
    );
  }
}
