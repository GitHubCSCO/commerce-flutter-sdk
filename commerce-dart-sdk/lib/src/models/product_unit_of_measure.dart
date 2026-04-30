import 'models.dart';

part 'product_unit_of_measure.g.dart';

@JsonSerializable(explicitToJson: true)
class ProductUnitOfMeasure extends BaseModel {
  ProductUnitOfMeasure({
    this.description,
    this.id,
    this.isDefault,
    this.qtyPerBaseUnitOfMeasure,
    this.roundingRule,
    this.unitOfMeasure,
    this.unitOfMeasureDisplay,
  });

  String? id;

  String? unitOfMeasure;

  String? unitOfMeasureDisplay;

  String? description;

  double? qtyPerBaseUnitOfMeasure;

  String? roundingRule;

  bool? isDefault;

  factory ProductUnitOfMeasure.fromJson(Map<String, dynamic> json) {
    final uom = _$ProductUnitOfMeasureFromJson(json);
    uom.id ??= json['productUnitOfMeasureId'] as String?;
    return uom;
  }

  Map<String, dynamic> toJson() => _$ProductUnitOfMeasureToJson(this);
}
