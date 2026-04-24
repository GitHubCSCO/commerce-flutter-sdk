// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class SpecificationEntity extends Equatable {
  final String? specificationId;
  final String? name;
  final String? nameDisplay;
  final String? value;
  final String? description;
  final double? sortOrder;
  final String? htmlContent;

  const SpecificationEntity({
    this.specificationId,
    this.name,
    this.nameDisplay,
    this.value,
    this.description,
    this.sortOrder,
    this.htmlContent,
  });

  @override
  List<Object?> get props => [specificationId];

  SpecificationEntity copyWith({
    String? specificationId,
    String? name,
    String? nameDisplay,
    String? value,
    String? description,
    double? sortOrder,
    String? htmlContent,
  }) {
    return SpecificationEntity(
      specificationId: specificationId ?? this.specificationId,
      name: name ?? this.name,
      nameDisplay: nameDisplay ?? this.nameDisplay,
      value: value ?? this.value,
      description: description ?? this.description,
      sortOrder: sortOrder ?? this.sortOrder,
      htmlContent: htmlContent ?? this.htmlContent,
    );
  }
}
