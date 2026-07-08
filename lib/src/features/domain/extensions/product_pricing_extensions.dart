import 'package:commerce_flutter_sdk/src/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/src/core/constants/site_message_constants.dart';
import 'package:commerce_flutter_sdk/src/core/injection/injection_container.dart';
import 'package:commerce_flutter_sdk/src/features/domain/converter/discount_value_convertert.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/product_price_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/service/interfaces/core_service_provider_interface.dart';

class VatPriceDisplay {
  static const String displayWithVat = 'DisplayWithVat';
  static const String displayWithoutVat = 'DisplayWithoutVat';
  static const String displayWithAndWithoutVat = 'DisplayWithAndWithoutVat';
}

(bool?, String?)? _globalVatSettings() {
  if (!sl.isRegistered<ICoreServiceProvider>()) {
    return null;
  }
  final config = sl<ICoreServiceProvider>().getAppConfigurationService();
  return (config.enableVat, config.vatPriceDisplay);
}

(bool, bool) _resolveVatDisplay(bool? enableVat, String? vatPriceDisplay) {
  var effectiveEnableVat = enableVat;
  var effectiveVatPriceDisplay = vatPriceDisplay;
  if (effectiveEnableVat == null && effectiveVatPriceDisplay == null) {
    final global = _globalVatSettings();
    effectiveEnableVat = global?.$1;
    effectiveVatPriceDisplay = global?.$2;
  }
  final vatEnabled = effectiveEnableVat == true;
  final displayWithVat = vatEnabled &&
      (effectiveVatPriceDisplay == VatPriceDisplay.displayWithVat ||
          effectiveVatPriceDisplay == VatPriceDisplay.displayWithAndWithoutVat);
  return (vatEnabled, displayWithVat);
}

bool shouldDisplayPriceWithVat(bool? enableVat, String? vatPriceDisplay) {
  return _resolveVatDisplay(enableVat, vatPriceDisplay).$2;
}

String _formatVatRate(num rate) =>
    rate % 1 == 0 ? rate.toInt().toString() : rate.toString();

extension ProductPriceExtensions on ProductPriceEntity? {
  String? getVatLabel({bool? enableVat, String? vatPriceDisplay}) {
    final (vatEnabled, displayWithVat) =
        _resolveVatDisplay(enableVat, vatPriceDisplay);
    if (!vatEnabled) {
      return null;
    }
    if (displayWithVat) {
      final rate = this?.vatRate;
      final ratePart = rate != null ? ' (${_formatVatRate(rate)}%)' : '';
      return '${LocalizationConstants.incVat.localized()}$ratePart';
    }
    return LocalizationConstants.exVat.localized();
  }

  String? getPriceValue({
    bool? allowZeroPricing,
    bool? enableVat,
    String? vatPriceDisplay,
  }) {
    if (this == null) {
      return SiteMessageConstants.valueRealTimePricingLoadFail;
    }

    // XNG-Change: XSD-21774 always show zero price message
    if (this?.unitNetPrice == 0) {
      return SiteMessageConstants.valuePricingZeroPriceMessage;
    }

    if (shouldDisplayPriceWithVat(enableVat, vatPriceDisplay)) {
      return this?.unitRegularPriceWithVatDisplay ?? this?.unitNetPriceDisplay;
    }

    return this?.unitNetPriceDisplay;
  }

  String? getSubtotalValue({
    bool? allowZeroPricing,
    bool? enableVat,
    String? vatPriceDisplay,
  }) {
    if (this == null) {
      return SiteMessageConstants.valueRealTimePricingLoadFail;
    }

    // XNG-Change: XSD-21774 always show zero price message
    if (this?.unitNetPrice == 0) {
      return SiteMessageConstants.valuePricingZeroPriceMessage;
    }

    if (shouldDisplayPriceWithVat(enableVat, vatPriceDisplay)) {
      return this?.extendedUnitRegularPriceWithVatDisplay ??
          this?.extendedUnitNetPriceDisplay;
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

  String getDiscountValue({
    bool showSavingsAmount = true,
    bool showSavingsPercent = true,
  }) {
    if (this == null || this?.unitNetPrice == 0) {
      return '';
    }

    return (DiscountValueConverter().convert(
              this,
              showSavingsAmount: showSavingsAmount,
              showSavingsPercent: showSavingsPercent,
            ) ??
            '')
        .toString();
  }
}
