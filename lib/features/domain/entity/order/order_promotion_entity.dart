import 'package:equatable/equatable.dart';

class OrderPromotionEntity extends Equatable {
  final String? id;
  final num? amount;
  final String? amountDisplay;
  final String? name;
  final String? orderHistoryLineId;
  final String? promotionResultType;

  const OrderPromotionEntity({
    this.id,
    this.amount,
    this.amountDisplay,
    this.name,
    this.orderHistoryLineId,
    this.promotionResultType,
  });

  @override
  List<Object?> get props => [
        id,
        amount,
        amountDisplay,
        name,
        orderHistoryLineId,
        promotionResultType,
      ];

  OrderPromotionEntity copyWith({
    String? id,
    num? amount,
    String? amountDisplay,
    String? name,
    String? orderHistoryLineId,
    String? promotionResultType,
  }) {
    return OrderPromotionEntity(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      amountDisplay: amountDisplay ?? this.amountDisplay,
      name: name ?? this.name,
      orderHistoryLineId: orderHistoryLineId ?? this.orderHistoryLineId,
      promotionResultType: promotionResultType ?? this.promotionResultType,
    );
  }
}
