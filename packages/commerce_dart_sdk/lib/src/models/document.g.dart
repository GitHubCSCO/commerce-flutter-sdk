// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package

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
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'createdOn': instance.createdOn?.toIso8601String(),
      'filePath': instance.filePath,
      'fileUrl': instance.fileUrl,
      'documentType': instance.documentType,
      'languageId': instance.languageId,
      'fileTypeString': instance.fileTypeString,
    };
