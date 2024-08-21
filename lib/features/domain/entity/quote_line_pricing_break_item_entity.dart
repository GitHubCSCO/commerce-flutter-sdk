import 'package:equatable/equatable.dart';

class QuoteLinePricingBreakItemEntity extends Equatable {
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
  
  @override
  List<Object?> get props => [
    startQuantity,
    startQuantityDisplay,
    endQuantity,
    endQuantityDisplay,
    price,
    priceDisplay,
    endQuantityEnabled,
    deletionEnabled,
    id,
  ];

  QuoteLinePricingBreakItemEntity copyWith({
    num? startQuantity,
    String? startQuantityDisplay,
    num? endQuantity,
    String? endQuantityDisplay,
    num? price,
    String? priceDisplay,
    bool? endQuantityEnabled,
    bool? deletionEnabled,
    int? id,
  }) {
    return QuoteLinePricingBreakItemEntity(
      startQuantity: startQuantity ?? this.startQuantity,
      startQuantityDisplay: startQuantityDisplay ?? this.startQuantityDisplay,
      endQuantity: endQuantity ?? this.endQuantity,
      endQuantityDisplay: endQuantityDisplay ?? this.endQuantityDisplay,
      price: price ?? this.price,
      priceDisplay: priceDisplay ?? this.priceDisplay,
      endQuantityEnabled: endQuantityEnabled ?? this.endQuantityEnabled,
      deletionEnabled: deletionEnabled ?? this.deletionEnabled,
      id: id ?? this.id,
    );
  }
}
