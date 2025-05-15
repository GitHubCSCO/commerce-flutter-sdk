import 'models.dart';

part 'style_value.g.dart';

@JsonSerializable(explicitToJson: true)
class StyleValue {
  StyleValue(
      {this.id,
      this.isDefault,
      this.sortOrder,
      this.styleTraitId,
      this.styleTraitName,
      this.styleTraitValueId,
      this.value,
      this.valueDisplay,
      this.swatchColorValue,
      this.swatchImageValue,
      this.swatchType});

  String? styleTraitName;

  String? styleTraitId;

  String? styleTraitValueId;

  String? value;

  String? valueDisplay;

  int? sortOrder;

  bool? isDefault;
  String? swatchColorValue;
  String? swatchImageValue;
  String? swatchType;

  // for V2
  String? id;

  factory StyleValue.fromJson(Map<String, dynamic> json) =>
      _$StyleValueFromJson(json);
  Map<String, dynamic> toJson() => _$StyleValueToJson(this);
}
