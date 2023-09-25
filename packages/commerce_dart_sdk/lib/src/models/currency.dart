import 'models.dart';

part 'currency.g.dart';

@JsonSerializable(explicitToJson: true)
class Currency extends BaseModel {
  Currency({
    this.currencyCode,
    this.currencySymbol,
    this.description,
    this.iD,
    this.isDefault,
  });

  String? iD;

  String? currencyCode;

  String? description;

  String? currencySymbol;

  bool? isDefault;

  factory Currency.fromJson(Map<String, dynamic> json) =>
      _$CurrencyFromJson(json);
  Map<String, dynamic> toJson() => _$CurrencyToJson(this);
}
