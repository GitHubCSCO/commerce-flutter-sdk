import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'quick_order_item.g.dart'; // This will be the generated file

@JsonSerializable(explicitToJson: true)
class QuickOrderItem {
  final Product product;
  final ProductUnitOfMeasure? selectedUnitOfMeasure;
  final VmiBinModel? vmiBinModel;
  final int? quantityOrdered;
  final String? selectedUnitOfMeasureTitle;
  final String? selectedUnitOfMeasureValueText;

  QuickOrderItem(
    this.product, {
    this.selectedUnitOfMeasure,
    this.vmiBinModel,
    this.quantityOrdered,
    this.selectedUnitOfMeasureTitle,
    this.selectedUnitOfMeasureValueText,
  });

  factory QuickOrderItem.fromJson(Map<String, dynamic> json) =>
      _$QuickOrderItemFromJson(json);

  Map<String, dynamic> toJson() => _$QuickOrderItemToJson(this);

  QuickOrderItem copyWith({
    Product? product,
    ProductUnitOfMeasure? selectedUnitOfMeasure,
    VmiBinModel? vmiBinModel,
    int? quantityOrdered,
    String? selectedUnitOfMeasureTitle,
    String? selectedUnitOfMeasureValueText,
  }) {
    return QuickOrderItem(
      product ?? this.product,
      selectedUnitOfMeasure:
          selectedUnitOfMeasure ?? this.selectedUnitOfMeasure,
      vmiBinModel: vmiBinModel ?? this.vmiBinModel,
      quantityOrdered: quantityOrdered ?? this.quantityOrdered,
      selectedUnitOfMeasureTitle:
          selectedUnitOfMeasureTitle ?? this.selectedUnitOfMeasureTitle,
      selectedUnitOfMeasureValueText:
          selectedUnitOfMeasureValueText ?? this.selectedUnitOfMeasureValueText,
    );
  }
}
