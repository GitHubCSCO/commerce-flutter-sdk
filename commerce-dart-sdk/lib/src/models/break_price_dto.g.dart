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

Map<String, dynamic> _$BreakPriceDtoToJson(BreakPriceDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('breakQty', instance.breakQty);
  writeNotNull('breakPrice', instance.breakPrice);
  writeNotNull('breakPriceDisplay', instance.breakPriceDisplay);
  writeNotNull('savingsMessage', instance.savingsMessage);
  writeNotNull('breakPriceWithVat', instance.breakPriceWithVat);
  writeNotNull('breakPriceWithVatDisplay', instance.breakPriceWithVatDisplay);
  return val;
}
