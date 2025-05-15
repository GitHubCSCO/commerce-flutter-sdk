import '../models.dart';

part 'category_result.g.dart';

@JsonSerializable()
class CategoryResult extends BaseModel {
  List<Category>? categories;

  CategoryResult({this.categories});

  factory CategoryResult.fromJson(Map<String, dynamic> json) =>
      _$CategoryResultFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryResultToJson(this);
}
