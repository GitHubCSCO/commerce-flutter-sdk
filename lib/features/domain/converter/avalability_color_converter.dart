import 'dart:ui';

import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/features/domain/enums/stock_availability.dart';

class AvailabilityColorConverter {
  static Color convert(int? messageType) {
    StockAvailability? availabilityEnum;
    if (messageType != null) {
      availabilityEnum =
          StockAvailability.values.firstWhere((e) => e.value == messageType);
    } else {
      availabilityEnum = StockAvailability.inOfStock;
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
