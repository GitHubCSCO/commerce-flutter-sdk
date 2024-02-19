import 'package:commerce_flutter_app/features/domain/entity/availability_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_details/product_details_base_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_price_entity.dart';
import 'package:commerce_flutter_app/features/domain/usecases/porduct_details_usecase/product_details_usecase.dart';

class ProductDetailsPriceEntity extends ProductDetailsBaseEntity {
  final bool? productPricingEnabled;
  final bool? showHidePricing;
  final bool? showHideInventory;
  final bool? showInventoryAvailability;
  final String? discountMessage;
  final AvailabilityEntity? availability;
  final ProductPriceEntity? pricing;

  const ProductDetailsPriceEntity(
      {this.productPricingEnabled,
      this.showHidePricing,
      this.showHideInventory,
      this.showInventoryAvailability,
      this.discountMessage,
      this.availability,
      this.pricing,
      required super.detailsSectionType});

  @override
  ProductDetailsPriceEntity copyWith({
    ProdcutDeatilsPageWidgets? detailsSectionType,
    String? description,
  }) {
    return ProductDetailsPriceEntity(
        productPricingEnabled: productPricingEnabled,
        showHidePricing: showHidePricing,
        showHideInventory: showHideInventory,
        showInventoryAvailability: showInventoryAvailability,
        discountMessage: discountMessage,
        availability: availability,
        pricing: pricing,
        detailsSectionType: detailsSectionType!);
  }
}
