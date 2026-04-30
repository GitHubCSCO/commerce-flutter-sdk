import 'models.dart';

part 'brand.g.dart';

@JsonSerializable(explicitToJson: true)
class Brand extends BaseModel {
  Brand({
    this.detailPagePath,
    this.id,
    this.logoImageAltText,
    this.logoLargeImagePath,
    this.logoSmallImagePath,
    this.name,
    this.urlSegment,
  });

  String? id;

  String? name;

  String? urlSegment;

  String? logoSmallImagePath;

  String? logoLargeImagePath;

  String? logoImageAltText;

  String? detailPagePath;

  factory Brand.fromJson(Map<String, dynamic> json) {
    final brand = _$BrandFromJson(json);
    brand.logoImageAltText ??= json['logoAltText'] as String?;
    return brand;
  }
  Map<String, dynamic> toJson() => _$BrandToJson(this);
}

@JsonSerializable(explicitToJson: true)
class BrandAlphabet {
  BrandAlphabet({this.count, this.letter});

  String? letter;

  int? count;

  factory BrandAlphabet.fromJson(Map<String, dynamic> json) =>
      _$BrandAlphabetFromJson(json);
  Map<String, dynamic> toJson() => _$BrandAlphabetToJson(this);
}
