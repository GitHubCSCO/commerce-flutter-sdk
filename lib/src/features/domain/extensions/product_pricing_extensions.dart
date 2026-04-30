import 'package:commerce_flutter_sdk/src/core/constants/site_message_constants.dart';
import 'package:commerce_flutter_sdk/src/features/domain/converter/discount_value_convertert.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/product_price_entity.dart';

extension ProductPriceExtensions on ProductPriceEntity? {
  String? getPriceValue({bool? allowZeroPricing}) {
    if (this == null) {
      return SiteMessageConstants.valueRealTimePricingLoadFail;
    }

    // XNG-Change: XSD-21774 always show zero price message
    if (this?.unitNetPrice == 0) {
      return SiteMessageConstants.valuePricingZeroPriceMessage;
    }

    return this?.unitNetPriceDisplay;
  }

  String? getSubtotalValue({bool? allowZeroPricing}) {
    if (this == null) {
      return SiteMessageConstants.valueRealTimePricingLoadFail;
    }

    // XNG-Change: XSD-21774 always show zero price message
    if (this?.unitNetPrice == 0) {
      return SiteMessageConstants.valuePricingZeroPriceMessage;
    }

    return this?.extendedUnitNetPriceDisplay;
  }

  String? getUnitOfMeasure(String defaultUnitOfMeasure) {
    if (this == null) {
      return defaultUnitOfMeasure;
    }

    if (this?.unitNetPrice == 0) {
      return '';
    }

    return defaultUnitOfMeasure;
  }

  String getDiscountValue() {
    if (this == null || this?.unitNetPrice == 0) {
      return '';
    }

    return (DiscountValueConverter().convert(this) ?? '').toString();
  }
}
