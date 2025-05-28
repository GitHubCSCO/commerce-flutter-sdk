// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class SpecificationEntity extends Equatable {
  final String? specificationId;
  final String? name;
  final String? nameDisplay;
  final String? value;
  final String? description;
  final double? sortOrder;
  final bool? isActive;
  final SpecificationEntity? parentSpecification;
  final String? htmlContent;
  final SpecificationEntity? specifications;

  const SpecificationEntity({
    this.specificationId,
    this.name,
    this.nameDisplay,
    this.value,
    this.description,
    this.sortOrder,
    this.isActive,
    this.parentSpecification,
    this.htmlContent,
    this.specifications,
  });

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  SpecificationEntity copyWith({
    String? specificationId,
    String? name,
    String? nameDisplay,
    String? value,
    String? description,
    double? sortOrder,
    bool? isActive,
    SpecificationEntity? parentSpecification,
    String? htmlContent,
    SpecificationEntity? specifications,
  }) {
    return SpecificationEntity(
      specificationId: specificationId ?? this.specificationId,
      name: name ?? this.name,
      nameDisplay: nameDisplay ?? this.nameDisplay,
      value: value ?? this.value,
      description: description ?? this.description,
      sortOrder: sortOrder ?? this.sortOrder,
      isActive: isActive ?? this.isActive,
      parentSpecification: parentSpecification ?? this.parentSpecification,
      htmlContent: htmlContent ?? this.htmlContent,
      specifications: specifications ?? this.specifications,
    );
  }
}
