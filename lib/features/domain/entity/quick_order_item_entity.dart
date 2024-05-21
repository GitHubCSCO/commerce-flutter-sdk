import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/constants/site_message_constants.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_price_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_unit_of_measure_entity.dart';
import 'package:commerce_flutter_app/features/domain/extensions/product_pricing_extensions.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class QuickOrderItemEntity {

  ProductEntity productEntity;
  VmiBinModel vmiBin;
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

  //need to add SelectedUnitOfMeasure

  QuickOrderItemEntity(this.productEntity, this.quantityOrdered);

  QuickOrderItemEntity copyWith({
    ProductEntity? productEntity,
    int? quantityOrdered,
  }) {
    return QuickOrderItemEntity(
      productEntity ?? this.productEntity,
      quantityOrdered ?? this.quantityOrdered,
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
            ? LocalizationConstants.requiresQuote
            : pricing.getPriceValue(); // Assuming getPriceValue() returns a string
        extendedPriceValueText = (productEntity.quoteRequired!)
            ? LocalizationConstants.requiresQuote
            : pricing.getSubtotalValue(); // Assuming getSubtotalValue() returns a string
        selectedUnitOfMeasureValueText = pricing.getUnitOfMeasure(uomText ?? ''); // Assuming getUnitOfMeasure() returns a string
      }

      discountValueText = pricing.getDiscountValue() ?? ''; // Assuming getDiscountValue() returns a string

    } else {
      priceValueText = SiteMessageConstants.valuePricingSignInForPrice;
    }
  }

  void updateSelectedUnitOfMeasure(ProductUnitOfMeasureEntity? selectedUnitOfMeasure) {
    this.selectedUnitOfMeasure = selectedUnitOfMeasure;
    if (selectedUnitOfMeasure == null) {
      selectedUnitOfMeasureTitle = '';
      selectedUnitOfMeasureValueText = '';
    } else if (selectedUnitOfMeasure.description?.trim().isNotEmpty ?? false) {
      selectedUnitOfMeasureTitle = selectedUnitOfMeasure.description;
      selectedUnitOfMeasureValueText = (selectedUnitOfMeasure.qtyPerBaseUnitOfMeasure! > 1)
          ? '${selectedUnitOfMeasure.description} /${selectedUnitOfMeasure.qtyPerBaseUnitOfMeasure}'
          : selectedUnitOfMeasure.description;
    } else if (selectedUnitOfMeasure.unitOfMeasureDisplay?.trim().isNotEmpty ?? false) {
      selectedUnitOfMeasureTitle = selectedUnitOfMeasure.unitOfMeasureDisplay;
      selectedUnitOfMeasureValueText = (selectedUnitOfMeasure.qtyPerBaseUnitOfMeasure! > 1)
          ? '${selectedUnitOfMeasure.unitOfMeasureDisplay} /${selectedUnitOfMeasure.qtyPerBaseUnitOfMeasure}'
          : selectedUnitOfMeasure.unitOfMeasureDisplay;
    } else {
      selectedUnitOfMeasureTitle = '';
      selectedUnitOfMeasureValueText = '';
    }
  }

}