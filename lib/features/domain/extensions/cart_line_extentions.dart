import 'package:commerce_flutter_sdk/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/features/domain/entity/cart_line_entity.dart';
import 'package:commerce_flutter_sdk/features/domain/extensions/product_pricing_extensions.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

extension CartLineExtensions on CartLineEntity? {
  String updatePriceValueText() {
    if (this == null) {
      return "";
    }
    var priceValueText = "";
    if ((this!.isPromotionItem != null && this!.isPromotionItem!) ||
        (this!.isDiscounted != null && this!.isDiscounted!) ||
        (this!.pricing != null && this!.pricing!.isOnSale!)) {
      priceValueText = this!.pricing!.unitNetPriceDisplay ?? "";
    } else {
      if (this!.quoteRequired != null && this!.quoteRequired!) {
        return LocalizationConstants.requiresQuote.localized().toString();
      } else {
        priceValueText = this!
                .pricing
                .getPriceValue(allowZeroPricing: this?.allowZeroPricing) ??
            "";
      }
    }

    return priceValueText;
  }

  String updateSubtotalPriceValueText() {
    if (this == null) {
      return "";
    }
    var subtotalValueText = "";
    if ((this!.isPromotionItem != null && this!.isPromotionItem!) ||
        (this!.isDiscounted != null && this!.isDiscounted!) ||
        (this!.pricing != null && this!.pricing!.isOnSale!)) {
      subtotalValueText = this!.pricing!.extendedUnitNetPriceDisplay ?? "";
    } else {
      if (this!.quoteRequired != null && this!.quoteRequired!) {
        return LocalizationConstants.requiresQuote.localized().toString();
      } else {
        subtotalValueText = this!
                .pricing
                .getSubtotalValue(allowZeroPricing: this?.allowZeroPricing) ??
            "";
      }
    }

    return subtotalValueText;
  }

  String updateUnitOfMeasureValueText() {
    if (this == null) {
      return "";
    }
    var uomText = ((!this!.unitOfMeasureDescription.isNullorWhitespace)
            ? this!.unitOfMeasureDescription
            : this!.unitOfMeasureDisplay) ??
        '';
    if ((this!.isPromotionItem == true) ||
        (this!.isDiscounted == true) ||
        (this!.pricing != null && this!.pricing!.isOnSale == true)) {
      return uomText.isEmpty ? '' : ' / $uomText';
    } else {
      uomText = this!.pricing.getUnitOfMeasure(uomText) ?? '';
    }

    return uomText.isEmpty ? '' : ' / $uomText';
  }
}
