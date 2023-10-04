import 'models.dart';

part 'language.g.dart';

@JsonSerializable(explicitToJson: true)
class Language extends BaseModel {
  Language({
    this.cultureCode,
    this.description,
    this.id,
    this.imageFilePath,
    this.isDefault,
    this.isLive,
    this.isSelected,
    this.languageCode,
  });

  /// Gets or sets the identifier.
  String? id;

  /// Gets or sets the language code.
  String? languageCode;

  /// Gets or sets the culture code.
  String? cultureCode;

  /// Gets or sets the description.
  String? description;

  /// Gets or sets the image file path.
  String? imageFilePath;

  /// Gets or sets a value indicating whether this instance is default.
  bool? isDefault;

  /// Gets or sets a value indicating whether this instance is enabled on this site.
  bool? isLive;

  @JsonKey(includeFromJson: false, includeToJson: false)
  bool? isSelected;

  factory Language.fromJson(Map<String, dynamic> json) =>
      _$LanguageFromJson(json);
  Map<String, dynamic> toJson() => _$LanguageToJson(this);
}
