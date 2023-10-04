// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Document _$DocumentFromJson(Map<String, dynamic> json) => Document(
      createdOn: json['createdOn'] == null
          ? null
          : DateTime.parse(json['createdOn'] as String),
      description: json['description'] as String?,
      documentType: json['documentType'] as String?,
      filePath: json['filePath'] as String?,
      id: json['id'] as String?,
      languageId: json['languageId'] as String?,
      name: json['name'] as String?,
      fileTypeString: json['fileTypeString'] as String?,
      fileUrl: json['fileUrl'] as String?,
    );

Map<String, dynamic> _$DocumentToJson(Document instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('description', instance.description);
  writeNotNull('createdOn', instance.createdOn?.toIso8601String());
  writeNotNull('filePath', instance.filePath);
  writeNotNull('fileUrl', instance.fileUrl);
  writeNotNull('documentType', instance.documentType);
  writeNotNull('languageId', instance.languageId);
  writeNotNull('fileTypeString', instance.fileTypeString);
  return val;
}
