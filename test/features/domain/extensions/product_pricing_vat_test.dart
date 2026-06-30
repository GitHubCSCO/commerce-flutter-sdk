import 'package:commerce_flutter_sdk/src/core/injection/injection_container.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/product_price_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/extensions/product_pricing_extensions.dart';
import 'package:commerce_flutter_sdk/src/features/domain/service/interfaces/localization_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class _FakeLocalizationService implements ILocalizationService {
  @override
  Map<String, String>? get translationDictionary => null;

  @override
  Language? getCurrentLanguage() => null;

  @override
  Future<Result<bool, ErrorResponse>> loadCurrentLanguage() async =>
      Success(true);

  @override
  Future<Result<bool, ErrorResponse>> changeLanguage(Language language) async =>
      Success(true);

  @override
  Future<void> removeCurrentLanguage() async {}
}

void main() {
  setUpAll(() {
    if (!sl.isRegistered<ILocalizationService>()) {
      sl.registerSingleton<ILocalizationService>(_FakeLocalizationService());
    }
  });

  tearDownAll(() async {
    await sl.reset();
  });

  const pricing = ProductPriceEntity(
    unitNetPrice: 11.22,
    unitNetPriceDisplay: r'$11.22',
    extendedUnitNetPriceDisplay: r'$11.22',
    unitRegularPriceWithVatDisplay: r'$12.34',
    extendedUnitRegularPriceWithVatDisplay: r'$12.34',
    vatRate: 10.0,
  );

  group('VAT-aware price display', () {
    test('shows net price when VAT is disabled', () {
      expect(pricing.getPriceValue(enableVat: false), r'$11.22');
      expect(pricing.getSubtotalValue(enableVat: false), r'$11.22');
    });

    test('shows net price when display mode is DisplayWithoutVat', () {
      expect(
          pricing.getPriceValue(
              enableVat: true,
              vatPriceDisplay: VatPriceDisplay.displayWithoutVat),
          r'$11.22');
    });

    test('shows VAT-inclusive price when DisplayWithVat', () {
      expect(
          pricing.getPriceValue(
              enableVat: true,
              vatPriceDisplay: VatPriceDisplay.displayWithVat),
          r'$12.34');
      expect(
          pricing.getSubtotalValue(
              enableVat: true,
              vatPriceDisplay: VatPriceDisplay.displayWithVat),
          r'$12.34');
    });

    test('shows VAT-inclusive price when DisplayWithAndWithoutVat', () {
      expect(
          pricing.getPriceValue(
              enableVat: true,
              vatPriceDisplay: VatPriceDisplay.displayWithAndWithoutVat),
          r'$12.34');
    });

    test('defaults to net price (backward compatible) when no VAT params', () {
      expect(pricing.getPriceValue(), r'$11.22');
      expect(pricing.getSubtotalValue(), r'$11.22');
    });

    test('falls back to net display when WithVat value is missing', () {
      const noVatField = ProductPriceEntity(
        unitNetPrice: 11.22,
        unitNetPriceDisplay: r'$11.22',
      );
      expect(
          noVatField.getPriceValue(
              enableVat: true,
              vatPriceDisplay: VatPriceDisplay.displayWithVat),
          r'$11.22');
    });
  });

  group('VAT label', () {
    test('no label when VAT disabled', () {
      expect(pricing.getVatLabel(enableVat: false), isNull);
    });

    test('Inc. VAT with rate when DisplayWithVat', () {
      expect(
          pricing.getVatLabel(
              enableVat: true,
              vatPriceDisplay: VatPriceDisplay.displayWithVat),
          'Inc. VAT (10%)');
    });

    test('Ex. VAT when enabled but DisplayWithoutVat', () {
      expect(
          pricing.getVatLabel(
              enableVat: true,
              vatPriceDisplay: VatPriceDisplay.displayWithoutVat),
          'Ex. VAT');
    });
  });
}
