// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class ChildTraitValueEntity extends Equatable {
  final String? id;
  final String? styleTraitId;
  final String? value;
  final String? valueDisplay;

  ChildTraitValueEntity({
    this.id,
    this.styleTraitId,
    this.value,
    this.valueDisplay,
  });

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  ChildTraitValueEntity copyWith({
    String? id,
    String? styleTraitId,
    String? value,
    String? valueDisplay,
  }) {
    return ChildTraitValueEntity(
      id: id ?? this.id,
      styleTraitId: styleTraitId ?? this.styleTraitId,
      value: value ?? this.value,
      valueDisplay: valueDisplay ?? this.valueDisplay,
    );
  }
}
