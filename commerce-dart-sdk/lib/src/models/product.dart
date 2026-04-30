import 'models.dart';

part 'product.g.dart';

@JsonSerializable(explicitToJson: true)
class Product extends BaseModel {
  Product({
    this.id,
    this.productNumber,
    this.customerProductNumber,
    this.customerUnitOfMeasure,
    this.productTitle,
    this.urlSegment,
    this.canonicalUrl,
    this.displayUrl,
    this.manufacturerItem,
    this.packDescription,
    this.unitListPrice,
    this.unitListPriceDisplay,
    this.priceFacet,
    this.smallImagePath,
    this.mediumImagePath,
    this.largeImagePath,
    this.imageAltText,
    this.isDiscontinued,
    this.quoteRequired,
    this.minimumOrderQty,
    this.isSponsored,
    this.trackInventory,
    this.configurationType,
    this.canConfigure,
    this.canAddToCart,
    this.canAddToWishlist,
    this.canShowPrice,
    this.canShowUnitOfMeasure,
    this.isVariantParent,
    this.variantTypeId,
    this.defaultChildProductId,
    this.salePriceLabel,
    this.cantBuy,
    this.allowZeroPricing,
    this.brand,
    this.productLine,
    this.unitOfMeasures,
    this.score,
    this.scoreExplanation,
    this.detail,
    this.content,
    this.images,
    this.badges,
    this.documents,
    this.specifications,
    this.warehouses,
    this.attributeTypes,
    this.variantTraits,
    this.childTraitValues,
  });

  String? id;

  String? productNumber;

  String? customerProductNumber;

  String? customerUnitOfMeasure;

  String? productTitle;

  String? urlSegment;

  String? canonicalUrl;

  String? displayUrl;

  String? manufacturerItem;

  String? packDescription;

  num? unitListPrice;

  String? unitListPriceDisplay;

  int? priceFacet;

  String? smallImagePath;

  String? mediumImagePath;

  String? largeImagePath;

  String? imageAltText;

  bool? isDiscontinued;

  bool? quoteRequired;

  int? minimumOrderQty;

  bool? isSponsored;

  bool? trackInventory;

  String? configurationType;

  bool? canConfigure;

  bool? canAddToCart;

  bool? canAddToWishlist;

  bool? canShowPrice;

  bool? canShowUnitOfMeasure;

  bool? isVariantParent;

  String? variantTypeId;

  String? defaultChildProductId;

  String? salePriceLabel;

  bool? cantBuy;

  bool? allowZeroPricing;

  Brand? brand;

  ProductLine? productLine;

  List<ProductUnitOfMeasure>? unitOfMeasures;

  double? score;

  ScoreExplanation? scoreExplanation;

  ProductDetail? detail;

  ProductContent? content;

  List<ProductImage>? images;

  List<Badge>? badges;

  List<Document>? documents;

  List<Specification>? specifications;

  List<InventoryWarehouse>? warehouses;

  List<AttributeType>? attributeTypes;

  List<StyleTrait>? variantTraits;

  List<ChildTraitValue>? childTraitValues;

  factory Product.fromJson(Map<String, dynamic> json) {
    final product = _$ProductFromJson(json);
    // V1 backward compatibility: some endpoints still return V1 field names
    product.productTitle ??= json['shortDescription'] as String?;
    product.productNumber ??= json['erpNumber'] as String?;
    product.imageAltText ??= json['altText'] as String?;
    product.isVariantParent ??= json['isStyleProductParent'] as bool?;
    product.images ??= (json['productImages'] as List<dynamic>?)
        ?.map((e) => ProductImage.fromJson(e as Map<String, dynamic>))
        .toList();
    product.unitOfMeasures ??= (json['productUnitOfMeasures'] as List<dynamic>?)
        ?.map((e) => ProductUnitOfMeasure.fromJson(e as Map<String, dynamic>))
        .toList();
    product.variantTraits ??= (json['styleTraits'] as List<dynamic>?)
        ?.map((e) => StyleTrait.fromJson(e as Map<String, dynamic>))
        .toList();
    return product;
  }

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
