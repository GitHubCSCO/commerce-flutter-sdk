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

Map<String, dynamic> _$FieldScoreDetailedToJson(FieldScoreDetailed instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  writeNotNull('score', instance.score);
  writeNotNull('boost', instance.boost);
  writeNotNull('matchText', instance.matchText);
  writeNotNull('termFrequencyNormalized', instance.termFrequencyNormalized);
  writeNotNull('inverseDocumentFrequency', instance.inverseDocumentFrequency);
  writeNotNull('scoreUsed', instance.scoreUsed);
  return val;
}
