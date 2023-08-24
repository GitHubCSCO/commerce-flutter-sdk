import 'models.dart';

part 'brand.g.dart';

@JsonSerializable(explicitToJson: true)
class Brand extends BaseModel {
  Brand({
    this.detailPagePath,
    this.externalUrl,
    this.featuredImageAltText,
    this.featuredImagePath,
    this.htmlContent,
    this.id,
    this.logoAltText,
    this.logoLargeImagePath,
    this.logoSmallImagePath,
    this.manufacturer,
    this.name,
    this.productListPagePage,
    this.topSellerProducts,
  });

  String? id;

  String? name;

  String? manufacturer;

  String? externalUrl;

  String? detailPagePath;

  String? productListPagePage;

  String? logoSmallImagePath;

  String? logoLargeImagePath;

  String? logoAltText;

  String? featuredImagePath;

  String? featuredImageAltText;

  String? htmlContent;

  List<Product>? topSellerProducts;

  factory Brand.fromJson(Map<String, dynamic> json) => _$BrandFromJson(json);
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
