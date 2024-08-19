// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:commerce_flutter_app/features/domain/entity/availability_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_image_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_price_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_unit_of_measure_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/style_value_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/warehouse_entity.dart';
import 'package:equatable/equatable.dart';

class StyledProductEntity extends Equatable {
  final String? productId;
  final String? name;
  final String? shortDescription;
  final String? erpNumber;
  final String? mediumImagePath;
  final String? smallImagePath;
  final String? largeImagePath;
  final num? qtyOnHand;
  @Deprecated('This property is deprecated in the C# SDK')
  final num? numberInCart;
  final ProductPriceEntity? pricing;
  final bool? quoteRequired;
  final List<StyleValueEntity>? styleValues;
  final AvailabilityEntity? availability;
  final List<ProductUnitOfMeasureEntity>? productUnitOfMeasures;
  final List<ProductImageEntity>? productImages;
  final List<WarehouseEntity>? warehouses;
  final bool? trackInventory;

  const StyledProductEntity({
    this.availability,
    this.erpNumber,
    this.largeImagePath,
    this.mediumImagePath,
    this.name,
    this.numberInCart,
    this.pricing,
    this.productId,
    this.productImages,
    this.productUnitOfMeasures,
    this.qtyOnHand,
    this.quoteRequired,
    this.shortDescription,
    this.smallImagePath,
    this.styleValues,
    this.trackInventory,
    this.warehouses,
  });

  @override
  List<Object?> get props => [
        productId,
        name,
        shortDescription,
        erpNumber,
        mediumImagePath,
        smallImagePath,
        largeImagePath,
        qtyOnHand,
        numberInCart,
        pricing,
        quoteRequired,
        styleValues,
        availability,
        productUnitOfMeasures,
        productImages,
        warehouses,
        trackInventory,
      ];

  StyledProductEntity copyWith({
    String? productId,
    String? name,
    String? shortDescription,
    String? erpNumber,
    String? mediumImagePath,
    String? smallImagePath,
    String? largeImagePath,
    num? qtyOnHand,
    num? numberInCart,
    ProductPriceEntity? pricing,
    bool? quoteRequired,
    List<StyleValueEntity>? styleValues,
    AvailabilityEntity? availability,
    List<ProductUnitOfMeasureEntity>? productUnitOfMeasures,
    List<ProductImageEntity>? productImages,
    List<WarehouseEntity>? warehouses,
    bool? trackInventory,
  }) {
    return StyledProductEntity(
      productId: productId ?? this.productId,
      name: name ?? this.name,
      shortDescription: shortDescription ?? this.shortDescription,
      erpNumber: erpNumber ?? this.erpNumber,
      mediumImagePath: mediumImagePath ?? this.mediumImagePath,
      smallImagePath: smallImagePath ?? this.smallImagePath,
      largeImagePath: largeImagePath ?? this.largeImagePath,
      qtyOnHand: qtyOnHand ?? this.qtyOnHand,
      numberInCart: numberInCart ?? this.numberInCart,
      pricing: pricing ?? this.pricing,
      quoteRequired: quoteRequired ?? this.quoteRequired,
      styleValues: styleValues ?? this.styleValues,
      availability: availability ?? this.availability,
      productUnitOfMeasures:
          productUnitOfMeasures ?? this.productUnitOfMeasures,
      productImages: productImages ?? this.productImages,
      warehouses: warehouses ?? this.warehouses,
      trackInventory: trackInventory ?? this.trackInventory,
    );
  }
}
