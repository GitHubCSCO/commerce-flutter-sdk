import 'models.dart';

part 'order_promotion.g.dart';

@JsonSerializable()
class OrderPromotion {
  /// Gets or sets the identifier.
  String? id;

  /// Gets or sets the amount.
  num? amount;

  /// Gets or sets the amount display.
  String? amountDisplay;

  /// Gets or sets the name.
  String? name;

  /// Gets or sets the order history line identifier.
  String? orderHistoryLineId;

  /// Gets or sets the promotion result type.
  String? promotionResultType;

  OrderPromotion({
    this.id,
    this.amount,
    this.amountDisplay,
    this.name,
    this.orderHistoryLineId,
    this.promotionResultType,
  });

  factory OrderPromotion.fromJson(Map<String, dynamic> json) =>
      _$OrderPromotionFromJson(json);

  Map<String, dynamic> toJson() => _$OrderPromotionToJson(this);
}
