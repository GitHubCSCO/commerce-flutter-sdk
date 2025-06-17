// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'field_score.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FieldScore _$FieldScoreFromJson(Map<String, dynamic> json) => FieldScore(
      name: json['name'] as String?,
      score: (json['score'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$FieldScoreToJson(FieldScore instance) =>
    <String, dynamic>{
      if (instance.name case final value?) 'name': value,
      if (instance.score case final value?) 'score': value,
    };
