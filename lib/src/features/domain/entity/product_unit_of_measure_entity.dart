// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class ProductUnitOfMeasureEntity extends Equatable {
  final String? productUnitOfMeasureId;
  final String? unitOfMeasure;
  final String? unitOfMeasureDisplay;
  final String? description;
  final double? qtyPerBaseUnitOfMeasure;
  final String? roundingRule;
  final bool? isDefault;
  final String? unitOfMeasureTextDisplayWithQuantity;

  const ProductUnitOfMeasureEntity({
    this.productUnitOfMeasureId,
    this.unitOfMeasure,
    this.unitOfMeasureDisplay,
    this.description,
    this.qtyPerBaseUnitOfMeasure,
    this.roundingRule,
    this.isDefault,
    this.unitOfMeasureTextDisplayWithQuantity,
  });

  ProductUnitOfMeasureEntity copyWith({
    String? productUnitOfMeasureId,
    String? unitOfMeasure,
    String? unitOfMeasureDisplay,
    String? description,
    double? qtyPerBaseUnitOfMeasure,
    String? roundingRule,
    bool? isDefault,
    String? unitOfMeasureTextDisplayWithQuantity,
  }) {
    return ProductUnitOfMeasureEntity(
      productUnitOfMeasureId:
          productUnitOfMeasureId ?? this.productUnitOfMeasureId,
      unitOfMeasure: unitOfMeasure ?? this.unitOfMeasure,
      unitOfMeasureDisplay: unitOfMeasureDisplay ?? this.unitOfMeasureDisplay,
      description: description ?? this.description,
      qtyPerBaseUnitOfMeasure:
          qtyPerBaseUnitOfMeasure ?? this.qtyPerBaseUnitOfMeasure,
      roundingRule: roundingRule ?? this.roundingRule,
      isDefault: isDefault ?? this.isDefault,
      unitOfMeasureTextDisplayWithQuantity:
          unitOfMeasureTextDisplayWithQuantity ??
              this.unitOfMeasureTextDisplayWithQuantity,
    );
  }

  @override
  List<Object?> get props => [
        productUnitOfMeasureId,
        unitOfMeasure,
        unitOfMeasureDisplay,
        description,
        qtyPerBaseUnitOfMeasure,
        roundingRule,
        isDefault,
        unitOfMeasureTextDisplayWithQuantity,
      ];
}
