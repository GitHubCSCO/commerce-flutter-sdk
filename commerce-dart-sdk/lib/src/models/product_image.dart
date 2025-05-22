import 'models.dart';

part 'product_image.g.dart';

@JsonSerializable(explicitToJson: true)
class ProductImage {
  ProductImage({
    this.altText,
    this.id,
    this.imageType,
    this.largeImagePath,
    this.mediumImagePath,
    this.name,
    this.smallImagePath,
    this.sortOrder,
  });

  String? id;

  int? sortOrder;

  String? name;

  String? smallImagePath;

  String? mediumImagePath;

  String? largeImagePath;

  String? altText;

  String? imageType;

  factory ProductImage.fromJson(Map<String, dynamic> json) =>
      _$ProductImageFromJson(json);
  Map<String, dynamic> toJson() => _$ProductImageToJson(this);
}
