import 'package:commerce_flutter_sdk/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/features/domain/entity/wish_list/wish_list_line_entity.dart';
import 'package:commerce_flutter_sdk/features/domain/extensions/product_pricing_extensions.dart';

extension WishListLineExtensions on WishListLineEntity? {
  String get updatePriceValueText {
    if (this == null) {
      return "";
    }
    var priceValueText = "";
    if (this!.pricing != null && this!.pricing!.isOnSale!) {
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

  String get updateSubtotalPriceValueText {
    if (this == null) {
      return "";
    }
    var subtotalValueText = "";
    if (this!.pricing != null && this!.pricing!.isOnSale!) {
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

  String get updateUnitOfMeasureValueText {
    if (this == null) {
      return "";
    }
    var uomText = "";
    if (this!.pricing != null && this!.pricing!.isOnSale == true) {
      uomText = this!.unitOfMeasure ?? "";
    } else {
      uomText = this!.pricing.getUnitOfMeasure(this!.unitOfMeasure ?? "") ?? "";
    }

    return uomText.isEmpty ? '' : ' / $uomText';
  }
}
