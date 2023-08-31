// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'field_score_detailed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FieldScoreDetailed _$FieldScoreDetailedFromJson(Map<String, dynamic> json) =>
    FieldScoreDetailed(
      boost: (json['boost'] as num?)?.toDouble(),
      inverseDocumentFrequency:
          (json['inverseDocumentFrequency'] as num?)?.toDouble(),
      matchText: json['matchText'] as String?,
      scoreUsed: json['scoreUsed'] as bool?,
      termFrequencyNormalized:
          (json['termFrequencyNormalized'] as num?)?.toDouble(),
    )
      ..name = json['name'] as String?
      ..score = (json['score'] as num?)?.toDouble();

Map<String, dynamic> _$FieldScoreDetailedToJson(FieldScoreDetailed instance) =>
    <String, dynamic>{
      'name': instance.name,
      'score': instance.score,
      'boost': instance.boost,
      'matchText': instance.matchText,
      'termFrequencyNormalized': instance.termFrequencyNormalized,
      'inverseDocumentFrequency': instance.inverseDocumentFrequency,
      'scoreUsed': instance.scoreUsed,
    };
