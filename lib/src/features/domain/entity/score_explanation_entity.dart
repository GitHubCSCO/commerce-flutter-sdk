// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:commerce_flutter_sdk/src/features/domain/entity/field_score_detailed_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/field_score_entity.dart';

class ScoreExplanationEntity extends Equatable {
  final double? totalBoost;
  final List<FieldScoreEntity>? aggregateFieldScores;
  final List<FieldScoreDetailedEntity>? detailedFieldScores;
  const ScoreExplanationEntity({
    this.totalBoost,
    this.aggregateFieldScores,
    this.detailedFieldScores,
  });

  @override
  List<Object?> get props => throw UnimplementedError();

  ScoreExplanationEntity copyWith({
    double? totalBoost,
    List<FieldScoreEntity>? aggregateFieldScores,
    List<FieldScoreDetailedEntity>? detailedFieldScores,
  }) {
    return ScoreExplanationEntity(
      totalBoost: totalBoost ?? this.totalBoost,
      aggregateFieldScores: aggregateFieldScores ?? this.aggregateFieldScores,
      detailedFieldScores: detailedFieldScores ?? this.detailedFieldScores,
    );
  }
}
