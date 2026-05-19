import 'package:commerce_flutter_sdk/src/core/theme/app_theme_x.dart';
import 'package:commerce_flutter_sdk/src/features/domain/enums/stock_availability.dart';
import 'package:flutter/material.dart';

class AvailabilityColorConverter {
  static Color convert(BuildContext context, int? messageType) {
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
        return context.colors.inStockColor;
      case StockAvailability.outOfStock:
        return context.colors.outOfStockColor;
      case StockAvailability.lowStock:
        return context.colors.lowStockColor;
      default:
        return context.colors.inStockColor;
    }
  }
}
