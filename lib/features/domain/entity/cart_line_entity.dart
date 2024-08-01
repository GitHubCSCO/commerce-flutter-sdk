import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:commerce_flutter_app/features/domain/entity/availability_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/brand.dart';
import 'package:commerce_flutter_app/features/domain/entity/break_price_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_price_entity.dart';
import 'package:equatable/equatable.dart';

class AddCartLineEntity extends Equatable {
  final String? productId;
  final num? qtyOrdered;
  final String? unitOfMeasure;
  final String? notes;
  final String? vmiBinId;
  final List<SectionOptionEntity>? sectionOptions;

  const AddCartLineEntity({
    this.notes,
    this.productId,
    this.qtyOrdered,
    this.sectionOptions,
    this.unitOfMeasure,
    this.vmiBinId,
  });

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  AddCartLineEntity copyWith({
    String? productId,
    num? qtyOrdered,
    String? unitOfMeasure,
    String? notes,
    String? vmiBinId,
    List<SectionOptionEntity>? sectionOptions,
  }) {
    return AddCartLineEntity(
      productId: productId ?? this.productId,
      qtyOrdered: qtyOrdered ?? this.qtyOrdered,
      unitOfMeasure: unitOfMeasure ?? this.unitOfMeasure,
      notes: notes ?? this.notes,
      vmiBinId: vmiBinId ?? this.vmiBinId,
      sectionOptions: sectionOptions ?? this.sectionOptions,
    );
  }
}

class CartLineListEntity extends Equatable {
  final List<CartLineEntity>? cartLines;

  const CartLineListEntity({this.cartLines});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  CartLineListEntity copyWith({
    List<CartLineEntity>? cartLines,
  }) {
    return CartLineListEntity(
      cartLines: cartLines ?? this.cartLines,
    );
  }
}

class CartLineEntity extends AddCartLineEntity {
  final String? productUri;
  final String? id;
  final int? line;
  final String? requisitionId;
  final String? smallImagePath;
  final String? altText;
  final String? productName;
  final String? manufacturerItem;
  final String? customerName;
  final String? shortDescription;
  final String? erpNumber;
  final String? unitOfMeasureDisplay;
  final String? unitOfMeasureDescription;
  final String? baseUnitOfMeasure;
  final String? baseUnitOfMeasureDisplay;
  final num? qtyPerBaseUnitOfMeasure;
  final String? costCode;
  final num? qtyLeft;
  final ProductPriceEntity? pricing;
  final bool? isPromotionItem;
  final bool? isDiscounted;
  final bool? isFixedConfiguration;
  final bool? quoteRequired;
  final List<BreakPriceDTOEntity>? breakPrices;
  final AvailabilityEntity? availability;
  final num? qtyOnHand;
  final bool? canAddToCart;
  final bool? isQtyAdjusted;
  final bool? hasInsufficientInventory;
  final bool? canBackOrder;
  final String? salePriceLabel;
  final bool? isSubscription;
  final ProductSubscriptionEntity? productSubscription;
  final bool? isRestricted;
  final bool? isActive;
  final BrandEntity? brand;
  final bool? showInventoryAvailability;

  bool get hasLinenotes => !notes!.isNullorWhitespace;

  final String? status;

  const CartLineEntity(
      {final String? productId,
      final num? qtyOrdered,
      final String? unitOfMeasure,
      final String? notes,
      final String? vmiBinId,
      final List<SectionOptionEntity>? sectionOptions,
      this.altText,
      this.availability,
      this.baseUnitOfMeasure,
      this.baseUnitOfMeasureDisplay,
      this.brand,
      this.breakPrices,
      this.canAddToCart,
      this.canBackOrder,
      this.costCode,
      this.customerName,
      this.erpNumber,
      this.hasInsufficientInventory,
      this.id,
      this.isActive,
      this.isDiscounted,
      this.isFixedConfiguration,
      this.isPromotionItem,
      this.isQtyAdjusted,
      this.isRestricted,
      this.isSubscription,
      this.line,
      this.manufacturerItem,
      this.pricing,
      this.productName,
      this.productSubscription,
      this.productUri,
      this.qtyLeft,
      this.qtyOnHand,
      this.qtyPerBaseUnitOfMeasure,
      this.quoteRequired,
      this.requisitionId,
      this.salePriceLabel,
      this.shortDescription,
      this.smallImagePath,
      this.status,
      this.unitOfMeasureDescription,
      this.unitOfMeasureDisplay,
      this.showInventoryAvailability})
      : super(
            notes: notes,
            productId: productId,
            qtyOrdered: qtyOrdered,
            sectionOptions: sectionOptions,
            unitOfMeasure: unitOfMeasure,
            vmiBinId: vmiBinId);

  @override
  CartLineEntity copyWith(
      {String? productId,
      num? qtyOrdered,
      String? unitOfMeasure,
      String? notes,
      String? vmiBinId,
      List<SectionOptionEntity>? sectionOptions,
      String? productUri,
      String? id,
      int? line,
      String? requisitionId,
      String? smallImagePath,
      String? altText,
      String? productName,
      String? manufacturerItem,
      String? customerName,
      String? shortDescription,
      String? erpNumber,
      String? unitOfMeasureDisplay,
      String? unitOfMeasureDescription,
      String? baseUnitOfMeasure,
      String? baseUnitOfMeasureDisplay,
      num? qtyPerBaseUnitOfMeasure,
      String? costCode,
      num? qtyLeft,
      ProductPriceEntity? pricing,
      bool? isPromotionItem,
      bool? isDiscounted,
      bool? isFixedConfiguration,
      bool? quoteRequired,
      List<BreakPriceDTOEntity>? breakPrices,
      AvailabilityEntity? availability,
      num? qtyOnHand,
      bool? canAddToCart,
      bool? isQtyAdjusted,
      bool? hasInsufficientInventory,
      bool? canBackOrder,
      String? salePriceLabel,
      bool? isSubscription,
      ProductSubscriptionEntity? productSubscription,
      bool? isRestricted,
      bool? isActive,
      BrandEntity? brand,
      String? status,
      bool? showInventoryAvailability}) {
    return CartLineEntity(
      showInventoryAvailability:
          showInventoryAvailability ?? this.showInventoryAvailability,
      productId: productId ?? this.productId,
      qtyOrdered: qtyOrdered ?? this.qtyOrdered,
      unitOfMeasure: unitOfMeasure ?? this.unitOfMeasure,
      notes: notes ?? this.notes,
      vmiBinId: vmiBinId ?? this.vmiBinId,
      sectionOptions: sectionOptions ?? this.sectionOptions,
      productUri: productUri ?? this.productUri,
      id: id ?? this.id,
      line: line ?? this.line,
      requisitionId: requisitionId ?? this.requisitionId,
      smallImagePath: smallImagePath ?? this.smallImagePath,
      altText: altText ?? this.altText,
      productName: productName ?? this.productName,
      manufacturerItem: manufacturerItem ?? this.manufacturerItem,
      customerName: customerName ?? this.customerName,
      shortDescription: shortDescription ?? this.shortDescription,
      erpNumber: erpNumber ?? this.erpNumber,
      unitOfMeasureDisplay: unitOfMeasureDisplay ?? this.unitOfMeasureDisplay,
      unitOfMeasureDescription:
          unitOfMeasureDescription ?? this.unitOfMeasureDescription,
      baseUnitOfMeasure: baseUnitOfMeasure ?? this.baseUnitOfMeasure,
      baseUnitOfMeasureDisplay:
          baseUnitOfMeasureDisplay ?? this.baseUnitOfMeasureDisplay,
      qtyPerBaseUnitOfMeasure:
          qtyPerBaseUnitOfMeasure ?? this.qtyPerBaseUnitOfMeasure,
      costCode: costCode ?? this.costCode,
      qtyLeft: qtyLeft ?? this.qtyLeft,
      pricing: pricing ?? this.pricing,
      isPromotionItem: isPromotionItem ?? this.isPromotionItem,
      isDiscounted: isDiscounted ?? this.isDiscounted,
      isFixedConfiguration: isFixedConfiguration ?? this.isFixedConfiguration,
      quoteRequired: quoteRequired ?? this.quoteRequired,
      breakPrices: breakPrices ?? this.breakPrices,
      availability: availability ?? this.availability,
      qtyOnHand: qtyOnHand ?? this.qtyOnHand,
      canAddToCart: canAddToCart ?? this.canAddToCart,
      isQtyAdjusted: isQtyAdjusted ?? this.isQtyAdjusted,
      hasInsufficientInventory:
          hasInsufficientInventory ?? this.hasInsufficientInventory,
      canBackOrder: canBackOrder ?? this.canBackOrder,
      salePriceLabel: salePriceLabel ?? this.salePriceLabel,
      isSubscription: isSubscription ?? this.isSubscription,
      productSubscription: productSubscription ?? this.productSubscription,
      isRestricted: isRestricted ?? this.isRestricted,
      isActive: isActive ?? this.isActive,
      brand: brand ?? this.brand,
      status: status ?? this.status,
    );
  }
}

class SectionOptionEntity {
  final String? sectionOptionId;
  final String? sectionName;
  final String? optionName;

  SectionOptionEntity({
    this.optionName,
    this.sectionName,
    this.sectionOptionId,
  });
}

class ProductSubscriptionEntity {
  final bool? subscriptionAddToInitialOrder;
  final bool? subscriptionAllMonths;
  final bool? subscriptionApril;
  final bool? subscriptionAugust;
  final String? subscriptionCyclePeriod;
  final bool? subscriptionDecember;
  final bool? subscriptionFebruary;
  final bool? subscriptionFixedPrice;
  final bool? subscriptionJanuary;
  final bool? subscriptionJuly;
  final bool? subscriptionJune;
  final bool? subscriptionMarch;
  final bool? subscriptionMay;
  final bool? subscriptionNovember;
  final bool? subscriptionOctober;
  final int? subscriptionPeriodsPerCycle;
  final bool? subscriptionSeptember;
  final String? subscriptionShipViaId;
  final int? subscriptionTotalCycles;

  ProductSubscriptionEntity({
    this.subscriptionAddToInitialOrder,
    this.subscriptionAllMonths,
    this.subscriptionApril,
    this.subscriptionAugust,
    this.subscriptionCyclePeriod,
    this.subscriptionDecember,
    this.subscriptionFebruary,
    this.subscriptionFixedPrice,
    this.subscriptionJanuary,
    this.subscriptionJuly,
    this.subscriptionJune,
    this.subscriptionMarch,
    this.subscriptionMay,
    this.subscriptionNovember,
    this.subscriptionOctober,
    this.subscriptionPeriodsPerCycle,
    this.subscriptionSeptember,
    this.subscriptionShipViaId,
    this.subscriptionTotalCycles,
  });
}
