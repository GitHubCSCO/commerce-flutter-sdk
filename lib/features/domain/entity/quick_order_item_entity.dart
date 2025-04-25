import 'package:commerce_flutter_sdk/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/core/constants/site_message_constants.dart';
import 'package:commerce_flutter_sdk/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_sdk/features/domain/entity/product_price_entity.dart';
import 'package:commerce_flutter_sdk/features/domain/entity/product_unit_of_measure_entity.dart';
import 'package:commerce_flutter_sdk/features/domain/entity/vmi_bin_model_entity.dart';
import 'package:commerce_flutter_sdk/features/domain/extensions/product_pricing_extensions.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class QuickOrderItemEntity {
  ProductEntity productEntity;
  VmiBinModelEntity? vmiBinEntity;
  Availability? availability;
  ProductPriceEntity? pricing;
  ProductUnitOfMeasureEntity? selectedUnitOfMeasure;
  int quantityOrdered = 1;
  int previousQty = 1;
  String? priceValueText;
  String? extendedPriceValueText;
  bool? showInventoryAvailability;
  String? selectedUnitOfMeasureTitle;
  String? selectedUnitOfMeasureValueText;
  String? discountValueText;
  bool? hidePricingEnable;
  bool? hideInventoryEnable;

  //need to add SelectedUnitOfMeasure

  QuickOrderItemEntity(
    this.productEntity,
    this.quantityOrdered, {
    this.selectedUnitOfMeasure,
    this.vmiBinEntity,
    this.selectedUnitOfMeasureTitle,
    this.selectedUnitOfMeasureValueText,
  });

  QuickOrderItemEntity copyWith({
    ProductEntity? productEntity,
    int? quantityOrdered,
    ProductUnitOfMeasureEntity? selectedUnitOfMeasure,
    VmiBinModelEntity? vmiBinEntity,
    String? selectedUnitOfMeasureTitle,
    String? selectedUnitOfMeasureValueText,
  }) {
    return QuickOrderItemEntity(
      productEntity ?? this.productEntity,
      quantityOrdered ?? this.quantityOrdered,
      selectedUnitOfMeasure:
          selectedUnitOfMeasure ?? this.selectedUnitOfMeasure,
      vmiBinEntity: vmiBinEntity ?? this.vmiBinEntity,
      selectedUnitOfMeasureTitle:
          selectedUnitOfMeasureTitle ?? this.selectedUnitOfMeasureTitle,
      selectedUnitOfMeasureValueText:
          selectedUnitOfMeasureValueText ?? this.selectedUnitOfMeasureValueText,
    );
  }

  void updatePricing(ProductPriceEntity pricing, bool canSeePricing) {
    this.pricing = pricing;
    if (canSeePricing) {
      String? uomText = (selectedUnitOfMeasure?.description?.isEmpty ?? true)
          ? selectedUnitOfMeasure?.unitOfMeasureDisplay
          : selectedUnitOfMeasure?.description;

      if (pricing.isOnSale!) {
        priceValueText = pricing.unitNetPriceDisplay;
        extendedPriceValueText = pricing.extendedUnitNetPriceDisplay;
        selectedUnitOfMeasureValueText = uomText;
      } else {
        priceValueText = (productEntity.quoteRequired!)
            ? LocalizationConstants.requiresQuote.localized()
            : pricing.getPriceValue(
                allowZeroPricing: productEntity.allowZeroPricing,
              ); // Assuming getPriceValue() returns a string
        extendedPriceValueText = (productEntity.quoteRequired!)
            ? LocalizationConstants.requiresQuote.localized()
            : pricing.getSubtotalValue(
                allowZeroPricing: productEntity.allowZeroPricing,
              ); // Assuming getSubtotalValue() returns a string
        selectedUnitOfMeasureValueText = pricing.getUnitOfMeasure(
            uomText ?? ''); // Assuming getUnitOfMeasure() returns a string
      }

      discountValueText = pricing.getDiscountValue() ??
          ''; // Assuming getDiscountValue() returns a string
    } else {
      priceValueText = SiteMessageConstants.valuePricingSignInForPrice;
    }
  }

  void updateSelectedUnitOfMeasure(
      ProductUnitOfMeasureEntity? selectedUnitOfMeasure) {
    productEntity = productEntity.copyWith(
        selectedUnitOfMeasure: selectedUnitOfMeasure?.unitOfMeasure,
        selectedUnitOfMeasureDisplay:
            selectedUnitOfMeasure?.unitOfMeasureDisplay,
        unitOfMeasureDescription: selectedUnitOfMeasure?.description);
    this.selectedUnitOfMeasure = selectedUnitOfMeasure;

    if (selectedUnitOfMeasure == null) {
      selectedUnitOfMeasureTitle = '';
      selectedUnitOfMeasureValueText = '';
    } else if (selectedUnitOfMeasure.description?.trim().isNotEmpty ?? false) {
      selectedUnitOfMeasureTitle = selectedUnitOfMeasure.description;
      selectedUnitOfMeasureValueText = (selectedUnitOfMeasure
                  .qtyPerBaseUnitOfMeasure! >
              1)
          ? '${selectedUnitOfMeasure.description} /${selectedUnitOfMeasure.qtyPerBaseUnitOfMeasure}'
          : selectedUnitOfMeasure.description;
    } else if (selectedUnitOfMeasure.unitOfMeasureDisplay?.trim().isNotEmpty ??
        false) {
      selectedUnitOfMeasureTitle = selectedUnitOfMeasure.unitOfMeasureDisplay;
      selectedUnitOfMeasureValueText = (selectedUnitOfMeasure
                  .qtyPerBaseUnitOfMeasure! >
              1)
          ? '${selectedUnitOfMeasure.unitOfMeasureDisplay} /${selectedUnitOfMeasure.qtyPerBaseUnitOfMeasure}'
          : selectedUnitOfMeasure.unitOfMeasureDisplay;
    } else {
      selectedUnitOfMeasureTitle = '';
      selectedUnitOfMeasureValueText = '';
    }
  }
}
