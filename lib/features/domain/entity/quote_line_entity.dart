// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:commerce_flutter_app/features/domain/entity/availability_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/brand.dart';
import 'package:commerce_flutter_app/features/domain/entity/break_price_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/cart_line_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/pricing_rfq_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_price_entity.dart';

class QuoteLinePricingEntity {
  final String? qty;
  final String? price;
  QuoteLinePricingEntity({
    this.qty,
    this.price,
  });
}

class QuoteLineEntity extends CartLineEntity {
  final PricingRfqEntity? pricingRfq;
  final num? maxQty;
  final bool? isJobQuote;
  final String? quoteStatus;
  final String? quoteId;
  final bool? hidePricingEnable;
  final bool? hideInventoryEnable;
  final List<QuoteLinePricingEntity>? quoteLinePricingBreakList;

  const QuoteLineEntity(
      {super.productId,
      super.qtyOrdered,
      super.unitOfMeasure,
      super.notes,
      super.vmiBinId,
      super.sectionOptions,
      super.productUri,
      super.id,
      super.line,
      super.requisitionId,
      super.smallImagePath,
      super.altText,
      super.productName,
      super.manufacturerItem,
      super.customerName,
      super.shortDescription,
      super.erpNumber,
      super.unitOfMeasureDisplay,
      super.unitOfMeasureDescription,
      super.baseUnitOfMeasure,
      super.baseUnitOfMeasureDisplay,
      super.qtyPerBaseUnitOfMeasure,
      super.costCode,
      super.qtyLeft,
      super.pricing,
      super.isPromotionItem,
      super.isDiscounted,
      super.isFixedConfiguration,
      super.quoteRequired,
      super.breakPrices,
      super.availability,
      super.qtyOnHand,
      super.canAddToCart,
      super.isQtyAdjusted,
      super.hasInsufficientInventory,
      super.canBackOrder,
      super.salePriceLabel,
      super.isSubscription,
      super.productSubscription,
      super.isRestricted,
      super.isActive,
      super.brand,
      super.showInventoryAvailability,
      super.status,
      this.isJobQuote,
      this.quoteStatus,
      this.quoteId,
      this.pricingRfq,
      this.maxQty,
      this.hideInventoryEnable,
      this.hidePricingEnable,
      this.quoteLinePricingBreakList})
      : super();
  @override
  List<Object?> get props => [pricingRfq, maxQty];

  @override
  QuoteLineEntity copyWith(
      {String? altText,
      AvailabilityEntity? availability,
      String? baseUnitOfMeasure,
      String? baseUnitOfMeasureDisplay,
      BrandEntity? brand,
      List<BreakPriceDTOEntity>? breakPrices,
      bool? canAddToCart,
      bool? canBackOrder,
      String? costCode,
      String? customerName,
      String? erpNumber,
      bool? hasInsufficientInventory,
      String? id,
      bool? isActive,
      bool? isDiscounted,
      bool? isFixedConfiguration,
      bool? isPromotionItem,
      bool? isQtyAdjusted,
      bool? isRestricted,
      bool? isSubscription,
      int? line,
      String? manufacturerItem,
      String? notes,
      ProductPriceEntity? pricing,
      String? productId,
      String? productName,
      ProductSubscriptionEntity? productSubscription,
      String? productUri,
      num? qtyLeft,
      num? qtyOnHand,
      num? qtyOrdered,
      num? qtyPerBaseUnitOfMeasure,
      bool? quoteRequired,
      String? requisitionId,
      String? salePriceLabel,
      List<SectionOptionEntity>? sectionOptions,
      String? shortDescription,
      bool? showInventoryAvailability,
      String? smallImagePath,
      String? status,
      String? unitOfMeasure,
      String? unitOfMeasureDescription,
      String? unitOfMeasureDisplay,
      String? vmiBinId,
      PricingRfqEntity? pricingRfq,
      num? maxQty,
      bool? isJobQuote,
      String? quoteStatus,
      String? quoteId,
      List<QuoteLinePricingEntity>? quoteLinePricingBreakList,
      bool? hidePricingEnable,
      bool? hideInventoryEnable}) {
    return QuoteLineEntity(
        quoteLinePricingBreakList:
            quoteLinePricingBreakList ?? this.quoteLinePricingBreakList,
        isJobQuote: isJobQuote ?? this.isJobQuote,
        quoteStatus: quoteStatus ?? this.quoteStatus,
        quoteId: quoteId ?? this.quoteId,
        pricingRfq: pricingRfq ?? this.pricingRfq,
        maxQty: maxQty ?? this.maxQty,
        altText: altText ?? this.altText,
        availability: availability ?? this.availability,
        baseUnitOfMeasure: baseUnitOfMeasure ?? this.baseUnitOfMeasure,
        baseUnitOfMeasureDisplay:
            baseUnitOfMeasureDisplay ?? this.baseUnitOfMeasureDisplay,
        brand: brand ?? this.brand,
        breakPrices: breakPrices ?? this.breakPrices,
        canAddToCart: canAddToCart ?? this.canAddToCart,
        canBackOrder: canBackOrder ?? this.canBackOrder,
        costCode: costCode ?? this.costCode,
        customerName: customerName ?? this.customerName,
        erpNumber: erpNumber ?? this.erpNumber,
        hasInsufficientInventory:
            hasInsufficientInventory ?? this.hasInsufficientInventory,
        id: id ?? this.id,
        isActive: isActive ?? this.isActive,
        isDiscounted: isDiscounted ?? this.isDiscounted,
        isFixedConfiguration: isFixedConfiguration ?? this.isFixedConfiguration,
        isPromotionItem: isPromotionItem ?? this.isPromotionItem,
        isQtyAdjusted: isQtyAdjusted ?? this.isQtyAdjusted,
        isRestricted: isRestricted ?? this.isRestricted,
        isSubscription: isSubscription ?? this.isSubscription,
        line: line ?? this.line,
        manufacturerItem: manufacturerItem ?? this.manufacturerItem,
        notes: notes ?? this.notes,
        pricing: pricing ?? this.pricing,
        productId: productId ?? this.productId,
        productName: productName ?? this.productName,
        productSubscription: productSubscription ?? this.productSubscription,
        productUri: productUri ?? this.productUri,
        qtyLeft: qtyLeft ?? this.qtyLeft,
        qtyOnHand: qtyOnHand ?? this.qtyOnHand,
        qtyOrdered: qtyOrdered ?? this.qtyOrdered,
        qtyPerBaseUnitOfMeasure:
            qtyPerBaseUnitOfMeasure ?? this.qtyPerBaseUnitOfMeasure,
        quoteRequired: quoteRequired ?? this.quoteRequired,
        requisitionId: requisitionId ?? this.requisitionId,
        salePriceLabel: salePriceLabel ?? this.salePriceLabel,
        sectionOptions: sectionOptions ?? this.sectionOptions,
        shortDescription: shortDescription ?? this.shortDescription,
        showInventoryAvailability:
            showInventoryAvailability ?? this.showInventoryAvailability,
        smallImagePath: smallImagePath ?? this.smallImagePath,
        status: status ?? this.status,
        unitOfMeasure: unitOfMeasure ?? this.unitOfMeasure,
        unitOfMeasureDescription:
            unitOfMeasureDescription ?? this.unitOfMeasureDescription,
        unitOfMeasureDisplay: unitOfMeasureDisplay ?? this.unitOfMeasureDisplay,
        vmiBinId: vmiBinId ?? this.vmiBinId,
        hidePricingEnable: hidePricingEnable ?? this.hidePricingEnable,
        hideInventoryEnable: hideInventoryEnable ?? this.hideInventoryEnable);
  }
}
