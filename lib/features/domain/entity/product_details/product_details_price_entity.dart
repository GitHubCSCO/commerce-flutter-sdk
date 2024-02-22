import 'package:commerce_flutter_app/features/domain/entity/availability_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_details/product_details_base_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_price_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/styled_product_entity.dart';
import 'package:commerce_flutter_app/features/domain/usecases/porduct_details_usecase/product_details_usecase.dart';

class ProductDetailsPriceEntity extends ProductDetailsBaseEntity {
  final bool? productPricingEnabled;
  final bool? showHidePricing;
  final bool? showHideInventory;
  final bool? showInventoryAvailability;
  final String? discountMessage;
  final AvailabilityEntity? availability;
  final ProductPriceEntity? pricing;
  final String? priceValueText;
  final ProductEntity? product;
  final StyledProductEntity? styledProduct;
  final String? selectedUnitOfMeasureValueText;

  const ProductDetailsPriceEntity(
      {this.productPricingEnabled,
      this.showHidePricing,
      this.showHideInventory,
      this.showInventoryAvailability,
      this.discountMessage,
      this.availability,
      this.pricing,
      this.priceValueText,
      this.product,
      this.styledProduct,
      this.selectedUnitOfMeasureValueText, 
      required super.detailsSectionType});

  @override
  ProductDetailsPriceEntity copyWith(
      {bool? productPricingEnabled,
      bool? showHidePricing,
      bool? showHideInventory,
      bool? showInventoryAvailability,
      String? discountMessage,
      AvailabilityEntity? availability,
      ProductPriceEntity? pricing,
      String? priceValueText,
      ProductEntity? product,
      StyledProductEntity? styledProduct,
      String? selectedUnitOfMeasureValueText,
      ProdcutDeatilsPageWidgets? detailsSectionType}) {
    return ProductDetailsPriceEntity(
      productPricingEnabled:
          productPricingEnabled ?? this.productPricingEnabled,
      showHidePricing: showHidePricing ?? this.showHidePricing,
      showHideInventory: showHideInventory ?? this.showHideInventory,
      showInventoryAvailability:
          showInventoryAvailability ?? this.showInventoryAvailability,
      discountMessage: discountMessage ?? this.discountMessage,
      availability: availability ?? this.availability,
      pricing: pricing ?? this.pricing,
      priceValueText: priceValueText ?? this.priceValueText,
      product: product ?? this.product,
      styledProduct: styledProduct ?? this.styledProduct,
      selectedUnitOfMeasureValueText:
          selectedUnitOfMeasureValueText ?? this.selectedUnitOfMeasureValueText,
      detailsSectionType: detailsSectionType ?? this.detailsSectionType,
    );
  }
}
