import 'package:commerce_flutter_app/features/domain/entity/availability_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_details/product_details_base_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/styled_product_entity.dart';
import 'package:commerce_flutter_app/features/domain/usecases/porduct_details_usecase/product_details_usecase.dart';

class ProductDetailsPriceEntity extends ProductDetailsBaseEntity {
  final bool? productPricingEnabled;
  final bool? hidePricing;
  final bool? hideInventory;
  final bool? showInventoryAvailability;
  final String? discountMessage;
  final AvailabilityEntity? availability;
  final String? priceValueText;
  final ProductEntity? product;
  final StyledProductEntity? styledProduct;
  final String? selectedUnitOfMeasureValueText;
  final int? quantity;
  final bool? viewQuantityPricingButtonShown;
  final bool? viewInventoryByWarehouseShown;

  final bool? addToCartVisible;
  final bool? addToCartEnabled;

  const ProductDetailsPriceEntity(
      {this.productPricingEnabled,
      this.hidePricing,
      this.hideInventory,
      this.showInventoryAvailability,
      this.discountMessage,
      this.availability,
      this.priceValueText,
      this.product,
      this.styledProduct,
      this.selectedUnitOfMeasureValueText,
      this.viewQuantityPricingButtonShown,
      this.viewInventoryByWarehouseShown,
      this.addToCartVisible,
      this.addToCartEnabled,
      this.quantity,
      required super.detailsSectionType});

  @override
  ProductDetailsPriceEntity copyWith(
      {bool? productPricingEnabled,
      bool? hidePricing,
      bool? hideInventory,
      bool? showInventoryAvailability,
      String? discountMessage,
      AvailabilityEntity? availability,
      String? priceValueText,
      ProductEntity? product,
      StyledProductEntity? styledProduct,
      String? selectedUnitOfMeasureValueText,
      int? quantity,
      bool? viewQuantityPricingButtonShown,
      bool? viewInventoryByWarehouseShown,
      bool? hasCheckout,
      bool? addToCartEnabled,
      bool? addToCartVisible,
      ProdcutDeatilsPageWidgets? detailsSectionType}) {
    return ProductDetailsPriceEntity(
      productPricingEnabled:
          productPricingEnabled ?? this.productPricingEnabled,
      hidePricing: hidePricing ?? this.hidePricing,
      hideInventory: hideInventory ?? this.hideInventory,
      showInventoryAvailability:
          showInventoryAvailability ?? this.showInventoryAvailability,
      discountMessage: discountMessage ?? this.discountMessage,
      availability: availability ?? this.availability,
      priceValueText: priceValueText ?? this.priceValueText,
      product: product ?? this.product,
      styledProduct: styledProduct ?? this.styledProduct,
      selectedUnitOfMeasureValueText:
          selectedUnitOfMeasureValueText ?? this.selectedUnitOfMeasureValueText,
      quantity: quantity ?? this.quantity,
      detailsSectionType: detailsSectionType ?? this.detailsSectionType,
      viewQuantityPricingButtonShown:
          viewQuantityPricingButtonShown ?? this.viewQuantityPricingButtonShown,
      viewInventoryByWarehouseShown:
          viewInventoryByWarehouseShown ?? this.viewInventoryByWarehouseShown,
      addToCartVisible: addToCartVisible ?? this.addToCartVisible,
      addToCartEnabled: addToCartEnabled ?? this.addToCartEnabled,
    );
  }

  @override
  List<Object?> get props => [
        productPricingEnabled,
        hidePricing,
        hideInventory,
        showInventoryAvailability,
        discountMessage,
        availability,
        priceValueText,
        product,
        styledProduct,
        selectedUnitOfMeasureValueText,
        quantity,
        viewQuantityPricingButtonShown,
        viewInventoryByWarehouseShown,
        addToCartVisible,
        addToCartEnabled
      ];
}
