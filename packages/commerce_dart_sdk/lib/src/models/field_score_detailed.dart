import 'models.dart';

part 'field_score_detailed.g.dart';

@JsonSerializable(explicitToJson: true)
class FieldScoreDetailed extends FieldScore {
  FieldScoreDetailed(
      {this.boost,
      this.inverseDocumentFrequency,
      this.matchText,
      this.scoreUsed,
      this.termFrequencyNormalized});

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
