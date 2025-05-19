import 'models.dart';

part 'suggestion_dto.g.dart';

@JsonSerializable()
class SuggestionDto {
  String? highlightedSuggestion;

  double? score;

  String? suggestion;

  SuggestionDto({
    this.highlightedSuggestion,
    this.score,
    this.suggestion,
  });

  factory SuggestionDto.fromJson(Map<String, dynamic> json) =>
      _$SuggestionDtoFromJson(json);
  Map<String, dynamic> toJson() => _$SuggestionDtoToJson(this);
}
