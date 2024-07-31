import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/features/domain/entity/wish_list/wish_list_line_entity.dart';
import 'package:commerce_flutter_app/features/domain/extensions/product_pricing_extensions.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

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
        priceValueText = this!.pricing.getPriceValue() ?? "";
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
        subtotalValueText = this!.pricing.getSubtotalValue() ?? "";
      }
    }

    return subtotalValueText;
  }

  String get updateUnitOfMeasureValueText {
    if (this == null) {
      return "";
    }
    var uomText = "";
    if (this!.pricing != null && this!.pricing!.isOnSale!) {
      if (!this!.unitOfMeasureDescription.isNullorWhitespace) {
        uomText = this!.unitOfMeasureDescription ?? "";
      } else {
        uomText = this!.unitOfMeasureDisplay ?? "";
      }
    } else {
      uomText = this!.pricing.getUnitOfMeasure(uomText) ?? "";
    }

    return uomText;
  }
}
