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

Map<String, dynamic> _$DocumentToJson(Document instance) => <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.name case final value?) 'name': value,
      if (instance.description case final value?) 'description': value,
      if (instance.createdOn?.toIso8601String() case final value?)
        'createdOn': value,
      if (instance.filePath case final value?) 'filePath': value,
      if (instance.fileUrl case final value?) 'fileUrl': value,
      if (instance.documentType case final value?) 'documentType': value,
      if (instance.languageId case final value?) 'languageId': value,
      if (instance.fileTypeString case final value?) 'fileTypeString': value,
    };
