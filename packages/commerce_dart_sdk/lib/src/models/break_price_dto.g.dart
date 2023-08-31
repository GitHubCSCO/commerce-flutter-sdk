// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'break_price_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BreakPriceDto _$BreakPriceDtoFromJson(Map<String, dynamic> json) =>
    BreakPriceDto(
      breakPrice: json['breakPrice'] as num?,
      breakPriceDisplay: json['breakPriceDisplay'] as String?,
      breakPriceWithVat: json['breakPriceWithVat'] as num?,
      breakPriceWithVatDisplay: json['breakPriceWithVatDisplay'] as String?,
      breakQty: json['breakQty'] as num?,
      savingsMessage: json['savingsMessage'] as String?,
    );

Map<String, dynamic> _$BreakPriceDtoToJson(BreakPriceDto instance) =>
    <String, dynamic>{
      'breakQty': instance.breakQty,
      'breakPrice': instance.breakPrice,
      'breakPriceDisplay': instance.breakPriceDisplay,
      'savingsMessage': instance.savingsMessage,
      'breakPriceWithVat': instance.breakPriceWithVat,
      'breakPriceWithVatDisplay': instance.breakPriceWithVatDisplay,
    };
