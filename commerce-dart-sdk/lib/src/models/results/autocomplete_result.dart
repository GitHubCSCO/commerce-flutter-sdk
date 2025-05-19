import '../models.dart';

part 'autocomplete_result.g.dart';

@JsonSerializable()
class AutocompleteResult extends BaseModel {
  List<AutocompleteProduct>? products;

  List<AutocompleteBrand>? brands;

  List<AutocompleteCategory>? categories;

  AutocompleteResult({
    this.products,
    this.brands,
    this.categories,
  });

  factory AutocompleteResult.fromJson(Map<String, dynamic> json) =>
      _$AutocompleteResultFromJson(json);

  Map<String, dynamic> toJson() => _$AutocompleteResultToJson(this);
}
