import 'models.dart';

part 'specification.g.dart';

@JsonSerializable(explicitToJson: true)
class Specification {
  Specification({
    this.description,
    this.htmlContent,
    this.id,
    this.name,
    this.nameDisplay,
    this.sortOrder,
    this.value,
  });

  String? id;

  String? name;

  String? nameDisplay;

  String? description;

  String? value;

  String? htmlContent;

  double? sortOrder;

  factory Specification.fromJson(Map<String, dynamic> json) =>
      _$SpecificationFromJson(json);
  Map<String, dynamic> toJson() => _$SpecificationToJson(this);
}
