class QuoteLinePricingBreakItemEntity {
  num? startQuantity;
  String? startQuantityDisplay;
  num? endQuantity;
  String? endQuantityDisplay;
  num? price;
  String? priceDisplay;
  bool? endQuantityEnabled;
  bool? deletionEnabled;
  int id;
  QuoteLinePricingBreakItemEntity({
     this.startQuantity,
     this.startQuantityDisplay,
     this.endQuantity,
     this.endQuantityDisplay,
     this.price,
     this.priceDisplay,
     this.endQuantityEnabled,
    this.deletionEnabled,
    required this.id,
  });
}
