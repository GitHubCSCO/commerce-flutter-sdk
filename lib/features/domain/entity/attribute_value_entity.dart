// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class AttributeValueEntity extends Equatable {
  final String? attributeValueId;
  final String? value;
  final String? valueDisplay;
  final int? sortOrder;
  final bool? isActive;
  final String? id;
  final int? count;
  final bool? selected;

  const AttributeValueEntity({
    this.attributeValueId,
    this.count,
    this.id,
    this.isActive,
    this.selected,
    this.sortOrder,
    this.value,
    this.valueDisplay,
  });

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  AttributeValueEntity copyWith({
    String? attributeValueId,
    String? value,
    String? valueDisplay,
    int? sortOrder,
    bool? isActive,
    String? id,
    int? count,
    bool? selected,
  }) {
    return AttributeValueEntity(
      attributeValueId: attributeValueId ?? this.attributeValueId,
      value: value ?? this.value,
      valueDisplay: valueDisplay ?? this.valueDisplay,
      sortOrder: sortOrder ?? this.sortOrder,
      isActive: isActive ?? this.isActive,
      id: id ?? this.id,
      count: count ?? this.count,
      selected: selected ?? this.selected,
    );
  }
}
