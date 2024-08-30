import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'quick_order_item.g.dart'; // This will be the generated file

@JsonSerializable(explicitToJson: true)
class QuickOrderItem {
  final Product product;
  final ProductUnitOfMeasure? selectedUnitOfMeasure;
  final int? quantityOrdered;
  final String? selectedUnitOfMeasureTitle;
  final String? selectedUnitOfMeasureValueText;

  QuickOrderItem(
    this.product, {
    this.selectedUnitOfMeasure,
    this.quantityOrdered,
    this.selectedUnitOfMeasureTitle,
    this.selectedUnitOfMeasureValueText,
  });

  factory QuickOrderItem.fromJson(Map<String, dynamic> json) =>
      _$QuickOrderItemFromJson(json);

  Map<String, dynamic> toJson() => _$QuickOrderItemToJson(this);
}
