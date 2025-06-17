// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'field_score_detailed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FieldScoreDetailed _$FieldScoreDetailedFromJson(Map<String, dynamic> json) =>
    FieldScoreDetailed(
      name: json['name'] as String?,
      score: (json['score'] as num?)?.toDouble(),
      boost: (json['boost'] as num?)?.toDouble(),
      inverseDocumentFrequency:
          (json['inverseDocumentFrequency'] as num?)?.toDouble(),
      matchText: json['matchText'] as String?,
      scoreUsed: json['scoreUsed'] as bool?,
      termFrequencyNormalized:
          (json['termFrequencyNormalized'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$FieldScoreDetailedToJson(FieldScoreDetailed instance) =>
    <String, dynamic>{
      if (instance.name case final value?) 'name': value,
      if (instance.score case final value?) 'score': value,
      if (instance.boost case final value?) 'boost': value,
      if (instance.matchText case final value?) 'matchText': value,
      if (instance.termFrequencyNormalized case final value?)
        'termFrequencyNormalized': value,
      if (instance.inverseDocumentFrequency case final value?)
        'inverseDocumentFrequency': value,
      if (instance.scoreUsed case final value?) 'scoreUsed': value,
    };
