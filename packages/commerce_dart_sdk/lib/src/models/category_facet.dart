import 'models.dart';

part 'category_facet.g.dart';

@JsonSerializable()
class CategoryFacet {
  String? categoryId;

  String? websiteId;

  String? shortDescription;

  int? count;

  bool? selected;

  List<CategoryFacet>? subCategoryDtos;

  CategoryFacet({
    this.categoryId,
    this.websiteId,
    this.shortDescription,
    this.count,
    this.selected,
    this.subCategoryDtos,
  });

  factory CategoryFacet.fromJson(Map<String, dynamic> json) =>
      _$CategoryFacetFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryFacetToJson(this);
}
