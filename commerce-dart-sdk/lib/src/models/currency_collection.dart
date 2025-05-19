import 'models.dart';

part 'currency_collection.g.dart';

@JsonSerializable()
class CurrencyCollection extends BaseModel {
  List<Currency>? currencies;

  CurrencyCollection({this.currencies});

  factory CurrencyCollection.fromJson(Map<String, dynamic> json) =>
      _$CurrencyCollectionFromJson(json);

  Map<String, dynamic> toJson() => _$CurrencyCollectionToJson(this);
}
