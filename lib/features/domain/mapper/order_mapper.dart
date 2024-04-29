import 'package:commerce_flutter_app/features/domain/entity/availability_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/brand.dart';
import 'package:commerce_flutter_app/features/domain/entity/order/get_order_collection_result_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/order/order_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/order/order_history_tax_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/order/order_line_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/order/order_promotion_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/order/shipment_package_dto_entity.dart';
import 'package:commerce_flutter_app/features/domain/mapper/availability_mapper.dart';
import 'package:commerce_flutter_app/features/domain/mapper/brand_mapper.dart';
import 'package:commerce_flutter_app/features/domain/mapper/cart_line_mapper.dart';
import 'package:commerce_flutter_app/features/domain/mapper/pagination_entity_mapper.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class OrderEntityMapper {
  static OrderEntity toEntity(Order order) => OrderEntity(
        id: order.id,
        erpOrderNumber: order.erpOrderNumber,
        webOrderNumber: order.webOrderNumber,
        orderDate: order.orderDate,
        status: order.status,
        statusDisplay: order.statusDisplay,
        customerNumber: order.customerNumber,
        customerSequence: order.customerSequence,
        customerPO: order.customerPO,
        currencyCode: order.currencyCode,
        currencySymbol: order.currencySymbol,
        terms: order.terms,
        shipCode: order.shipCode,
        salesperson: order.salesperson,
        btCompanyName: order.btCompanyName,
        btAddress1: order.btAddress1,
        btAddress2: order.btAddress2,
        billToCity: order.billToCity,
        billToState: order.billToState,
        billToPostalCode: order.billToPostalCode,
        btCountry: order.btCountry,
        stCompanyName: order.stCompanyName,
        stAddress1: order.stAddress1,
        stAddress2: order.stAddress2,
        stAddress3: order.stAddress3,
        stAddress4: order.stAddress4,
        shipToCity: order.shipToCity,
        shipToState: order.shipToState,
        shipToPostalCode: order.shipToPostalCode,
        stCountry: order.stCountry,
        notes: order.notes,
        productTotal: order.productTotal,
        orderSubTotal: order.orderSubTotal,
        orderDiscountAmount: order.orderDiscountAmount,
        productDiscountAmount: order.productDiscountAmount,
        shippingAndHandling: order.shippingAndHandling,
        shippingCharges: order.shippingCharges,
        handlingCharges: order.handlingCharges,
        otherCharges: order.otherCharges,
        taxAmount: order.taxAmount,
        orderTotal: order.orderTotal,
        modifyDate: order.modifyDate,
        requestedDeliveryDateDisplay: order.requestedDeliveryDateDisplay,
        orderLines: order.orderLines
            ?.map((e) => OrderLineEntityMapper.toEntity(e))
            .toList(),
        orderPromotions: order.orderPromotions
            ?.map((e) => OrderPromotionEntityMapper.toEntity(e))
            .toList(),
        shipmentPackages: order.shipmentPackages
            ?.map((e) => ShipmentPackageDtoEntityMapper.toEntity(e))
            .toList(),
        returnReasons: order.returnReasons,
        orderHistoryTaxes: order.orderHistoryTaxes
            ?.map((e) => OrderHistoryTaxDtoEntityMapper.toEntity(e))
            .toList(),
        productTotalDisplay: order.productTotalDisplay,
        orderSubTotalDisplay: order.orderSubTotalDisplay,
        orderGrandTotalDisplay: order.orderGrandTotalDisplay,
        orderDiscountAmountDisplay: order.orderDiscountAmountDisplay,
        productDiscountAmountDisplay: order.productDiscountAmountDisplay,
        taxAmountDisplay: order.taxAmountDisplay,
        totalTaxDisplay: order.totalTaxDisplay,
        shippingAndHandlingDisplay: order.shippingAndHandlingDisplay,
        shippingChargesDisplay: order.shippingChargesDisplay,
        handlingChargesDisplay: order.handlingChargesDisplay,
        otherChargesDisplay: order.otherChargesDisplay,
        canAddToCart: order.canAddToCart,
        canAddAllToCart: order.canAddAllToCart,
        showTaxAndShipping: order.showTaxAndShipping,
        shipViaDescription: order.shipViaDescription,
        fulfillmentMethod: order.fulfillmentMethod,
        vmiLocationId: order.vmiLocationId,
        vmiLocationName: order.vmiLocationName,
        showWebOrderNumber: order.showWebOrderNumber,
        showPoNumber: order.showPoNumber,
        showTermsCode: order.showTermsCode,
        orderNumberLabel: order.orderNumberLabel,
        webOrderNumberLabel: order.webOrderNumberLabel,
        poNumberLabel: order.poNumberLabel,
      );

  static Order toModel(OrderEntity entity) => Order(
        id: entity.id,
        erpOrderNumber: entity.erpOrderNumber,
        webOrderNumber: entity.webOrderNumber,
        orderDate: entity.orderDate,
        status: entity.status,
        statusDisplay: entity.statusDisplay,
        customerNumber: entity.customerNumber,
        customerSequence: entity.customerSequence,
        customerPO: entity.customerPO,
        currencyCode: entity.currencyCode,
        currencySymbol: entity.currencySymbol,
        terms: entity.terms,
        shipCode: entity.shipCode,
        salesperson: entity.salesperson,
        btCompanyName: entity.btCompanyName,
        btAddress1: entity.btAddress1,
        btAddress2: entity.btAddress2,
        billToCity: entity.billToCity,
        billToState: entity.billToState,
        billToPostalCode: entity.billToPostalCode,
        btCountry: entity.btCountry,
        stCompanyName: entity.stCompanyName,
        stAddress1: entity.stAddress1,
        stAddress2: entity.stAddress2,
        stAddress3: entity.stAddress3,
        stAddress4: entity.stAddress4,
        shipToCity: entity.shipToCity,
        shipToState: entity.shipToState,
        shipToPostalCode: entity.shipToPostalCode,
        stCountry: entity.stCountry,
        notes: entity.notes,
        productTotal: entity.productTotal,
        orderSubTotal: entity.orderSubTotal,
        orderDiscountAmount: entity.orderDiscountAmount,
        productDiscountAmount: entity.productDiscountAmount,
        shippingAndHandling: entity.shippingAndHandling,
        shippingCharges: entity.shippingCharges,
        handlingCharges: entity.handlingCharges,
        otherCharges: entity.otherCharges,
        taxAmount: entity.taxAmount,
        orderTotal: entity.orderTotal,
        modifyDate: entity.modifyDate,
        requestedDeliveryDateDisplay: entity.requestedDeliveryDateDisplay,
        orderLines: entity.orderLines
            ?.map((e) => OrderLineEntityMapper.toModel(e))
            .toList(),
        orderPromotions: entity.orderPromotions
            ?.map((e) => OrderPromotionEntityMapper.toModel(e))
            .toList(),
        shipmentPackages: entity.shipmentPackages
            ?.map((e) => ShipmentPackageDtoEntityMapper.toModel(e))
            .toList(),
        returnReasons: entity.returnReasons,
        orderHistoryTaxes: entity.orderHistoryTaxes
            ?.map((e) => OrderHistoryTaxDtoEntityMapper.toModel(e))
            .toList(),
        productTotalDisplay: entity.productTotalDisplay,
        orderSubTotalDisplay: entity.orderSubTotalDisplay,
        orderGrandTotalDisplay: entity.orderGrandTotalDisplay,
        orderDiscountAmountDisplay: entity.orderDiscountAmountDisplay,
        productDiscountAmountDisplay: entity.productDiscountAmountDisplay,
        taxAmountDisplay: entity.taxAmountDisplay,
        totalTaxDisplay: entity.totalTaxDisplay,
        shippingAndHandlingDisplay: entity.shippingAndHandlingDisplay,
        shippingChargesDisplay: entity.shippingChargesDisplay,
        handlingChargesDisplay: entity.handlingChargesDisplay,
        otherChargesDisplay: entity.otherChargesDisplay,
        canAddToCart: entity.canAddToCart,
        canAddAllToCart: entity.canAddAllToCart,
        showTaxAndShipping: entity.showTaxAndShipping,
        shipViaDescription: entity.shipViaDescription,
        fulfillmentMethod: entity.fulfillmentMethod,
        vmiLocationId: entity.vmiLocationId,
        vmiLocationName: entity.vmiLocationName,
        showWebOrderNumber: entity.showWebOrderNumber,
        showPoNumber: entity.showPoNumber,
        showTermsCode: entity.showTermsCode,
        orderNumberLabel: entity.orderNumberLabel,
        webOrderNumberLabel: entity.webOrderNumberLabel,
        poNumberLabel: entity.poNumberLabel,
      );
}

class OrderLineEntityMapper {
  static OrderLineEntity toEntity(OrderLine orderLine) => OrderLineEntity(
        altText: orderLine.altText,
        availability: orderLine.availability != null
            ? AvailabilityEntityMapper().toEntity(orderLine.availability)
            : null,
        brand: orderLine.brand != null
            ? BrandEntityMapper().toEntity(orderLine.brand)
            : null,
        canAddToCart: orderLine.canAddToCart,
        canAddToWishlist: orderLine.canAddToWishlist,
        costCode: orderLine.costCode,
        customerName: orderLine.customerName,
        customerNumber: orderLine.customerNumber,
        customerSequence: orderLine.customerSequence,
        customerProductNumber: orderLine.customerProductNumber,
        description: orderLine.description,
        discountAmount: orderLine.discountAmount,
        discountAmountDisplay: orderLine.discountAmountDisplay,
        discountPercent: orderLine.discountPercent,
        extendedUnitNetPrice: orderLine.extendedUnitNetPrice,
        extendedUnitNetPriceDisplay: orderLine.extendedUnitNetPriceDisplay,
        id: orderLine.id,
        inventoryQtyOrdered: orderLine.inventoryQtyOrdered,
        inventoryQtyShipped: orderLine.inventoryQtyShipped,
        isActiveProduct: orderLine.isActiveProduct,
        lastShipDate: orderLine.lastShipDate,
        lineNumber: orderLine.lineNumber,
        linePOReference: orderLine.linePOReference,
        lineTotal: orderLine.lineTotal,
        lineTotalDisplay: orderLine.lineTotalDisplay,
        lineType: orderLine.lineType,
        manufacturerItem: orderLine.manufacturerItem,
        mediumImagePath: orderLine.mediumImagePath,
        netPriceWithVat: orderLine.netPriceWithVat,
        netPriceWithVatDisplay: orderLine.netPriceWithVatDisplay,
        notes: orderLine.notes,
        orderLineOtherCharges: orderLine.orderLineOtherCharges,
        orderLineOtherChargesDisplay: orderLine.orderLineOtherChargesDisplay,
        productErpNumber: orderLine.productErpNumber,
        productId: orderLine.productId,
        productName: orderLine.productName,
        productUri: orderLine.productUri,
        promotionAmountApplied: orderLine.promotionAmountApplied,
        qtyOrdered: orderLine.qtyOrdered,
        qtyShipped: orderLine.qtyShipped,
        releaseNumber: orderLine.releaseNumber,
        requiredDate: orderLine.requiredDate,
        returnReason: orderLine.returnReason,
        rmaQtyReceived: orderLine.rmaQtyReceived,
        rmaQtyRequested: orderLine.rmaQtyRequested,
        salePriceLabel: orderLine.salePriceLabel,
        sectionOptions: orderLine.sectionOptions
            ?.map((e) => SectionOptionEntityMapper().toEntity(e))
            .toList(),
        shortDescription: orderLine.shortDescription,
        status: orderLine.status,
        taxAmount: orderLine.taxAmount,
        taxRate: orderLine.taxRate,
        totalDiscountAmount: orderLine.totalDiscountAmount,
        totalDiscountAmountDisplay: orderLine.totalDiscountAmountDisplay,
        totalRegularPrice: orderLine.totalRegularPrice,
        totalRegularPriceDisplay: orderLine.totalRegularPriceDisplay,
        unitNetPrice: orderLine.unitNetPrice,
        unitNetPriceDisplay: orderLine.unitNetPriceDisplay,
        unitPrice: orderLine.unitPrice,
        unitPriceDisplay: orderLine.unitPriceDisplay,
        unitRegularPrice: orderLine.unitRegularPrice,
        unitRegularPriceDisplay: orderLine.unitRegularPriceDisplay,
        unitCost: orderLine.unitCost,
        unitCostDisplay: orderLine.unitCostDisplay,
        unitListPrice: orderLine.unitListPrice,
        unitListPriceDisplay: orderLine.unitListPriceDisplay,
        unitDiscountAmount: orderLine.unitDiscountAmount,
        unitDiscountAmountDisplay: orderLine.unitDiscountAmountDisplay,
        unitOfMeasure: orderLine.unitOfMeasure,
        unitOfMeasureDescription: orderLine.unitOfMeasureDescription,
        unitOfMeasureDisplay: orderLine.unitOfMeasureDisplay,
        unitPriceWithVat: orderLine.unitPriceWithVat,
        unitPriceWithVatDisplay: orderLine.unitPriceWithVatDisplay,
        vmiBinNumber: orderLine.vmiBinNumber,
        warehouse: orderLine.warehouse,
      );

  static OrderLine toModel(OrderLineEntity entity) => OrderLine(
        altText: entity.altText,
        availability: entity.availability != null
            ? AvailabilityEntityMapper()
                .toModel(entity.availability ?? const AvailabilityEntity())
            : null,
        brand: entity.brand != null
            ? BrandEntityMapper().toModel(entity.brand ?? const BrandEntity())
            : null,
        canAddToCart: entity.canAddToCart,
        canAddToWishlist: entity.canAddToWishlist,
        costCode: entity.costCode,
        customerName: entity.customerName,
        customerNumber: entity.customerNumber,
        customerSequence: entity.customerSequence,
        customerProductNumber: entity.customerProductNumber,
        description: entity.description,
        discountAmount: entity.discountAmount,
        discountAmountDisplay: entity.discountAmountDisplay,
        discountPercent: entity.discountPercent,
        extendedUnitNetPrice: entity.extendedUnitNetPrice,
        extendedUnitNetPriceDisplay: entity.extendedUnitNetPriceDisplay,
        id: entity.id,
        inventoryQtyOrdered: entity.inventoryQtyOrdered,
        inventoryQtyShipped: entity.inventoryQtyShipped,
        isActiveProduct: entity.isActiveProduct,
        lastShipDate: entity.lastShipDate,
        lineNumber: entity.lineNumber,
        linePOReference: entity.linePOReference,
        lineTotal: entity.lineTotal,
        lineTotalDisplay: entity.lineTotalDisplay,
        lineType: entity.lineType,
        manufacturerItem: entity.manufacturerItem,
        mediumImagePath: entity.mediumImagePath,
        netPriceWithVat: entity.netPriceWithVat,
        netPriceWithVatDisplay: entity.netPriceWithVatDisplay,
        notes: entity.notes,
        orderLineOtherCharges: entity.orderLineOtherCharges,
        orderLineOtherChargesDisplay: entity.orderLineOtherChargesDisplay,
        productErpNumber: entity.productErpNumber,
        productId: entity.productId,
        productName: entity.productName,
        productUri: entity.productUri,
        promotionAmountApplied: entity.promotionAmountApplied,
        qtyOrdered: entity.qtyOrdered,
        qtyShipped: entity.qtyShipped,
        releaseNumber: entity.releaseNumber,
        requiredDate: entity.requiredDate,
        returnReason: entity.returnReason,
        rmaQtyReceived: entity.rmaQtyReceived,
        rmaQtyRequested: entity.rmaQtyRequested,
        salePriceLabel: entity.salePriceLabel,
        sectionOptions: entity.sectionOptions
            ?.map((e) => SectionOptionEntityMapper().toModel(e))
            .toList(),
        shortDescription: entity.shortDescription,
        status: entity.status,
        taxAmount: entity.taxAmount,
        taxRate: entity.taxRate,
        totalDiscountAmount: entity.totalDiscountAmount,
        totalDiscountAmountDisplay: entity.totalDiscountAmountDisplay,
        totalRegularPrice: entity.totalRegularPrice,
        totalRegularPriceDisplay: entity.totalRegularPriceDisplay,
        unitNetPrice: entity.unitNetPrice,
        unitNetPriceDisplay: entity.unitNetPriceDisplay,
        unitPrice: entity.unitPrice,
        unitPriceDisplay: entity.unitPriceDisplay,
        unitRegularPrice: entity.unitRegularPrice,
        unitRegularPriceDisplay: entity.unitRegularPriceDisplay,
        unitCost: entity.unitCost,
        unitCostDisplay: entity.unitCostDisplay,
        unitListPrice: entity.unitListPrice,
        unitListPriceDisplay: entity.unitListPriceDisplay,
        unitDiscountAmount: entity.unitDiscountAmount,
        unitDiscountAmountDisplay: entity.unitDiscountAmountDisplay,
        unitOfMeasure: entity.unitOfMeasure,
        unitOfMeasureDescription: entity.unitOfMeasureDescription,
        unitOfMeasureDisplay: entity.unitOfMeasureDisplay,
        unitPriceWithVat: entity.unitPriceWithVat,
        unitPriceWithVatDisplay: entity.unitPriceWithVatDisplay,
        vmiBinNumber: entity.vmiBinNumber,
        warehouse: entity.warehouse,
      );
}

class OrderPromotionEntityMapper {
  static OrderPromotionEntity toEntity(OrderPromotion orderPromotion) =>
      OrderPromotionEntity(
        id: orderPromotion.id,
        amount: orderPromotion.amount,
        amountDisplay: orderPromotion.amountDisplay,
        name: orderPromotion.name,
        orderHistoryLineId: orderPromotion.orderHistoryLineId,
        promotionResultType: orderPromotion.promotionResultType,
      );

  static OrderPromotion toModel(OrderPromotionEntity entity) => OrderPromotion(
        id: entity.id,
        amount: entity.amount,
        amountDisplay: entity.amountDisplay,
        name: entity.name,
        orderHistoryLineId: entity.orderHistoryLineId,
        promotionResultType: entity.promotionResultType,
      );
}

class ShipmentPackageDtoEntityMapper {
  static ShipmentPackageDtoEntity toEntity(
          ShipmentPackageDto shipmentPackageDto) =>
      ShipmentPackageDtoEntity(
        carrier: shipmentPackageDto.carrier,
        id: shipmentPackageDto.id,
        packSlip: shipmentPackageDto.packSlip,
        shipDateTitle: shipmentPackageDto.shipDateTitle,
        shipVia: shipmentPackageDto.shipVia,
        shipmentDate: shipmentPackageDto.shipmentDate,
        trackButtonTitle: shipmentPackageDto.trackButtonTitle,
        trackingNumber: shipmentPackageDto.trackingNumber,
        trackingUrl: shipmentPackageDto.trackingUrl,
      );

  static ShipmentPackageDto toModel(ShipmentPackageDtoEntity entity) =>
      ShipmentPackageDto(
        carrier: entity.carrier,
        id: entity.id,
        packSlip: entity.packSlip,
        shipDateTitle: entity.shipDateTitle,
        shipVia: entity.shipVia,
        shipmentDate: entity.shipmentDate,
        trackButtonTitle: entity.trackButtonTitle,
        trackingNumber: entity.trackingNumber,
        trackingUrl: entity.trackingUrl,
      );
}

class OrderHistoryTaxDtoEntityMapper {
  static OrderHistoryTaxDtoEntity toEntity(
          OrderHistoryTaxDto orderHistoryTaxDto) =>
      OrderHistoryTaxDtoEntity(
        taxAmount: orderHistoryTaxDto.taxAmount,
        taxAmountDisplay: orderHistoryTaxDto.taxAmountDisplay,
        taxCode: orderHistoryTaxDto.taxCode,
        taxRate: orderHistoryTaxDto.taxRate,
        sortOrder: orderHistoryTaxDto.sortOrder,
        taxDescription: orderHistoryTaxDto.taxDescription,
      );

  static OrderHistoryTaxDto toModel(OrderHistoryTaxDtoEntity entity) =>
      OrderHistoryTaxDto(
        taxAmount: entity.taxAmount,
        taxAmountDisplay: entity.taxAmountDisplay,
        taxCode: entity.taxCode,
        taxRate: entity.taxRate,
        sortOrder: entity.sortOrder,
        taxDescription: entity.taxDescription,
      );
}

class GetOrderCollectionResultEntityMapper {
  static GetOrderCollectionResultEntity toEntity(
          GetOrderCollectionResult model) =>
      GetOrderCollectionResultEntity(
        orders:
            model.orders?.map((e) => OrderEntityMapper.toEntity(e)).toList(),
        pagination: model.pagination != null
            ? PaginationEntityMapper.toEntity(model.pagination!)
            : null,
        showErpOrderNumber: model.showErpOrderNumber,
      );

  static GetOrderCollectionResult toModel(
          GetOrderCollectionResultEntity entity) =>
      GetOrderCollectionResult(
        orders:
            entity.orders?.map((e) => OrderEntityMapper.toModel(e)).toList(),
        pagination: entity.pagination != null
            ? PaginationEntityMapper.toModel(entity.pagination!)
            : null,
        showErpOrderNumber: entity.showErpOrderNumber,
      );
}
