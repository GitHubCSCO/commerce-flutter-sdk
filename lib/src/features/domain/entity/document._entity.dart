// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class DocumentEntity extends Equatable {
  final String? id;
  final String? name;
  final String? description;
  final String? filePath;
  final String? documentType;

  const DocumentEntity({
    this.id,
    this.name,
    this.description,
    this.filePath,
    this.documentType,
  });

  @override
  List<Object?> get props => [id];

  DocumentEntity copyWith({
    String? id,
    String? name,
    String? description,
    String? filePath,
    String? documentType,
  }) {
    return DocumentEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      filePath: filePath ?? this.filePath,
      documentType: documentType ?? this.documentType,
    );
  }
}
