// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:commerce_flutter_app/features/domain/entity/style_value_entity.dart';
import 'package:equatable/equatable.dart';

class StyleTraitEntity extends Equatable {
  final String? styleTraitId;
  final String? name;
  final String? nameDisplay;
  final String? unselectedValue;
  final int? sortOrder;
  final List<StyleValueEntity>? styleValues;
  final String? id;
  final List<StyleValueEntity>? traitValues;

  const StyleTraitEntity({
    this.styleTraitId,
    this.name,
    this.nameDisplay,
    this.unselectedValue,
    this.sortOrder,
    this.styleValues,
    this.id,
    this.traitValues,
  });

  StyleTraitEntity copyWith({
    String? styleTraitId,
    String? name,
    String? nameDisplay,
    String? unselectedValue,
    int? sortOrder,
    List<StyleValueEntity>? styleValues,
    String? id,
    List<StyleValueEntity>? traitValues,
  }) {
    return StyleTraitEntity(
      styleTraitId: styleTraitId ?? this.styleTraitId,
      name: name ?? this.name,
      nameDisplay: nameDisplay ?? this.nameDisplay,
      unselectedValue: unselectedValue ?? this.unselectedValue,
      sortOrder: sortOrder ?? this.sortOrder,
      styleValues: styleValues ?? this.styleValues,
      id: id ?? this.id,
      traitValues: traitValues ?? this.traitValues,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
