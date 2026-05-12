import 'package:commerce_flutter_sdk/src/features/domain/entity/attribute_value_entity.dart';
import 'package:equatable/equatable.dart';

class AttributeTypeEntity extends Equatable {
  final String? attributeTypeId;
  final String? name;
  final String? nameDisplay;
  final int? sort;
  final List<AttributeValueEntity>? attributeValueFacets;
  final String? id;
  final String? label;
  final bool? isFilter;
  final bool? isComparable;
  final bool? includeOnProduct;
  final bool? isSearchable;
  final bool? isActive;
  final int? sortOrder;
  final List<AttributeValueEntity>? attributeValues;

  const AttributeTypeEntity({
    this.attributeTypeId,
    this.attributeValueFacets,
    this.attributeValues,
    this.id,
    this.includeOnProduct,
    this.isActive,
    this.isComparable,
    this.isFilter,
    this.isSearchable,
    this.label,
    this.name,
    this.nameDisplay,
    this.sort,
    this.sortOrder,
  });

  AttributeTypeEntity copyWith({
    String? attributeTypeId,
    String? name,
    String? nameDisplay,
    int? sort,
    List<AttributeValueEntity>? attributeValueFacets,
    String? id,
    String? label,
    bool? isFilter,
    bool? isComparable,
    bool? includeOnProduct,
    bool? isSearchable,
    bool? isActive,
    int? sortOrder,
    List<AttributeValueEntity>? attributeValues,
  }) {
    return AttributeTypeEntity(
      attributeTypeId: attributeTypeId ?? this.attributeTypeId,
      name: name ?? this.name,
      nameDisplay: nameDisplay ?? this.nameDisplay,
      sort: sort ?? this.sort,
      attributeValueFacets: attributeValueFacets ?? this.attributeValueFacets,
      id: id ?? this.id,
      label: label ?? this.label,
      isFilter: isFilter ?? this.isFilter,
      isComparable: isComparable ?? this.isComparable,
      includeOnProduct: includeOnProduct ?? this.includeOnProduct,
      isSearchable: isSearchable ?? this.isSearchable,
      isActive: isActive ?? this.isActive,
      sortOrder: sortOrder ?? this.sortOrder,
      attributeValues: attributeValues ?? this.attributeValues,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
