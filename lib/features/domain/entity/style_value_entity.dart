// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class StyleValueEntity extends Equatable {
  final String? styleTraitName;
  final String? styleTraitId;
  final String? styleTraitValueId;
  final String? value;
  final String? valueDisplay;
  final int? sortOrder;
  final bool? isDefault;
  final String? id;

  const StyleValueEntity({
    this.styleTraitName,
    this.styleTraitId,
    this.styleTraitValueId,
    this.value,
    this.valueDisplay,
    this.sortOrder,
    this.isDefault,
    this.id,
  });

  StyleValueEntity copyWith({
    String? styleTraitName,
    String? styleTraitId,
    String? styleTraitValueId,
    String? value,
    String? valueDisplay,
    int? sortOrder,
    bool? isDefault,
    String? id,
  }) {
    return StyleValueEntity(
      styleTraitName: styleTraitName ?? this.styleTraitName,
      styleTraitId: styleTraitId ?? this.styleTraitId,
      styleTraitValueId: styleTraitValueId ?? this.styleTraitValueId,
      value: value ?? this.value,
      valueDisplay: valueDisplay ?? this.valueDisplay,
      sortOrder: sortOrder ?? this.sortOrder,
      isDefault: isDefault ?? this.isDefault,
      id: id ?? this.id,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
