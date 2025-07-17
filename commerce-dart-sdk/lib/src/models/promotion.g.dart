// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promotion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddPromotion _$AddPromotionFromJson(Map<String, dynamic> json) => AddPromotion(
      promotionCode: json['promotionCode'] as String?,
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$AddPromotionToJson(AddPromotion instance) =>
    <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.promotionCode case final value?) 'promotionCode': value,
    };

PromotionCollectionModel _$PromotionCollectionModelFromJson(
        Map<String, dynamic> json) =>
    PromotionCollectionModel(
      promotions: (json['promotions'] as List<dynamic>?)
          ?.map((e) => Promotion.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      )
      ..promotionCode = json['promotionCode'] as String?;

Map<String, dynamic> _$PromotionCollectionModelToJson(
        PromotionCollectionModel instance) =>
    <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.promotionCode case final value?) 'promotionCode': value,
      if (instance.promotions?.map((e) => e.toJson()).toList()
          case final value?)
        'promotions': value,
    };

Promotion _$PromotionFromJson(Map<String, dynamic> json) => Promotion(
      id: json['id'] as String?,
      promotionCode: json['promotionCode'] as String?,
      name: json['name'] as String?,
      amount: json['amount'] as num?,
      amountDisplay: json['amountDisplay'] as String?,
      promotionApplied: json['promotionApplied'] as bool?,
      message: json['message'] as String?,
      orderLineId: json['orderLineId'] as String?,
      promotionResultType: json['promotionResultType'] as String?,
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$PromotionToJson(Promotion instance) => <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.id case final value?) 'id': value,
      if (instance.promotionCode case final value?) 'promotionCode': value,
      if (instance.name case final value?) 'name': value,
      if (instance.amount case final value?) 'amount': value,
      if (instance.amountDisplay case final value?) 'amountDisplay': value,
      if (instance.promotionApplied case final value?)
        'promotionApplied': value,
      if (instance.message case final value?) 'message': value,
      if (instance.orderLineId case final value?) 'orderLineId': value,
      if (instance.promotionResultType case final value?)
        'promotionResultType': value,
    };
