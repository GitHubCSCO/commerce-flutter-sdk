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
      if (instance.totalBoost case final value?) 'totalBoost': value,
      if (instance.aggregateFieldScores?.map((e) => e.toJson()).toList()
          case final value?)
        'aggregateFieldScores': value,
      if (instance.detailedFieldScores?.map((e) => e.toJson()).toList()
          case final value?)
        'detailedFieldScores': value,
    };
