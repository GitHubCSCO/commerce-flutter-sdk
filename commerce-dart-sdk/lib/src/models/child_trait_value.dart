import 'models.dart';

part 'child_trait_value.g.dart';

@JsonSerializable(explicitToJson: true)
class ChildTraitValue {
  ChildTraitValue({
    this.id,
    this.styleTraitId,
    this.value,
    this.valueDisplay,
  });

  String? id;

  String? styleTraitId;

  String? value;

  String? valueDisplay;

  factory ChildTraitValue.fromJson(Map<String, dynamic> json) =>
      _$ChildTraitValueFromJson(json);
  Map<String, dynamic> toJson() => _$ChildTraitValueToJson(this);
}
