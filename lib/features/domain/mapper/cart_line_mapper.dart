import 'package:commerce_flutter_app/features/domain/entity/availability_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/brand.dart';
import 'package:commerce_flutter_app/features/domain/entity/cart_line_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_price_entity.dart';
import 'package:commerce_flutter_app/features/domain/mapper/availability_mapper.dart';
import 'package:commerce_flutter_app/features/domain/mapper/brand_mapper.dart';
import 'package:commerce_flutter_app/features/domain/mapper/break_price_mapper.dart';
import 'package:commerce_flutter_app/features/domain/mapper/product_price_mapper.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class AddCartLineMapper {
  AddCartLineEntity toEntity(AddCartLine? model) => AddCartLineEntity(
        productId: model?.productId,
        qtyOrdered: model?.qtyOrdered,
        unitOfMeasure: model?.unitOfMeasure,
        notes: model?.notes,
        vmiBinId: model?.vmiBinId,
        sectionOptions: model?.sectionOptions
            ?.map((e) => SectionOptionEntityMapper().toEntity(e))
            .toList(),
      );
}

class CartLineListMapper {
  CartLineListEntity toEntity(CartLineList model) => CartLineListEntity(
        cartLines: model.cartLines
            ?.map((e) => CartLineEntityMapper().toEntity(e))
            .toList(),
      );
}

class CartLineEntityMapper {
  CartLineEntity toEntity(CartLine model) => CartLineEntity(
        productUri: model.productUri,
        id: model.id,
        productId: model.productId,
        line: model.line,
        qtyOrdered: model.qtyOrdered,
        requisitionId: model.requisitionId,
        smallImagePath: model.smallImagePath,
        altText: model.altText,
        productName: model.productName,
        manufacturerItem: model.manufacturerItem,
        customerName: model.customerName,
        shortDescription: model.shortDescription,
        erpNumber: model.erpNumber,
        unitOfMeasureDisplay: model.unitOfMeasureDisplay,
        unitOfMeasureDescription: model.unitOfMeasureDescription,
        baseUnitOfMeasure: model.baseUnitOfMeasure,
        baseUnitOfMeasureDisplay: model.baseUnitOfMeasureDisplay,
        qtyPerBaseUnitOfMeasure: model.qtyPerBaseUnitOfMeasure,
        costCode: model.costCode,
        qtyLeft: model.qtyLeft,
        pricing: ProductPriceEntityMapper().toEntity(model.pricing),
        isPromotionItem: model.isPromotionItem,
        isDiscounted: model.isDiscounted,
        isFixedConfiguration: model.isFixedConfiguration,
        quoteRequired: model.quoteRequired,
        breakPrices: model.breakPrices
            ?.map((e) => BreakPriceEntityMapper().toEntity(e))
            .toList(),
        availability: AvailabilityEntityMapper().toEntity(model.availability),
        qtyOnHand: model.qtyOnHand,
        canAddToCart: model.canAddToCart,
        isQtyAdjusted: model.isQtyAdjusted,
        hasInsufficientInventory: model.hasInsufficientInventory,
        canBackOrder: model.canBackOrder,
        salePriceLabel: model.salePriceLabel,
        isSubscription: model.isSubscription,
        productSubscription: ProductSubscriptionEntityMapper()
            .toEntity(model.productSubscription),
        isRestricted: model.isRestricted,
        isActive: model.isActive,
        brand: BrandEntityMapper().toEntity(model.brand),
        status: model.status,
        notes: model.notes,
        vmiBinId: model.vmiBinId,
        sectionOptions: model.sectionOptions
            ?.map((e) => SectionOptionEntityMapper().toEntity(e))
            .toList(),
    
      );

  CartLine toModel(CartLineEntity entity) => CartLine(
        productUri: entity.productUri,
        id: entity.id,
        line: entity.line,
        requisitionId: entity.requisitionId,
        smallImagePath: entity.smallImagePath,
        altText: entity.altText,
        qtyOrdered: entity.qtyOrdered,
        productName: entity.productName,
        manufacturerItem: entity.manufacturerItem,
        customerName: entity.customerName,
        shortDescription: entity.shortDescription,
        erpNumber: entity.erpNumber,
        unitOfMeasureDisplay: entity.unitOfMeasureDisplay,
        unitOfMeasureDescription: entity.unitOfMeasureDescription,
        baseUnitOfMeasure: entity.baseUnitOfMeasure,
        baseUnitOfMeasureDisplay: entity.baseUnitOfMeasureDisplay,
        qtyPerBaseUnitOfMeasure: entity.qtyPerBaseUnitOfMeasure,
        costCode: entity.costCode,
        qtyLeft: entity.qtyLeft,
        pricing: ProductPriceEntityMapper()
            .toModel(entity.pricing ?? ProductPriceEntity()),
        isPromotionItem: entity.isPromotionItem,
        isDiscounted: entity.isDiscounted,
        isFixedConfiguration: entity.isFixedConfiguration,
        quoteRequired: entity.quoteRequired,
        breakPrices: entity.breakPrices
            ?.map((e) => BreakPriceEntityMapper().toModel(e))
            .toList(),
        availability: AvailabilityEntityMapper()
            .toModel(entity.availability ?? AvailabilityEntity()),
        qtyOnHand: entity.qtyOnHand,
        canAddToCart: entity.canAddToCart,
        isQtyAdjusted: entity.isQtyAdjusted,
        hasInsufficientInventory: entity.hasInsufficientInventory,
        canBackOrder: entity.canBackOrder,
        salePriceLabel: entity.salePriceLabel,
        isSubscription: entity.isSubscription,
        productSubscription: ProductSubscriptionEntityMapper()
            .toModel(entity.productSubscription ?? ProductSubscriptionEntity()),
        isRestricted: entity.isRestricted,
        isActive: entity.isActive,
        brand: BrandEntityMapper().toModel(entity.brand ?? BrandEntity()),
        status: entity.status,
      );
}

class SectionOptionEntityMapper {
  SectionOptionEntity toEntity(SectionOptionDto model) => SectionOptionEntity(
        sectionOptionId: model.sectionOptionId,
        sectionName: model.sectionName,
        optionName: model.optionName,
      );

  SectionOptionDto toModel(SectionOptionEntity entity) => SectionOptionDto(
        sectionOptionId: entity.sectionOptionId,
        sectionName: entity.sectionName,
        optionName: entity.optionName,
      );
}

class ProductSubscriptionEntityMapper {
  ProductSubscriptionEntity toEntity(ProductSubscriptionDto? model) =>
      ProductSubscriptionEntity(
        subscriptionAddToInitialOrder: model?.subscriptionAddToInitialOrder,
        subscriptionAllMonths: model?.subscriptionAllMonths,
        subscriptionApril: model?.subscriptionApril,
        subscriptionAugust: model?.subscriptionAugust,
        subscriptionCyclePeriod: model?.subscriptionCyclePeriod,
        subscriptionDecember: model?.subscriptionDecember,
        subscriptionFebruary: model?.subscriptionFebruary,
        subscriptionFixedPrice: model?.subscriptionFixedPrice,
        subscriptionJanuary: model?.subscriptionJanuary,
        subscriptionJuly: model?.subscriptionJuly,
        subscriptionJune: model?.subscriptionJune,
        subscriptionMarch: model?.subscriptionMarch,
        subscriptionMay: model?.subscriptionMay,
        subscriptionNovember: model?.subscriptionNovember,
        subscriptionOctober: model?.subscriptionOctober,
        subscriptionPeriodsPerCycle: model?.subscriptionPeriodsPerCycle,
        subscriptionSeptember: model?.subscriptionSeptember,
        subscriptionShipViaId: model?.subscriptionShipViaId,
        subscriptionTotalCycles: model?.subscriptionTotalCycles,
      );

  ProductSubscriptionDto toModel(ProductSubscriptionEntity entity) =>
      ProductSubscriptionDto(
        subscriptionAddToInitialOrder: entity.subscriptionAddToInitialOrder,
        subscriptionAllMonths: entity.subscriptionAllMonths,
        subscriptionApril: entity.subscriptionApril,
        subscriptionAugust: entity.subscriptionAugust,
        subscriptionCyclePeriod: entity.subscriptionCyclePeriod,
        subscriptionDecember: entity.subscriptionDecember,
        subscriptionFebruary: entity.subscriptionFebruary,
        subscriptionFixedPrice: entity.subscriptionFixedPrice,
        subscriptionJanuary: entity.subscriptionJanuary,
        subscriptionJuly: entity.subscriptionJuly,
        subscriptionJune: entity.subscriptionJune,
        subscriptionMarch: entity.subscriptionMarch,
        subscriptionMay: entity.subscriptionMay,
        subscriptionNovember: entity.subscriptionNovember,
        subscriptionOctober: entity.subscriptionOctober,
        subscriptionPeriodsPerCycle: entity.subscriptionPeriodsPerCycle,
        subscriptionSeptember: entity.subscriptionSeptember,
        subscriptionShipViaId: entity.subscriptionShipViaId,
        subscriptionTotalCycles: entity.subscriptionTotalCycles,
      );
}
