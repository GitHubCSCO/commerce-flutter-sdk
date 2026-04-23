import 'models.dart';

part 'style_value.g.dart';

@JsonSerializable(explicitToJson: true)
class StyleValue {
  StyleValue({
    this.id,
    this.isDefault,
    this.sortOrder,
    this.swatchColorValue,
    this.swatchImageValue,
    this.swatchType,
    this.value,
    this.valueDisplay,
  });

  String? id;

  String? value;

  String? valueDisplay;

  int? sortOrder;

  bool? isDefault;

  String? swatchType;

  String? swatchImageValue;

  String? swatchColorValue;

  factory StyleValue.fromJson(Map<String, dynamic> json) =>
      _$StyleValueFromJson(json);
  Map<String, dynamic> toJson() => _$StyleValueToJson(this);
}
