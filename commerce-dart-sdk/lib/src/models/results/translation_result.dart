import '../models.dart';

part 'translation_result.g.dart';

@JsonSerializable()
class TranslationResults extends BaseModel {
  List<TranslationDictionary>? translationDictionaries;

  Pagination? pagination;

  TranslationResults({
    this.translationDictionaries,
    this.pagination,
  });

  factory TranslationResults.fromJson(Map<String, dynamic> json) =>
      _$TranslationResultsFromJson(json);

  Map<String, dynamic> toJson() => _$TranslationResultsToJson(this);
}
