import 'models.dart';

part 'catalog_page.g.dart';

@JsonSerializable()
class CatalogPage extends BaseModel {
  Category? category;

  String? brandId;

  String? productLineId;

  String? productId;

  String? productName;

  String? title;

  String? metaDescription;

  String? metaKeywords;

  String? canonicalPath;

  Map<String, String>? alternateLanguageUrls;

  bool? isReplacementProduct;

  List<BreadCrumb>? breadCrumbs;

  bool? obsoletePath;

  bool? needRedirect;

  String? redirectUrl;

  String? primaryImagePath;

  String? openGraphTitle;

  String? openGraphImage;

  String? openGraphUrl;

  CatalogPage({
    this.category,
    this.brandId,
    this.productLineId,
    this.productId,
    this.productName,
    this.title,
    this.metaDescription,
    this.metaKeywords,
    this.canonicalPath,
    this.alternateLanguageUrls,
    this.isReplacementProduct,
    this.breadCrumbs,
    this.obsoletePath,
    this.needRedirect,
    this.redirectUrl,
    this.primaryImagePath,
    this.openGraphTitle,
    this.openGraphImage,
    this.openGraphUrl,
  });

  factory CatalogPage.fromJson(Map<String, dynamic> json) =>
      _$CatalogPageFromJson(json);

  Map<String, dynamic> toJson() => _$CatalogPageToJson(this);
}
