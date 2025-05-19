import 'models.dart';

part 'attribute_value.g.dart';

@JsonSerializable(explicitToJson: true)
class AttributeValue {
  AttributeValue({
    this.attributeValueId,
    this.count,
    this.id,
    this.isActive,
    this.selected,
    this.sortOrder,
    this.value,
    this.valueDisplay,
  });

  String? attributeValueId;

  String? value;

  String? valueDisplay;

  int? sortOrder;

  bool? isActive;

  // for V2
  String? id;

  int? count;

  bool? selected;

  factory AttributeValue.fromJson(Map<String, dynamic> json) =>
      _$AttributeValueFromJson(json);
  Map<String, dynamic> toJson() => _$AttributeValueToJson(this);
}
