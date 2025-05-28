import 'dart:ui';

import 'package:commerce_flutter_sdk/src/core/colors/app_colors.dart';
import 'package:commerce_flutter_sdk/src/features/domain/enums/stock_availability.dart';

class AvailabilityColorConverter {
  static Color convert(int? messageType) {
    StockAvailability? availabilityEnum = StockAvailability.inOfStock;
    if (messageType != null) {
      for (var val in StockAvailability.values) {
        if (val.value == messageType) {
          availabilityEnum = val;
          break;
        }
      }
    }

    switch (availabilityEnum) {
      case StockAvailability.inOfStock:
        return OptiAppColors.inStockColor;
      case StockAvailability.outOfStock:
        return OptiAppColors.outOfStockColor;
      case StockAvailability.lowStock:
        return OptiAppColors.lowStockColor;
      default:
        return OptiAppColors.inStockColor;
    }
  }
}
