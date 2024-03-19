import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/constants/site_message_constants.dart';
import 'package:commerce_flutter_app/features/domain/entity/cart_line_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/styled_product_entity.dart';
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

  String updatePriceValueText(bool? productPricingEnabled) {
    if (this != null && (this!.quoteRequired ?? false)) {
      return LocalizationConstants.requiresQuote;
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

// extension OrderLineExtensions on OrderLine {
//   String getProductNumber() {
//     return productErpNumber ?? '';
//   }
// }

// extension WishListLineExtensions on WishListLine {
//   String getProductNumber() {
//     return erpNumber ?? '';
//   }
// }

// extension InvoiceLineExtensions on InvoiceLine {
//   String getProductNumber() {
//     return productErpNumber ?? '';
//   }
// }

// extension AutocompleteProductExtensions on AutocompleteProduct {
//   String getProductNumber() {
//     return erpNumber ?? '';
//   }
// }

// extension QuoteLineExtensions on QuoteLine {
//   String getProductNumber() {
//     return erpNumber ?? '';
//   }
// }
