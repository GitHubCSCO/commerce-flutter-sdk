// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:commerce_flutter_app/features/domain/entity/legacy_configuration_entity.dart';

class ProductDetailEntity extends Equatable {
  final String? name;
  final String? modelNumber;
  final String? sku;
  final String? upcCode;
  final String? unspsc;
  final String? productCode;
  final String? priceCode;
  final int? sortOrder;
  final int? multipleSaleQty;
  final bool? canBackOrder;
  final String? roundingRule;
  final String? replacementProductId;
  final bool? isHazardousGood;
  final bool? hasMsds;
  final bool? isSpecialOrder;
  final bool? isGiftCard;
  final bool? allowAnyGiftCardAmount;
  final String? taxCode1;
  final String? taxCode2;
  final String? taxCategory;
  final String? vatCodeId;
  final String? shippingClassification;
  final num? shippingLength;
  final num? shippingWidth;
  final num? shippingHeight;
  final num? shippingWeight;
  final LegacyConfigurationEntity? configuration;

  const ProductDetailEntity({
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

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  ProductDetailEntity copyWith({
    String? name,
    String? modelNumber,
    String? sku,
    String? upcCode,
    String? unspsc,
    String? productCode,
    String? priceCode,
    int? sortOrder,
    int? multipleSaleQty,
    bool? canBackOrder,
    String? roundingRule,
    String? replacementProductId,
    bool? isHazardousGood,
    bool? hasMsds,
    bool? isSpecialOrder,
    bool? isGiftCard,
    bool? allowAnyGiftCardAmount,
    String? taxCode1,
    String? taxCode2,
    String? taxCategory,
    String? vatCodeId,
    String? shippingClassification,
    num? shippingLength,
    num? shippingWidth,
    num? shippingHeight,
    num? shippingWeight,
    LegacyConfigurationEntity? configuration,
  }) {
    return ProductDetailEntity(
      name: name ?? this.name,
      modelNumber: modelNumber ?? this.modelNumber,
      sku: sku ?? this.sku,
      upcCode: upcCode ?? this.upcCode,
      unspsc: unspsc ?? this.unspsc,
      productCode: productCode ?? this.productCode,
      priceCode: priceCode ?? this.priceCode,
      sortOrder: sortOrder ?? this.sortOrder,
      multipleSaleQty: multipleSaleQty ?? this.multipleSaleQty,
      canBackOrder: canBackOrder ?? this.canBackOrder,
      roundingRule: roundingRule ?? this.roundingRule,
      replacementProductId: replacementProductId ?? this.replacementProductId,
      isHazardousGood: isHazardousGood ?? this.isHazardousGood,
      hasMsds: hasMsds ?? this.hasMsds,
      isSpecialOrder: isSpecialOrder ?? this.isSpecialOrder,
      isGiftCard: isGiftCard ?? this.isGiftCard,
      allowAnyGiftCardAmount:
          allowAnyGiftCardAmount ?? this.allowAnyGiftCardAmount,
      taxCode1: taxCode1 ?? this.taxCode1,
      taxCode2: taxCode2 ?? this.taxCode2,
      taxCategory: taxCategory ?? this.taxCategory,
      vatCodeId: vatCodeId ?? this.vatCodeId,
      shippingClassification:
          shippingClassification ?? this.shippingClassification,
      shippingLength: shippingLength ?? this.shippingLength,
      shippingWidth: shippingWidth ?? this.shippingWidth,
      shippingHeight: shippingHeight ?? this.shippingHeight,
      shippingWeight: shippingWeight ?? this.shippingWeight,
      configuration: configuration ?? this.configuration,
    );
  }
}
