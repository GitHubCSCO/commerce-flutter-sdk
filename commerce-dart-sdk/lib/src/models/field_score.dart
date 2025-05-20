import 'models.dart';

part 'field_score.g.dart';

@JsonSerializable(explicitToJson: true)
class FieldScore {
  FieldScore({
    this.name,
    this.score,
  });

  String? name;

  double? score;

  factory FieldScore.fromJson(Map<String, dynamic> json) =>
      _$FieldScoreFromJson(json);
  Map<String, dynamic> toJson() => _$FieldScoreToJson(this);
}
