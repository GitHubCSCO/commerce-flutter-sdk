import 'models.dart';

part 'document.g.dart';

@JsonSerializable(explicitToJson: true)
class Document {
  Document({
    this.createdOn,
    this.description,
    this.documentType,
    this.filePath,
    this.id,
    this.languageId,
    this.name,
    this.fileTypeString,
    this.fileUrl,
  });

  String? id;

  String? name;

  String? description;

  DateTime? createdOn;

  String? filePath;

  @Deprecated("Use FilePath instead")
  String? fileUrl;

  String? documentType;

  String? languageId;

  @Deprecated("Use DocumentType instead")
  String? fileTypeString;

  factory Document.fromJson(Map<String, dynamic> json) =>
      _$DocumentFromJson(json);
  Map<String, dynamic> toJson() => _$DocumentToJson(this);
}
