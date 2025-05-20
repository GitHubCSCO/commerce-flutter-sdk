enum StockAvailability {
  inOfStock(1),
  outOfStock(2),
  lowStock(3);

  final int value;
  const StockAvailability(this.value);
}

enum ProcessedType {
  search(1),
  scan(2),
  newCount(3);

  final int value;
  const ProcessedType(this.value);
}
