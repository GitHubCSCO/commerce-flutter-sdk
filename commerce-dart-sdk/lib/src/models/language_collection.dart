import 'models.dart';

part 'language_collection.g.dart';

@JsonSerializable()
class LanguageCollection extends BaseModel {
  List<Language>? languages;

  LanguageCollection({this.languages});

  factory LanguageCollection.fromJson(Map<String, dynamic> json) =>
      _$LanguageCollectionFromJson(json);

  Map<String, dynamic> toJson() => _$LanguageCollectionToJson(this);
}
