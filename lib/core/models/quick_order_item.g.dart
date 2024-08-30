// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quick_order_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuickOrderItem _$QuickOrderItemFromJson(Map<String, dynamic> json) =>
    QuickOrderItem(
      Product.fromJson(json['product'] as Map<String, dynamic>),
      selectedUnitOfMeasure: json['selectedUnitOfMeasure'] == null
          ? null
          : ProductUnitOfMeasure.fromJson(
              json['selectedUnitOfMeasure'] as Map<String, dynamic>),
      quantityOrdered: (json['quantityOrdered'] as num?)?.toInt(),
      selectedUnitOfMeasureTitle: json['selectedUnitOfMeasureTitle'] as String?,
      selectedUnitOfMeasureValueText:
          json['selectedUnitOfMeasureValueText'] as String?,
    );

Map<String, dynamic> _$QuickOrderItemToJson(QuickOrderItem instance) =>
    <String, dynamic>{
      'product': instance.product.toJson(),
      'selectedUnitOfMeasure': instance.selectedUnitOfMeasure?.toJson(),
      'quantityOrdered': instance.quantityOrdered,
      'selectedUnitOfMeasureTitle': instance.selectedUnitOfMeasureTitle,
      'selectedUnitOfMeasureValueText': instance.selectedUnitOfMeasureValueText,
    };
