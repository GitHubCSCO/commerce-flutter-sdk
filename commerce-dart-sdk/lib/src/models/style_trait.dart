import 'models.dart';

part 'style_trait.g.dart';

@JsonSerializable(explicitToJson: true)
class StyleTrait {
  StyleTrait({
    this.id,
    this.name,
    this.nameDisplay,
    this.unselectedValue,
    this.displayType,
    this.numberOfSwatchesVisible,
    this.displayTextWithSwatch,
    this.sortOrder,
    this.traitValues,
  });

  String? id;

  String? name;

  String? nameDisplay;

  String? unselectedValue;

  String? displayType;

  int? numberOfSwatchesVisible;

  bool? displayTextWithSwatch;

  int? sortOrder;

  List<StyleValue>? traitValues;

  factory StyleTrait.fromJson(Map<String, dynamic> json) =>
      _$StyleTraitFromJson(json);
  Map<String, dynamic> toJson() => _$StyleTraitToJson(this);
}
