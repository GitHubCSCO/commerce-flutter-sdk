// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'suggestion_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SuggestionDto _$SuggestionDtoFromJson(Map<String, dynamic> json) =>
    SuggestionDto(
      highlightedSuggestion: json['highlightedSuggestion'] as String?,
      score: (json['score'] as num?)?.toDouble(),
      suggestion: json['suggestion'] as String?,
    );

Map<String, dynamic> _$SuggestionDtoToJson(SuggestionDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('highlightedSuggestion', instance.highlightedSuggestion);
  writeNotNull('score', instance.score);
  writeNotNull('suggestion', instance.suggestion);
  return val;
}
