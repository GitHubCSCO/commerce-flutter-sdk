class BreakPriceEntity {
  final num? breakQty;
  final num? breakPrice;
  final String? breakPriceDisplay;
  final String? savingsMessage;
  final num? breakPriceWithVat;
  final String? breakPriceWithVatDisplay;
  
  BreakPriceEntity({
    this.breakQty,
    this.breakPrice,
    this.breakPriceDisplay,
    this.savingsMessage,
    this.breakPriceWithVat,
    this.breakPriceWithVatDisplay,
  });

  BreakPriceEntity copyWith({
    num? breakQty,
    num? breakPrice,
    String? breakPriceDisplay,
    String? savingsMessage,
    num? breakPriceWithVat,
    String? breakPriceWithVatDisplay,
  }) {
    return BreakPriceEntity(
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
