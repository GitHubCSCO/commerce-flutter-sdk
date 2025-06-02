import 'models.dart';

part 'brand_product_line.g.dart';

@JsonSerializable()
class BrandProductLine extends BaseModel {
  String? id;

  String? name;

  int? sortOrder;

  String? productListPagePath;

  String? featuredImagePath;

  String? featuredImageAltText;

  bool? isFeatured;

  bool? isSponsored;

  @JsonKey(includeFromJson: false, includeToJson: false)
  bool? isLoading;

  BrandProductLine({
    this.id,
    this.name,
    this.sortOrder,
    this.productListPagePath,
    this.featuredImagePath,
    this.featuredImageAltText,
    this.isFeatured,
    this.isSponsored,
    this.isLoading,
  });

  factory BrandProductLine.fromJson(Map<String, dynamic> json) =>
      _$BrandProductLineFromJson(json);

  Map<String, dynamic> toJson() => _$BrandProductLineToJson(this);
}
