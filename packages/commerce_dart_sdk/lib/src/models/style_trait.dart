import 'models.dart';

part 'style_trait.g.dart';

@JsonSerializable(explicitToJson: true)
class StyleTrait {
  StyleTrait({
    this.id,
    this.name,
    this.nameDisplay,
    this.sortOrder,
    this.styleTraitId,
    this.styleValues,
    this.traitValues,
    this.unselectedValue,
  });

  String? styleTraitId;

  String? name;

  String? nameDisplay;

  String? unselectedValue;

  int? sortOrder;

  List<StyleValue>? styleValues;

  // for V2
  String? id;

  List<StyleValue>? traitValues;

  factory StyleTrait.fromJson(Map<String, dynamic> json) =>
      _$StyleTraitFromJson(json);
  Map<String, dynamic> toJson() => _$StyleTraitToJson(this);
}
