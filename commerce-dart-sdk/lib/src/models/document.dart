import 'models.dart';

part 'document.g.dart';

@JsonSerializable(explicitToJson: true)
class Document {
  Document({
    this.description,
    this.documentType,
    this.filePath,
    this.id,
    this.name,
  });

  String? id;

  String? name;

  String? description;

  String? filePath;

  String? documentType;

  factory Document.fromJson(Map<String, dynamic> json) =>
      _$DocumentFromJson(json);
  Map<String, dynamic> toJson() => _$DocumentToJson(this);
}
