import 'package:commerce_flutter_sdk/core/constants/site_message_constants.dart';
import 'package:commerce_flutter_sdk/features/domain/converter/discount_value_convertert.dart';
import 'package:commerce_flutter_sdk/features/domain/entity/product_price_entity.dart';

extension ProductPriceExtensions on ProductPriceEntity? {
  String? getPriceValue({bool? allowZeroPricing}) {
    if (this == null) {
      return SiteMessageConstants.valueRealTimePricingLoadFail;
    }

    if (this?.unitNetPrice == 0 && allowZeroPricing != true) {
      return SiteMessageConstants.valuePricingZeroPriceMessage;
    }

    return this?.unitNetPriceDisplay;
  }

  String? getSubtotalValue({bool? allowZeroPricing}) {
    if (this == null) {
      return SiteMessageConstants.valueRealTimePricingLoadFail;
    }

    if (this?.unitNetPrice == 0 && allowZeroPricing != true) {
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
