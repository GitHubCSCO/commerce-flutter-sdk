import 'package:commerce_flutter_sdk/src/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/src/core/constants/site_message_constants.dart';
import 'package:commerce_flutter_sdk/src/features/domain/converter/discount_value_convertert.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/cart_line_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/extensions/product_pricing_extensions.dart';
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

  // <XNG-Change>: XSD-21774 always show zero price message
  bool isZeroPrice() {
    return this?.pricing?.unitNetPrice == 0;
  }

  String getPriceValueText() {
    if (this == null) {
      return '';
    }

    return isZeroPrice()
        ? SiteMessageConstants.valuePricingZeroPriceMessage
        : (this!.pricing?.unitNetPriceDisplay ?? '');
  }

  String? getUnitOfMeasureText() {
    if (this == null) {
      return null;
    }

    if (isZeroPrice()) {
      return null;
    }

    return this!.unitOfMeasureDisplay != null
        ? ' / ${this!.unitOfMeasureDisplay}'
        : null;
  }

  String getDiscountMessage() {
    if (this == null) {
      return '';
    }

    return isZeroPrice()
        ? ''
        : (DiscountValueConverter().convert(this) ?? '').toString();
  }

  String getSubtotalPriceText() {
    if (this == null) {
      return '';
    }

    return isZeroPrice()
        ? SiteMessageConstants.valuePricingZeroPriceMessage
        : (this!.pricing?.extendedUnitNetPriceDisplay ?? '');
  }
  // </XNG-Change>
}
