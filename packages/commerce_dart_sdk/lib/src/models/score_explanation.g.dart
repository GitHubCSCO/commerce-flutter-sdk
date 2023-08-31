// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'score_explanation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScoreExplanation _$ScoreExplanationFromJson(Map<String, dynamic> json) =>
    ScoreExplanation(
      aggregateFieldScores: (json['aggregateFieldScores'] as List<dynamic>?)
          ?.map((e) => FieldScore.fromJson(e as Map<String, dynamic>))
          .toList(),
      detailedFieldScores: (json['detailedFieldScores'] as List<dynamic>?)
          ?.map((e) => FieldScoreDetailed.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalBoost: (json['totalBoost'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ScoreExplanationToJson(ScoreExplanation instance) =>
    <String, dynamic>{
      'totalBoost': instance.totalBoost,
      'aggregateFieldScores':
          instance.aggregateFieldScores?.map((e) => e.toJson()).toList(),
      'detailedFieldScores':
          instance.detailedFieldScores?.map((e) => e.toJson()).toList(),
    };
