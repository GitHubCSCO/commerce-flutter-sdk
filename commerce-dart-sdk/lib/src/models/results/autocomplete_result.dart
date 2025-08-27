import 'package:optimizely_commerce_api/src/models/results/attribute_results.dart';

import '../models.dart';

part 'autocomplete_result.g.dart';

@JsonSerializable()
class AutocompleteResult extends BaseModel {
  List<AutocompleteProduct>? products;

  List<AutocompleteBrand>? brands;

  List<AutocompleteCategory>? categories;

  AttributeResults? attributeResults;

  bool? isRetailSearchCompletionResults;

  AutocompleteResult({
    this.products,
    this.brands,
    this.categories,
    this.attributeResults,
    this.isRetailSearchCompletionResults,
  });

  factory AutocompleteResult.fromJson(Map<String, dynamic> json) =>
      _$AutocompleteResultFromJson(json);

  Map<String, dynamic> toJson() => _$AutocompleteResultToJson(this);
}
