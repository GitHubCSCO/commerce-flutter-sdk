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

Map<String, dynamic> _$OrderPromotionToJson(OrderPromotion instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.amount case final value?) 'amount': value,
      if (instance.amountDisplay case final value?) 'amountDisplay': value,
      if (instance.name case final value?) 'name': value,
      if (instance.orderHistoryLineId case final value?)
        'orderHistoryLineId': value,
      if (instance.promotionResultType case final value?)
        'promotionResultType': value,
    };
