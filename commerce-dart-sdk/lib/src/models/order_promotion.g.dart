// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_promotion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderPromotion _$OrderPromotionFromJson(Map<String, dynamic> json) =>
    OrderPromotion(
      id: json['id'] as String?,
      amount: json['amount'] as num?,
      amountDisplay: json['amountDisplay'] as String?,
      name: json['name'] as String?,
      orderHistoryLineId: json['orderHistoryLineId'] as String?,
      promotionResultType: json['promotionResultType'] as String?,
    );

Map<String, dynamic> _$OrderPromotionToJson(OrderPromotion instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('amount', instance.amount);
  writeNotNull('amountDisplay', instance.amountDisplay);
  writeNotNull('name', instance.name);
  writeNotNull('orderHistoryLineId', instance.orderHistoryLineId);
  writeNotNull('promotionResultType', instance.promotionResultType);
  return val;
}
