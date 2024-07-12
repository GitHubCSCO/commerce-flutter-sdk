import 'package:equatable/equatable.dart';

import 'package:commerce_flutter_app/features/domain/entity/availability_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/brand.dart';
import 'package:commerce_flutter_app/features/domain/entity/break_price_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_price_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_unit_of_measure_entity.dart';

class WishListLineEntity extends Equatable {
  final String? id;
  final String? productUri;
  final String? productId;
  final String? smallImagePath;
  final String? altText;
  final String? productName;
  final String? manufacturerItem;
  final String? customerName;
  final String? shortDescription;
  final num? qtyOnHand;
  final num? qtyOrdered;
  final String? erpNumber;
  final ProductPriceEntity? pricing;
  final bool? quoteRequired;
  final bool? isActive;
  final bool? canEnterQuantity;
  final bool? canShowPrice;
  final bool? canAddToCart;
  final bool? canShowUnitOfMeasure;
  final bool? canBackOrder;
  final bool? trackInventory;
  final AvailabilityEntity? availability;
  final List<BreakPriceDTOEntity>? breakPrices;
  final String? unitOfMeasure;
  final String? unitOfMeasureDisplay;
  final String? unitOfMeasureDescription;
  final String? baseUnitOfMeasure;
  final String? baseUnitOfMeasureDisplay;
  final num? qtyPerBaseUnitOfMeasure;
  final String? selectedUnitOfMeasure;
  final List<ProductUnitOfMeasureEntity>? productUnitOfMeasures;
  final String? packDescription;
  final DateTime? createdOn;
  final String? notes;
  final String? createdByDisplayName;
  final bool? isSharedLine;
  final bool? isVisible;
  final bool? isDiscontinued;
  final int? sortOrder;
  final BrandEntity? brand;
  final bool? isQtyAdjusted;
  final bool? allowZeroPricing;

  const WishListLineEntity({
    this.id,
    this.productUri,
    this.productId,
    this.smallImagePath,
    this.altText,
    this.productName,
    this.manufacturerItem,
    this.customerName,
    this.shortDescription,
    this.qtyOnHand,
    this.qtyOrdered,
    this.erpNumber,
    this.pricing,
    this.quoteRequired,
    this.isActive,
    this.canEnterQuantity,
    this.canShowPrice,
    this.canAddToCart,
    this.canShowUnitOfMeasure,
    this.canBackOrder,
    this.trackInventory,
    this.availability,
    this.breakPrices,
    this.unitOfMeasure,
    this.unitOfMeasureDisplay,
    this.unitOfMeasureDescription,
    this.baseUnitOfMeasure,
    this.baseUnitOfMeasureDisplay,
    this.qtyPerBaseUnitOfMeasure,
    this.selectedUnitOfMeasure,
    this.productUnitOfMeasures,
    this.packDescription,
    this.createdOn,
    this.notes,
    this.createdByDisplayName,
    this.isSharedLine,
    this.isVisible,
    this.isDiscontinued,
    this.sortOrder,
    this.brand,
    this.isQtyAdjusted,
    this.allowZeroPricing,
  });

  @override
  List<Object?> get props => [
        id,
        productUri,
        productId,
        smallImagePath,
        altText,
        productName,
        manufacturerItem,
        customerName,
        shortDescription,
        qtyOnHand,
        qtyOrdered,
        erpNumber,
        pricing,
        quoteRequired,
        isActive,
        canEnterQuantity,
        canShowPrice,
        canAddToCart,
        canShowUnitOfMeasure,
        canBackOrder,
        trackInventory,
        availability,
        breakPrices,
        unitOfMeasure,
        unitOfMeasureDisplay,
        unitOfMeasureDescription,
        baseUnitOfMeasure,
        baseUnitOfMeasureDisplay,
        qtyPerBaseUnitOfMeasure,
        selectedUnitOfMeasure,
        productUnitOfMeasures,
        packDescription,
        createdOn,
        notes,
        createdByDisplayName,
        isSharedLine,
        isVisible,
        isDiscontinued,
        sortOrder,
        brand,
        isQtyAdjusted,
        allowZeroPricing,
      ];

  WishListLineEntity copyWith({
    String? id,
    String? productUri,
    String? productId,
    String? smallImagePath,
    String? altText,
    String? productName,
    String? manufacturerItem,
    String? customerName,
    String? shortDescription,
    num? qtyOnHand,
    num? qtyOrdered,
    String? erpNumber,
    ProductPriceEntity? pricing,
    bool? quoteRequired,
    bool? isActive,
    bool? canEnterQuantity,
    bool? canShowPrice,
    bool? canAddToCart,
    bool? canShowUnitOfMeasure,
    bool? canBackOrder,
    bool? trackInventory,
    AvailabilityEntity? availability,
    List<BreakPriceDTOEntity>? breakPrices,
    String? unitOfMeasure,
    String? unitOfMeasureDisplay,
    String? unitOfMeasureDescription,
    String? baseUnitOfMeasure,
    String? baseUnitOfMeasureDisplay,
    num? qtyPerBaseUnitOfMeasure,
    String? selectedUnitOfMeasure,
    List<ProductUnitOfMeasureEntity>? productUnitOfMeasures,
    String? packDescription,
    DateTime? createdOn,
    String? notes,
    String? createdByDisplayName,
    bool? isSharedLine,
    bool? isVisible,
    bool? isDiscontinued,
    int? sortOrder,
    BrandEntity? brand,
    bool? isQtyAdjusted,
    bool? allowZeroPricing,
  }) {
    return WishListLineEntity(
      id: id ?? this.id,
      productUri: productUri ?? this.productUri,
      productId: productId ?? this.productId,
      smallImagePath: smallImagePath ?? this.smallImagePath,
      altText: altText ?? this.altText,
      productName: productName ?? this.productName,
      manufacturerItem: manufacturerItem ?? this.manufacturerItem,
      customerName: customerName ?? this.customerName,
      shortDescription: shortDescription ?? this.shortDescription,
      qtyOnHand: qtyOnHand ?? this.qtyOnHand,
      qtyOrdered: qtyOrdered ?? this.qtyOrdered,
      erpNumber: erpNumber ?? this.erpNumber,
      pricing: pricing ?? this.pricing,
      quoteRequired: quoteRequired ?? this.quoteRequired,
      isActive: isActive ?? this.isActive,
      canEnterQuantity: canEnterQuantity ?? this.canEnterQuantity,
      canShowPrice: canShowPrice ?? this.canShowPrice,
      canAddToCart: canAddToCart ?? this.canAddToCart,
      canShowUnitOfMeasure: canShowUnitOfMeasure ?? this.canShowUnitOfMeasure,
      canBackOrder: canBackOrder ?? this.canBackOrder,
      trackInventory: trackInventory ?? this.trackInventory,
      availability: availability ?? this.availability,
      breakPrices: breakPrices ?? this.breakPrices,
      unitOfMeasure: unitOfMeasure ?? this.unitOfMeasure,
      unitOfMeasureDisplay: unitOfMeasureDisplay ?? this.unitOfMeasureDisplay,
      unitOfMeasureDescription:
          unitOfMeasureDescription ?? this.unitOfMeasureDescription,
      baseUnitOfMeasure: baseUnitOfMeasure ?? this.baseUnitOfMeasure,
      baseUnitOfMeasureDisplay:
          baseUnitOfMeasureDisplay ?? this.baseUnitOfMeasureDisplay,
      qtyPerBaseUnitOfMeasure:
          qtyPerBaseUnitOfMeasure ?? this.qtyPerBaseUnitOfMeasure,
      selectedUnitOfMeasure:
          selectedUnitOfMeasure ?? this.selectedUnitOfMeasure,
      productUnitOfMeasures:
          productUnitOfMeasures ?? this.productUnitOfMeasures,
      packDescription: packDescription ?? this.packDescription,
      createdOn: createdOn ?? this.createdOn,
      notes: notes ?? this.notes,
      createdByDisplayName: createdByDisplayName ?? this.createdByDisplayName,
      isSharedLine: isSharedLine ?? this.isSharedLine,
      isVisible: isVisible ?? this.isVisible,
      isDiscontinued: isDiscontinued ?? this.isDiscontinued,
      sortOrder: sortOrder ?? this.sortOrder,
      brand: brand ?? this.brand,
      isQtyAdjusted: isQtyAdjusted ?? this.isQtyAdjusted,
      allowZeroPricing: allowZeroPricing ?? this.allowZeroPricing,
    );
  }
}
