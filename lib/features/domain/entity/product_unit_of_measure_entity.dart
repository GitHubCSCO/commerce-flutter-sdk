// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:commerce_flutter_app/features/domain/entity/availability_entity.dart';

class ProductUnitOfMeasureEntity extends Equatable {
  final String? productUnitOfMeasureId;
  final String? unitOfMeasure;
  final String? unitOfMeasureDisplay;
  final String? description;
  final double? qtyPerBaseUnitOfMeasure;
  final String? roundingRule;
  final bool? isDefault;
  final AvailabilityEntity? availability;

  const ProductUnitOfMeasureEntity({
    this.productUnitOfMeasureId,
    this.unitOfMeasure,
    this.unitOfMeasureDisplay,
    this.description,
    this.qtyPerBaseUnitOfMeasure,
    this.roundingRule,
    this.isDefault,
    this.availability,
  });

  ProductUnitOfMeasureEntity copyWith({
    String? productUnitOfMeasureId,
    String? unitOfMeasure,
    String? unitOfMeasureDisplay,
    String? description,
    double? qtyPerBaseUnitOfMeasure,
    String? roundingRule,
    bool? isDefault,
    AvailabilityEntity? availability,
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
      availability: availability ?? this.availability,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
