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

Map<String, dynamic> _$AddPromotionToJson(AddPromotion instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uri', instance.uri);
  writeNotNull('properties', instance.properties);
  writeNotNull('promotionCode', instance.promotionCode);
  return val;
}

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
    PromotionCollectionModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uri', instance.uri);
  writeNotNull('properties', instance.properties);
  writeNotNull('promotionCode', instance.promotionCode);
  writeNotNull(
      'promotions', instance.promotions?.map((e) => e.toJson()).toList());
  return val;
}

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

Map<String, dynamic> _$PromotionToJson(Promotion instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uri', instance.uri);
  writeNotNull('properties', instance.properties);
  writeNotNull('id', instance.id);
  writeNotNull('promotionCode', instance.promotionCode);
  writeNotNull('name', instance.name);
  writeNotNull('amount', instance.amount);
  writeNotNull('amountDisplay', instance.amountDisplay);
  writeNotNull('promotionApplied', instance.promotionApplied);
  writeNotNull('message', instance.message);
  writeNotNull('orderLineId', instance.orderLineId);
  writeNotNull('promotionResultType', instance.promotionResultType);
  return val;
}
