import 'package:commerce_flutter_app/features/domain/entity/cart_line_entity.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class AddCartLineMapper {
  AddCartLineEntity toEntity(AddCartLine model) => AddCartLineEntity(
        productId: model.productId,
        qtyOrdered: model.qtyOrdered,
        unitOfMeasure: model.unitOfMeasure,
        notes: model.notes,
        vmiBinId: model.vmiBinId,
        sectionOptions: model.sectionOptions
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
        productId: model.productId,
        qtyOrdered: model.qtyOrdered,
        unitOfMeasure: model.unitOfMeasure,
        notes: model.notes,
        vmiBinId: model.vmiBinId,
        sectionOptions: model.sectionOptions
            ?.map((e) => SectionOptionEntityMapper().toEntity(e))
            .toList(),
        // Add other properties here
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
  ProductSubscriptionEntity toEntity(ProductSubscriptionDto model) =>
      ProductSubscriptionEntity(
        subscriptionAddToInitialOrder: model.subscriptionAddToInitialOrder,
        subscriptionAllMonths: model.subscriptionAllMonths,
        subscriptionApril: model.subscriptionApril,
        subscriptionAugust: model.subscriptionAugust,
        subscriptionCyclePeriod: model.subscriptionCyclePeriod,
        subscriptionDecember: model.subscriptionDecember,
        subscriptionFebruary: model.subscriptionFebruary,
        subscriptionFixedPrice: model.subscriptionFixedPrice,
        subscriptionJanuary: model.subscriptionJanuary,
        subscriptionJuly: model.subscriptionJuly,
        subscriptionJune: model.subscriptionJune,
        subscriptionMarch: model.subscriptionMarch,
        subscriptionMay: model.subscriptionMay,
        subscriptionNovember: model.subscriptionNovember,
        subscriptionOctober: model.subscriptionOctober,
        subscriptionPeriodsPerCycle: model.subscriptionPeriodsPerCycle,
        subscriptionSeptember: model.subscriptionSeptember,
        subscriptionShipViaId: model.subscriptionShipViaId,
        subscriptionTotalCycles: model.subscriptionTotalCycles,
      );
}
