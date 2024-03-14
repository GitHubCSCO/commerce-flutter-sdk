import 'package:commerce_flutter_app/features/domain/entity/cart_line_entity.dart';
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
}

class SectionOptionEntityMapper {
  SectionOptionEntity toEntity(SectionOptionDto model) => SectionOptionEntity(
        sectionOptionId: model.sectionOptionId,
        sectionName: model.sectionName,
        optionName: model.optionName,
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
}
