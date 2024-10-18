import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/constants/site_message_constants.dart';
import 'package:commerce_flutter_app/features/domain/entity/cart_line_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/order/order_line_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/quote_line_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/styled_product_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/wish_list/wish_list_line_entity.dart';
import 'package:commerce_flutter_app/features/domain/extensions/product_pricing_extensions.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

extension ProductExtensions on ProductEntity? {
  String updateUnitOfMeasure(bool? productPricingEnabled) {
    if (!(productPricingEnabled ?? false)) {
      return '';
    }

    String uomText = this?.getUnitOfMeasure() ?? '';

    if (this?.pricing != null && !(this?.pricing?.isOnSale ?? false)) {
      uomText = this?.pricing?.getUnitOfMeasure(uomText) ?? '';
    }

    return uomText.isNullOrEmpty ? '' : " / $uomText";
  }

  String updateSubtotalPriceValueText() {
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

  String updatePriceValueText(bool? productPricingEnabled) {
    if (this != null && (this!.quoteRequired ?? false)) {
      return LocalizationConstants.requiresQuote.localized();
    }

    final priceDisplay =
        (this?.pricing != null && (this!.pricing!.isOnSale ?? false))
            ? this!.pricing!.unitNetPriceDisplay
            : this?.pricing?.getPriceValue() ?? '';

    return (productPricingEnabled ?? false)
        ? priceDisplay!
        : SiteMessageConstants.valuePricingSignInForPrice;
  }

  String getUnitOfMeasure() {
    return (this != null && this!.unitOfMeasureDescription.isNullOrEmpty
            ? this?.unitOfMeasureDisplay
            : this?.unitOfMeasureDescription) ??
        '';
  }

  String getProductNumber() {
    return this?.erpNumber ?? '';
  }
}

extension StyledProductExtensions on StyledProductEntity? {
  String getProductNumber() {
    return this?.erpNumber ?? '';
  }
}

extension CartLineExtensions on CartLineEntity {
  String getProductNumber() {
    return erpNumber ?? '';
  }
}

extension OrderLineExtensions on OrderLineEntity? {
  String getProductNumber() {
    return this?.productErpNumber ?? '';
  }
}

extension WishListLineExtensions on WishListLineEntity? {
  String getProductNumber() {
    return this?.erpNumber ?? '';
  }
}

extension InvoiceLineExtensions on InvoiceLine? {
  String getProductNumber() {
    return this?.productErpNumber ?? '';
  }
}

extension AutocompleteProductExtensions on AutocompleteProduct? {
  String getProductNumber() {
    return this?.erpNumber ?? '';
  }
}

extension QuoteLineExtensions on QuoteLineEntity? {
  String getProductNumber() {
    return this?.erpNumber ?? '';
  }
}
