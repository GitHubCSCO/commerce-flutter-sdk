import 'models.dart';

part 'field_score_detailed.g.dart';

@JsonSerializable(explicitToJson: true)
class FieldScoreDetailed extends FieldScore {
  FieldScoreDetailed({
    String? name,
    double? score,
    this.boost,
    this.inverseDocumentFrequency,
    this.matchText,
    this.scoreUsed,
    this.termFrequencyNormalized,
  }) : super(name: name, score: score);

  double? boost;

  String? matchText;

  double? termFrequencyNormalized;

  double? inverseDocumentFrequency;

  bool? scoreUsed;

  factory FieldScoreDetailed.fromJson(Map<String, dynamic> json) =>
      _$FieldScoreDetailedFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$FieldScoreDetailedToJson(this);
}
