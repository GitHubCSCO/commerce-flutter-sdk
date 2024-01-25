// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class DocumentEntity extends Equatable {
  final String? id;
  final String? name;
  final String? description;
  final DateTime? createdOn;
  final String? filePath;
  @Deprecated("Use FilePath instead")
  final String? fileUrl;
  final String? documentType;
  final String? languageId;
  @Deprecated("Use DocumentType instead")
  final String? fileTypeString;

  const DocumentEntity({
    this.id,
    this.name,
    this.description,
    this.createdOn,
    this.filePath,
    this.fileUrl,
    this.documentType,
    this.languageId,
    this.fileTypeString,
  });

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  DocumentEntity copyWith({
    String? id,
    String? name,
    String? description,
    DateTime? createdOn,
    String? filePath,
    String? fileUrl,
    String? documentType,
    String? languageId,
    String? fileTypeString,
  }) {
    return DocumentEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      createdOn: createdOn ?? this.createdOn,
      filePath: filePath ?? this.filePath,
      fileUrl: fileUrl ?? this.fileUrl,
      documentType: documentType ?? this.documentType,
      languageId: languageId ?? this.languageId,
      fileTypeString: fileTypeString ?? this.fileTypeString,
    );
  }
}
