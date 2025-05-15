import 'models.dart';

part 'product_unit_of_measure.g.dart';

@JsonSerializable(explicitToJson: true)
class ProductUnitOfMeasure extends BaseModel {
  ProductUnitOfMeasure({
    this.availability,
    this.description,
    this.isDefault,
    this.productUnitOfMeasureId,
    this.qtyPerBaseUnitOfMeasure,
    this.roundingRule,
    this.unitOfMeasure,
    this.unitOfMeasureDisplay,
  });

  String? productUnitOfMeasureId;

  String? unitOfMeasure;

  String? unitOfMeasureDisplay;

  String? description;

  double? qtyPerBaseUnitOfMeasure;

  String? roundingRule;

  bool? isDefault;

  Availability? availability;

  factory ProductUnitOfMeasure.fromJson(Map<String, dynamic> json) =>
      _$ProductUnitOfMeasureFromJson(json);
  Map<String, dynamic> toJson() => _$ProductUnitOfMeasureToJson(this);
}
