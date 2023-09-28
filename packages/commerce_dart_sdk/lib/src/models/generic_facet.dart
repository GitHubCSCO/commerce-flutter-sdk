import 'models.dart';

part 'generic_facet.g.dart';

@JsonSerializable()
class GenericFacet {
  String? id;

  String? name;

  int? count;

  bool? selected;

  GenericFacet({
    this.id,
    this.name,
    this.count,
    this.selected,
  });

  factory GenericFacet.fromJson(Map<String, dynamic> json) =>
      _$GenericFacetFromJson(json);
  Map<String, dynamic> toJson() => _$GenericFacetToJson(this);
}
