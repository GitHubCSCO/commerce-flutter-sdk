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
      if (instance.breakQty case final value?) 'breakQty': value,
      if (instance.breakPrice case final value?) 'breakPrice': value,
      if (instance.breakPriceDisplay case final value?)
        'breakPriceDisplay': value,
      if (instance.savingsMessage case final value?) 'savingsMessage': value,
      if (instance.breakPriceWithVat case final value?)
        'breakPriceWithVat': value,
      if (instance.breakPriceWithVatDisplay case final value?)
        'breakPriceWithVatDisplay': value,
    };
