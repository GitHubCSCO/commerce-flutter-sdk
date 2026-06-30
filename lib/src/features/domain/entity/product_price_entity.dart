// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:commerce_flutter_sdk/src/features/domain/entity/break_price_entity.dart';
import 'package:equatable/equatable.dart';

class ProductPriceEntity extends Equatable {
  final String? productId;
  final bool? isOnSale;
  final bool? requiresRealTimePrice;
  final bool? quoteRequired;
  final Map<String, String>? additionalResults;
  final num? unitCost;
  final String? unitCostDisplay;
  final num? unitListPrice;
  final String? unitListPriceDisplay;
  final num? extendedUnitListPrice;
  final String? extendedUnitListPriceDisplay;
  final num? unitRegularPrice;
  final String? unitRegularPriceDisplay;
  final num? extendedUnitRegularPrice;
  final String? extendedUnitRegularPriceDisplay;
  final num? unitNetPrice;
  final String? unitNetPriceDisplay;
  final num? extendedUnitNetPrice;
  final String? extendedUnitNetPriceDisplay;
  final String? unitOfMeasure;
  final num? vatRate;
  final num? vatAmount;
  final String? vatAmountDisplay;
  final num? unitListPriceWithVat;
  final String? unitListPriceWithVatDisplay;
  final num? extendedUnitListPriceWithVat;
  final String? extendedUnitListPriceWithVatDisplay;
  final num? unitRegularPriceWithVat;
  final String? unitRegularPriceWithVatDisplay;
  final num? extendedUnitRegularPriceWithVat;
  final String? extendedUnitRegularPriceWithVatDisplay;
  final num? vatMinusExtendedUnitRegularPrice;
  final List<BreakPriceDTOEntity>? unitListBreakPrices;
  final List<BreakPriceDTOEntity>? unitRegularBreakPrices;
  final num? regularPrice;
  final String? regularPriceDisplay;
  final num? extendedRegularPrice;
  final String? extendedRegularPriceDisplay;
  final num? actualPrice;
  final String? actualPriceDisplay;
  final num? extendedActualPrice;
  final String? extendedActualPriceDisplay;
  final List<BreakPriceDTOEntity>? regularBreakPrices;
  final List<BreakPriceDTOEntity>? actualBreakPrices;
  const ProductPriceEntity({
    this.productId,
    this.isOnSale,
    this.requiresRealTimePrice,
    this.quoteRequired,
    this.additionalResults,
    this.unitCost,
    this.unitCostDisplay,
    this.unitListPrice,
    this.unitListPriceDisplay,
    this.extendedUnitListPrice,
    this.extendedUnitListPriceDisplay,
    this.unitRegularPrice,
    this.unitRegularPriceDisplay,
    this.extendedUnitRegularPrice,
    this.extendedUnitRegularPriceDisplay,
    this.unitNetPrice,
    this.unitNetPriceDisplay,
    this.extendedUnitNetPrice,
    this.extendedUnitNetPriceDisplay,
    this.unitOfMeasure,
    this.vatRate,
    this.vatAmount,
    this.vatAmountDisplay,
    this.unitListPriceWithVat,
    this.unitListPriceWithVatDisplay,
    this.extendedUnitListPriceWithVat,
    this.extendedUnitListPriceWithVatDisplay,
    this.unitRegularPriceWithVat,
    this.unitRegularPriceWithVatDisplay,
    this.extendedUnitRegularPriceWithVat,
    this.extendedUnitRegularPriceWithVatDisplay,
    this.vatMinusExtendedUnitRegularPrice,
    this.unitListBreakPrices,
    this.unitRegularBreakPrices,
    this.regularPrice,
    this.regularPriceDisplay,
    this.extendedRegularPrice,
    this.extendedRegularPriceDisplay,
    this.actualPrice,
    this.actualPriceDisplay,
    this.extendedActualPrice,
    this.extendedActualPriceDisplay,
    this.regularBreakPrices,
    this.actualBreakPrices,
  });

  ProductPriceEntity copyWith({
    String? productId,
    bool? isOnSale,
    bool? requiresRealTimePrice,
    bool? quoteRequired,
    Map<String, String>? additionalResults,
    num? unitCost,
    String? unitCostDisplay,
    num? unitListPrice,
    String? unitListPriceDisplay,
    num? extendedUnitListPrice,
    String? extendedUnitListPriceDisplay,
    num? unitRegularPrice,
    String? unitRegularPriceDisplay,
    num? extendedUnitRegularPrice,
    String? extendedUnitRegularPriceDisplay,
    num? unitNetPrice,
    String? unitNetPriceDisplay,
    num? extendedUnitNetPrice,
    String? extendedUnitNetPriceDisplay,
    String? unitOfMeasure,
    num? vatRate,
    num? vatAmount,
    String? vatAmountDisplay,
    num? unitListPriceWithVat,
    String? unitListPriceWithVatDisplay,
    num? extendedUnitListPriceWithVat,
    String? extendedUnitListPriceWithVatDisplay,
    num? unitRegularPriceWithVat,
    String? unitRegularPriceWithVatDisplay,
    num? extendedUnitRegularPriceWithVat,
    String? extendedUnitRegularPriceWithVatDisplay,
    num? vatMinusExtendedUnitRegularPrice,
    List<BreakPriceDTOEntity>? unitListBreakPrices,
    List<BreakPriceDTOEntity>? unitRegularBreakPrices,
    num? regularPrice,
    String? regularPriceDisplay,
    num? extendedRegularPrice,
    String? extendedRegularPriceDisplay,
    num? actualPrice,
    String? actualPriceDisplay,
    num? extendedActualPrice,
    String? extendedActualPriceDisplay,
    List<BreakPriceDTOEntity>? regularBreakPrices,
    List<BreakPriceDTOEntity>? actualBreakPrices,
  }) {
    return ProductPriceEntity(
      productId: productId ?? this.productId,
      isOnSale: isOnSale ?? this.isOnSale,
      requiresRealTimePrice:
          requiresRealTimePrice ?? this.requiresRealTimePrice,
      quoteRequired: quoteRequired ?? this.quoteRequired,
      additionalResults: additionalResults ?? this.additionalResults,
      unitCost: unitCost ?? this.unitCost,
      unitCostDisplay: unitCostDisplay ?? this.unitCostDisplay,
      unitListPrice: unitListPrice ?? this.unitListPrice,
      unitListPriceDisplay: unitListPriceDisplay ?? this.unitListPriceDisplay,
      extendedUnitListPrice:
          extendedUnitListPrice ?? this.extendedUnitListPrice,
      extendedUnitListPriceDisplay:
          extendedUnitListPriceDisplay ?? this.extendedUnitListPriceDisplay,
      unitRegularPrice: unitRegularPrice ?? this.unitRegularPrice,
      unitRegularPriceDisplay:
          unitRegularPriceDisplay ?? this.unitRegularPriceDisplay,
      extendedUnitRegularPrice:
          extendedUnitRegularPrice ?? this.extendedUnitRegularPrice,
      extendedUnitRegularPriceDisplay: extendedUnitRegularPriceDisplay ??
          this.extendedUnitRegularPriceDisplay,
      unitNetPrice: unitNetPrice ?? this.unitNetPrice,
      unitNetPriceDisplay: unitNetPriceDisplay ?? this.unitNetPriceDisplay,
      extendedUnitNetPrice: extendedUnitNetPrice ?? this.extendedUnitNetPrice,
      extendedUnitNetPriceDisplay:
          extendedUnitNetPriceDisplay ?? this.extendedUnitNetPriceDisplay,
      unitOfMeasure: unitOfMeasure ?? this.unitOfMeasure,
      vatRate: vatRate ?? this.vatRate,
      vatAmount: vatAmount ?? this.vatAmount,
      vatAmountDisplay: vatAmountDisplay ?? this.vatAmountDisplay,
      unitListPriceWithVat: unitListPriceWithVat ?? this.unitListPriceWithVat,
      unitListPriceWithVatDisplay:
          unitListPriceWithVatDisplay ?? this.unitListPriceWithVatDisplay,
      extendedUnitListPriceWithVat:
          extendedUnitListPriceWithVat ?? this.extendedUnitListPriceWithVat,
      extendedUnitListPriceWithVatDisplay:
          extendedUnitListPriceWithVatDisplay ??
              this.extendedUnitListPriceWithVatDisplay,
      unitRegularPriceWithVat:
          unitRegularPriceWithVat ?? this.unitRegularPriceWithVat,
      unitRegularPriceWithVatDisplay:
          unitRegularPriceWithVatDisplay ?? this.unitRegularPriceWithVatDisplay,
      extendedUnitRegularPriceWithVat: extendedUnitRegularPriceWithVat ??
          this.extendedUnitRegularPriceWithVat,
      extendedUnitRegularPriceWithVatDisplay:
          extendedUnitRegularPriceWithVatDisplay ??
              this.extendedUnitRegularPriceWithVatDisplay,
      vatMinusExtendedUnitRegularPrice: vatMinusExtendedUnitRegularPrice ??
          this.vatMinusExtendedUnitRegularPrice,
      unitListBreakPrices: unitListBreakPrices ?? this.unitListBreakPrices,
      unitRegularBreakPrices:
          unitRegularBreakPrices ?? this.unitRegularBreakPrices,
      regularPrice: regularPrice ?? this.regularPrice,
      regularPriceDisplay: regularPriceDisplay ?? this.regularPriceDisplay,
      extendedRegularPrice: extendedRegularPrice ?? this.extendedRegularPrice,
      extendedRegularPriceDisplay:
          extendedRegularPriceDisplay ?? this.extendedRegularPriceDisplay,
      actualPrice: actualPrice ?? this.actualPrice,
      actualPriceDisplay: actualPriceDisplay ?? this.actualPriceDisplay,
      extendedActualPrice: extendedActualPrice ?? this.extendedActualPrice,
      extendedActualPriceDisplay:
          extendedActualPriceDisplay ?? this.extendedActualPriceDisplay,
      regularBreakPrices: regularBreakPrices ?? this.regularBreakPrices,
      actualBreakPrices: actualBreakPrices ?? this.actualBreakPrices,
    );
  }

  @override
  List<Object?> get props => [
        productId,
        isOnSale,
        requiresRealTimePrice,
        quoteRequired,
        additionalResults,
        unitCost,
        unitCostDisplay,
        unitListPrice,
        unitListPriceDisplay,
        extendedUnitListPrice,
        extendedUnitListPriceDisplay,
        unitRegularPrice,
        unitRegularPriceDisplay,
        extendedUnitRegularPrice,
        extendedUnitRegularPriceDisplay,
        unitNetPrice,
        unitNetPriceDisplay,
        extendedUnitNetPrice,
        extendedUnitNetPriceDisplay,
        unitOfMeasure,
        vatRate,
        vatAmount,
        vatAmountDisplay,
        unitListPriceWithVat,
        unitListPriceWithVatDisplay,
        extendedUnitListPriceWithVat,
        extendedUnitListPriceWithVatDisplay,
        unitRegularPriceWithVat,
        unitRegularPriceWithVatDisplay,
        extendedUnitRegularPriceWithVat,
        extendedUnitRegularPriceWithVatDisplay,
        vatMinusExtendedUnitRegularPrice,
        unitListBreakPrices,
        unitRegularBreakPrices,
        regularPrice,
        regularPriceDisplay,
        extendedRegularPrice,
        extendedRegularPriceDisplay,
        actualPrice,
        actualPriceDisplay,
        extendedActualPrice,
        extendedActualPriceDisplay,
        regularBreakPrices,
        actualBreakPrices,
      ];
}
