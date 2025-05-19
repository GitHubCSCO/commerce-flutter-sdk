import 'models.dart';

part 'score_explanation.g.dart';

@JsonSerializable(explicitToJson: true)
class ScoreExplanation {
  ScoreExplanation({
    this.aggregateFieldScores,
    this.detailedFieldScores,
    this.totalBoost,
  });

  double? totalBoost;

  List<FieldScore>? aggregateFieldScores;

  List<FieldScoreDetailed>? detailedFieldScores;

  factory ScoreExplanation.fromJson(Map<String, dynamic> json) =>
      _$ScoreExplanationFromJson(json);
  Map<String, dynamic> toJson() => _$ScoreExplanationToJson(this);
}
