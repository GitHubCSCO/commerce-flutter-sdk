import 'package:intl/intl.dart';
import 'models.dart';

part 'break_price_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class BreakPriceDto {
  BreakPriceDto({
    this.breakPrice,
    this.breakPriceDisplay,
    this.breakPriceWithVat,
    this.breakPriceWithVatDisplay,
    this.breakQty,
    this.savingsMessage,
  });

  num? breakQty;

  String? get breakQtyDisplay => NumberFormat('0.####').format(breakQty);

  num? breakPrice;

  String? breakPriceDisplay;

  String? savingsMessage;

  num? breakPriceWithVat;

  String? breakPriceWithVatDisplay;

  factory BreakPriceDto.fromJson(Map<String, dynamic> json) =>
      _$BreakPriceDtoFromJson(json);
  Map<String, dynamic> toJson() => _$BreakPriceDtoToJson(this);
}
