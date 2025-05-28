import 'models.dart';

part 'product_detail.g.dart';

@JsonSerializable(explicitToJson: true)
class ProductDetail {
  ProductDetail({
    this.allowAnyGiftCardAmount,
    this.canBackOrder,
    this.configuration,
    this.hasMsds,
    this.isGiftCard,
    this.isHazardousGood,
    this.isSpecialOrder,
    this.modelNumber,
    this.multipleSaleQty,
    this.name,
    this.priceCode,
    this.productCode,
    this.replacementProductId,
    this.roundingRule,
    this.shippingClassification,
    this.shippingHeight,
    this.shippingLength,
    this.shippingWeight,
    this.shippingWidth,
    this.sku,
    this.sortOrder,
    this.taxCategory,
    this.taxCode1,
    this.taxCode2,
    this.unspsc,
    this.upcCode,
    this.vatCodeId,
  });

  String? name;

  String? modelNumber;

  String? sku;

  String? upcCode;

  String? unspsc;

  String? productCode;

  String? priceCode;

  int? sortOrder;

  int? multipleSaleQty;

  bool? canBackOrder;

  String? roundingRule;

  String? replacementProductId;

  bool? isHazardousGood;

  bool? hasMsds;

  bool? isSpecialOrder;

  bool? isGiftCard;

  bool? allowAnyGiftCardAmount;

  String? taxCode1;

  String? taxCode2;

  String? taxCategory;

  String? vatCodeId;

  String? shippingClassification;

  num? shippingLength;

  num? shippingWidth;

  num? shippingHeight;

  num? shippingWeight;

  LegacyConfiguration? configuration;

  factory ProductDetail.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailFromJson(json);
  Map<String, dynamic> toJson() => _$ProductDetailToJson(this);
}
