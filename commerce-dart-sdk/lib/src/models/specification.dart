import 'models.dart';

part 'specification.g.dart';

@JsonSerializable(explicitToJson: true)
class Specification {
  Specification({
    this.description,
    this.htmlContent,
    this.isActive,
    this.name,
    this.nameDisplay,
    this.parentSpecification,
    this.sortOrder,
    this.specificationId,
    this.specifications,
    this.value,
  });

  String? specificationId;

  String? name;

  String? nameDisplay;

  String? value;

  String? description;

  double? sortOrder;

  bool? isActive;

  Specification? parentSpecification;

  String? htmlContent;

  Specification? specifications;

  factory Specification.fromJson(Map<String, dynamic> json) =>
      _$SpecificationFromJson(json);
  Map<String, dynamic> toJson() => _$SpecificationToJson(this);
}
