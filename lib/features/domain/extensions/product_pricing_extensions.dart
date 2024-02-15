import 'package:commerce_flutter_app/core/constants/site_message_constants.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_price_entity.dart';

extension ProductPriceExtensions on ProductPriceEntity? {
  String? getPriceValue() {
    if (this == null) {
      return SiteMessageConstants.valueRealTimePricingLoadFail;
    }

    if (this?.unitNetPrice == 0) {
      return SiteMessageConstants.valuePricingZeroPriceMessage;
    }

    return this?.unitNetPriceDisplay;
  }

  String? getSubtotalValue() {
    if (this == null) {
      return SiteMessageConstants.valueRealTimePricingLoadFail;
    }

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

  // String getDiscountValue() {
  //   if (this == null || this?.unitNetPrice == 0) {
  //     return '';
  //   }

  //   return DiscountValueConverter().convert(this).toString();
  // }
}
