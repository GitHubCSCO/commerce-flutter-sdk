// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class FieldScoreEntity extends Equatable {
  final String? name;
  final double? score;

  const FieldScoreEntity({
    this.name,
    this.score,
  });

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  FieldScoreEntity copyWith({
    String? name,
    double? score,
  }) {
    return FieldScoreEntity(
      name: name ?? this.name,
      score: score ?? this.score,
    );
  }
}
