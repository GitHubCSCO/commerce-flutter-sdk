import 'models.dart';

part 'category.g.dart';

/// Commerce API Category model.
@JsonSerializable()
class Category extends BaseModel {
  String? id;

  String? name;

  String? shortDescription;

  String? urlSegment;

  String? smallImagePath;

  String? largeImagePath;

  String? imageAltText;

  DateTime? activateOn;

  DateTime? deactivateOn;

  String? metaKeywords;

  String? metaDescription;

  String? htmlContent;

  int? sortOrder;

  bool? isFeatured;

  bool? isDynamic;

  List<Category>? subCategories;

  String? path;

  /// Hero image on mobile category pages
  String? mobileBannerImageUrl;

  /// Large text on mobile category pages

  String? mobilePrimaryText;

  /// Small text on mobile category pages
  String? mobileSecondaryText;

  String? mobileTextJustification;

  String? mobileTextColor;

  Category({
    this.id,
    this.name,
    this.shortDescription,
    this.urlSegment,
    this.smallImagePath,
    this.largeImagePath,
    this.imageAltText,
    this.activateOn,
    this.deactivateOn,
    this.metaKeywords,
    this.metaDescription,
    this.htmlContent,
    this.sortOrder,
    this.isFeatured,
    this.isDynamic,
    this.subCategories,
    this.path,
    this.mobileBannerImageUrl,
    this.mobilePrimaryText,
    this.mobileSecondaryText,
    this.mobileTextJustification,
    this.mobileTextColor,
  });

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
