// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:commerce_flutter_app/features/domain/entity/product_details/product_details_base_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/style_value_entity.dart';
import 'package:commerce_flutter_app/features/domain/usecases/porduct_details_usecase/product_details_usecase.dart';
import 'package:equatable/equatable.dart';

class ProductDetailsStyletraitsEntity extends ProductDetailsBaseEntity {
  final List<ProductDetailStyleTrait>? styleTraits;

  const ProductDetailsStyletraitsEntity(
      {this.styleTraits, required super.detailsSectionType});

  @override
  ProductDetailsStyletraitsEntity copyWith({
    List<ProductDetailStyleTrait>? styleTraits,
    ProdcutDeatilsPageWidgets? detailsSectionType,
  }) {
    return ProductDetailsStyletraitsEntity(
      detailsSectionType: detailsSectionType ?? super.detailsSectionType,
      styleTraits: this.styleTraits,
    );
  }
}

class ProductDetailStyleTrait extends Equatable {
  final String? styleTraitId;
  final String? styleTraitName;
  String? displayType;
  int? numberOfSwatchesVisible;
  bool? displayTextWithSwatch;
  final List<ProductDetailStyleValue>? styleValues;
  final ProductDetailStyleValue? selectedStyleValue;
  ProductDetailStyleTrait({
    this.styleTraitId,
    this.styleTraitName,
    this.styleValues,
    this.selectedStyleValue,
    this.displayTextWithSwatch,
    this.displayType,
    this.numberOfSwatchesVisible,
  });

  ProductDetailStyleTrait copyWith(
      {String? styleTraitName,
      List<ProductDetailStyleValue>? styleValues,
      ProductDetailStyleValue? selectedStyleValue,
      String? displayType,
      int? numberOfSwatchesVisible,
      String? styleTraitId,
      bool? displayTextWithSwatch}) {
    return ProductDetailStyleTrait(
      styleTraitName: styleTraitName ?? this.styleTraitName,
      styleValues: styleValues ?? this.styleValues,
      selectedStyleValue: selectedStyleValue ?? this.selectedStyleValue,
      displayType: displayType ?? this.displayType,
      numberOfSwatchesVisible:
          numberOfSwatchesVisible ?? this.numberOfSwatchesVisible,
      displayTextWithSwatch:
          displayTextWithSwatch ?? this.displayTextWithSwatch,
      styleTraitId: styleTraitId ?? this.styleTraitId,
    );
  }

  @override
  List<Object?> get props {
    return [
      styleTraitName,
      displayType,
      numberOfSwatchesVisible,
      displayTextWithSwatch,
      styleValues,
      selectedStyleValue
    ];
  }
}

class ProductDetailStyleValue extends Equatable {
  final StyleValueEntity? styleValue;
  final String? displayName;
  final bool? isAvailable;
  final bool? isSelected;
  ProductDetailStyleValue({
    this.styleValue,
    this.displayName,
    this.isAvailable,
    this.isSelected,
  });

  ProductDetailStyleValue copyWith({
    StyleValueEntity? styleValue,
    String? displayName,
    bool? isAvailable,
    bool? isSelected,
  }) {
    return ProductDetailStyleValue(
      styleValue: styleValue ?? this.styleValue,
      displayName: displayName ?? this.displayName,
      isAvailable: isAvailable ?? this.isAvailable,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  @override
  List<Object?> get props {
    return [styleValue, displayName, isAvailable, isSelected];
  }
}
