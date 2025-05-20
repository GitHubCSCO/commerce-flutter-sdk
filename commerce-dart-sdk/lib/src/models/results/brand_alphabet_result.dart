import '../models.dart';

part 'brand_alphabet_result.g.dart';

@JsonSerializable()
class BrandAlphabetResult extends BaseModel {
  List<BrandAlphabet>? alphabet;

  BrandAlphabetResult({this.alphabet});

  factory BrandAlphabetResult.fromJson(Map<String, dynamic> json) =>
      _$BrandAlphabetResultFromJson(json);

  Map<String, dynamic> toJson() => _$BrandAlphabetResultToJson(this);
}
