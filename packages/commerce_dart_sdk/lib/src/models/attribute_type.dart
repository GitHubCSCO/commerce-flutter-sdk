import 'models.dart';

part 'attribute_type.g.dart';

@JsonSerializable(explicitToJson: true)
class AttributeType {
  AttributeType({
    this.attributeTypeId,
    this.attributeValueFacets,
    this.attributeValues,
    this.id,
    this.isActive,
    this.isComparable,
    this.isFilter,
    this.label,
    this.name,
    this.nameDisplay,
    this.sort,
    this.sortOrder,
  });

  String? attributeTypeId;

  String? name;

  String? nameDisplay;

  int? sort;

  List<AttributeValue>? attributeValueFacets;

  // for V2
  String? id;

  String? label;

  bool? isFilter;

  bool? isComparable;

  bool? isActive;

  int? sortOrder;

  List<AttributeValue>? attributeValues;

  factory AttributeType.fromJson(Map<String, dynamic> json) =>
      _$AttributeTypeFromJson(json);
  Map<String, dynamic> toJson() => _$AttributeTypeToJson(this);
}
