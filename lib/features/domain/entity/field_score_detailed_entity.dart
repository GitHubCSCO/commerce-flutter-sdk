// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:commerce_flutter_app/features/domain/entity/field_score_entity.dart';

class FieldScoreDetailedEntity extends FieldScoreEntity {
  final double? boost;
  final String? matchText;
  final double? termFrequencyNormalized;
  final double? inverseDocumentFrequency;
  final bool? scoreUsed;

  const FieldScoreDetailedEntity({
    final String? name,
    final double? score,
    this.boost,
    this.inverseDocumentFrequency,
    this.matchText,
    this.scoreUsed,
    this.termFrequencyNormalized,
  });

  @override
  FieldScoreDetailedEntity copyWith({
    final String? name,
    final double? score,
    double? boost,
    String? matchText,
    double? termFrequencyNormalized,
    double? inverseDocumentFrequency,
    bool? scoreUsed,
  }) {
    return FieldScoreDetailedEntity(
      name: name ?? this.name,
      score: score ?? this.score,
      boost: boost ?? this.boost,
      matchText: matchText ?? this.matchText,
      termFrequencyNormalized:
          termFrequencyNormalized ?? this.termFrequencyNormalized,
      inverseDocumentFrequency:
          inverseDocumentFrequency ?? this.inverseDocumentFrequency,
      scoreUsed: scoreUsed ?? this.scoreUsed,
    );
  }
}
