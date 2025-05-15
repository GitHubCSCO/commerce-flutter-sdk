import 'models.dart';

part 'translation_dictionary.g.dart';

@JsonSerializable()
class TranslationDictionary extends BaseModel {
  String? keyword;

  String? source;

  String? translation;

  String? languageId;

  String? languageCode;

  TranslationDictionary({
    this.keyword,
    this.source,
    this.translation,
    this.languageId,
    this.languageCode,
  });

  factory TranslationDictionary.fromJson(Map<String, dynamic> json) =>
      _$TranslationDictionaryFromJson(json);

  Map<String, dynamic> toJson() => _$TranslationDictionaryToJson(this);
}
