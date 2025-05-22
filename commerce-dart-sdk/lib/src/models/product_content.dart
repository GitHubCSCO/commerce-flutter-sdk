import 'models.dart';

part 'product_content.g.dart';

@JsonSerializable(explicitToJson: true)
class ProductContent {
  ProductContent({
    this.htmlContent,
    this.metaDescription,
    this.pageTitle,
    this.metaKeywords,
    this.openGraphImage,
    this.openGraphTitle,
    this.openGraphUrl,
  });

  String? htmlContent;

  String? pageTitle;

  String? metaDescription;

  String? metaKeywords;

  String? openGraphTitle;

  String? openGraphUrl;

  String? openGraphImage;

  factory ProductContent.fromJson(Map<String, dynamic> json) =>
      _$ProductContentFromJson(json);
  Map<String, dynamic> toJson() => _$ProductContentToJson(this);
}
