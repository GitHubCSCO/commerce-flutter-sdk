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

Map<String, dynamic> _$SuggestionDtoToJson(SuggestionDto instance) =>
    <String, dynamic>{
      if (instance.highlightedSuggestion case final value?)
        'highlightedSuggestion': value,
      if (instance.score case final value?) 'score': value,
      if (instance.suggestion case final value?) 'suggestion': value,
    };
