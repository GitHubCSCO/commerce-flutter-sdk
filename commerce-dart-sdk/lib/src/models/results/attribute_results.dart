import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'attribute_results.g.dart';

@JsonSerializable()
class AttributeResults {
  List<AutocompleteCategory>? categories;
  List<AutocompleteBrand>? brands;

  AttributeResults({
    this.categories,
    this.brands,
  });

  factory AttributeResults.fromJson(Map<String, dynamic> json) =>
      _$AttributeResultsFromJson(json);

  Map<String, dynamic> toJson() => _$AttributeResultsToJson(this);
}
