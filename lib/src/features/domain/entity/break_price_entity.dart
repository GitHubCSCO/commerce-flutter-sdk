class BreakPriceDTOEntity {
  final num? breakQty;
  final num? breakPrice;
  final String? breakPriceDisplay;
  final String? savingsMessage;
  final num? breakPriceWithVat;
  final String? breakPriceWithVatDisplay;

  BreakPriceDTOEntity({
    this.breakQty,
    this.breakPrice,
    this.breakPriceDisplay,
    this.savingsMessage,
    this.breakPriceWithVat,
    this.breakPriceWithVatDisplay,
  });

  BreakPriceDTOEntity copyWith({
    num? breakQty,
    num? breakPrice,
    String? breakPriceDisplay,
    String? savingsMessage,
    num? breakPriceWithVat,
    String? breakPriceWithVatDisplay,
  }) {
    return BreakPriceDTOEntity(
      breakQty: breakQty ?? this.breakQty,
      breakPrice: breakPrice ?? this.breakPrice,
      breakPriceDisplay: breakPriceDisplay ?? this.breakPriceDisplay,
      savingsMessage: savingsMessage ?? this.savingsMessage,
      breakPriceWithVat: breakPriceWithVat ?? this.breakPriceWithVat,
      breakPriceWithVatDisplay:
          breakPriceWithVatDisplay ?? this.breakPriceWithVatDisplay,
    );
  }
}
