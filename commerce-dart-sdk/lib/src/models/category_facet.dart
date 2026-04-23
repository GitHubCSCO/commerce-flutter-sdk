import 'models.dart';

part 'category_facet.g.dart';

@JsonSerializable()
class CategoryFacet {
  String? categoryId;

  String? shortDescription;

  int? count;

  bool? selected;

  List<CategoryFacet>? subCategoryFacets;

  CategoryFacet({
    this.categoryId,
    this.shortDescription,
    this.count,
    this.selected,
    this.subCategoryFacets,
  });

  factory CategoryFacet.fromJson(Map<String, dynamic> json) =>
      _$CategoryFacetFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryFacetToJson(this);
}
