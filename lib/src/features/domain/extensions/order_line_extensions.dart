/// XNGAGE CONFIDENTIAL
/// __________________________
///
/// Copyright (C) 2025 Xngage - All Rights Reserved
///
/// All code or information contained herein is, and remains the
/// property of Xngage LLC and its customers. The intellectual
/// and technical concepts contained are proprietary to Xngage LLC
/// and may be covered by U.S. and Foreign Patents, patents in
/// process, and are protected by trade secret or copyright law.
/// Dissemination of this information or reproduction of this material
/// is strictly forbidden unless prior written permission is obtained
/// from Xngage LLC.

import 'package:commerce_flutter_sdk/src/core/constants/site_message_constants.dart';
import 'package:commerce_flutter_sdk/src/features/domain/converter/discount_value_convertert.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/order/order_line_entity.dart';

extension OrderLineExtensions on OrderLineEntity? {
  bool isZeroPrice() {
    return this?.unitNetPrice == 0;
  }

  String getDiscountMessage() {
    if (this == null) {
      return '';
    }

    return isZeroPrice()
        ? ''
        : (DiscountValueConverter().convert(this) ?? '').toString();
  }

  String getPriceValueText() {
    if (this == null) {
      return '';
    }

    return isZeroPrice()
        ? SiteMessageConstants.valuePricingZeroPriceMessage
        : (this!.unitNetPriceDisplay ?? '');
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

  String getSubtotalPriceText() {
    if (this == null) {
      return '';
    }

    return isZeroPrice()
        ? SiteMessageConstants.valuePricingZeroPriceMessage
        : (this!.extendedUnitNetPriceDisplay ?? '');
  }
}
