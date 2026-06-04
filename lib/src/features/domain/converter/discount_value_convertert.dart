import 'package:commerce_flutter_sdk/src/core/constants/core_constants.dart';
import 'package:commerce_flutter_sdk/src/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/order/order_line_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/product_price_entity.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class DiscountValueConverter {
  String? convert(
    dynamic value, {
    bool showSavingsAmount = true,
    bool showSavingsPercent = true,
  }) {
    String? unitListPriceDisplay;
    double? unitListPrice = 0;
    double? unitNetPrice = 0;

    if (value is ProductPriceEntity) {
      unitListPriceDisplay = value.unitListPriceDisplay;
      unitListPrice = value.unitListPrice as double?;
      unitNetPrice = value.unitNetPrice as double?;
    } else if (value is OrderLineEntity) {
      unitListPriceDisplay = value.unitListPriceDisplay;
      unitListPrice = value.unitListPrice as double?;
      unitNetPrice = value.unitNetPrice as double?;
    } else if (value is InvoiceLine) {
      var savingsAmount = value.discountAmount ?? 0;
      var savingPercent = (value.discountPercent ?? 0).round();

      if (savingsAmount == 0 && savingPercent == 0) {
        return null;
      }

      var discountMessage =
          "${LocalizationConstants.regularPrice.localized()}: ${value.unitPriceDisplay}";

      var savingsParts = _buildSavingsParts(
        savingsAmount: savingsAmount.toDouble(),
        savingPercent: savingPercent,
        showSavingsAmount: showSavingsAmount,
        showSavingsPercent: showSavingsPercent,
      );

      if (savingsParts != null) {
        discountMessage +=
            ", ${LocalizationConstants.youSave.localized()} $savingsParts";
      }

      return discountMessage;
    }

    if (unitListPriceDisplay != null &&
        unitListPrice != 0 &&
        unitListPrice! > unitNetPrice!) {
      var savingsAmount = unitListPrice - unitNetPrice;
      var savingPercent =
          ((unitListPrice - unitNetPrice) / unitListPrice * 100).round();

      if (savingsAmount == 0) {
        return null;
      }

      var discountMessage =
          "${LocalizationConstants.regularPrice.localized()}: $unitListPriceDisplay";

      var savingsParts = _buildSavingsParts(
        savingsAmount: savingsAmount,
        savingPercent: savingPercent,
        showSavingsAmount: showSavingsAmount,
        showSavingsPercent: showSavingsPercent,
      );

      if (savingsParts != null) {
        discountMessage +=
            ", ${LocalizationConstants.youSave.localized()} $savingsParts";
      }

      return discountMessage;
    }

    return null;
  }

  String? _buildSavingsParts({
    required double savingsAmount,
    required int savingPercent,
    required bool showSavingsAmount,
    required bool showSavingsPercent,
  }) {
    if (!showSavingsAmount && !showSavingsPercent) {
      return null;
    }

    var parts = '';
    if (showSavingsAmount) {
      parts +=
          '${CoreConstants.currencySymbol}${savingsAmount.toStringAsFixed(2)}';
    }
    if (showSavingsPercent) {
      if (showSavingsAmount) {
        parts += ' ($savingPercent%)';
      } else {
        parts += '$savingPercent%';
      }
    }

    return parts.isEmpty ? null : parts;
  }
}
