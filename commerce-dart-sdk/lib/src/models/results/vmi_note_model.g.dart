// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vmi_note_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VmiNoteModel _$VmiNoteModelFromJson(Map<String, dynamic> json) => VmiNoteModel(
      id: json['id'] as String,
      vmiBinId: json['vmiBinId'] as String?,
      note: json['note'] as String,
      createdOn: json['createdOn'] == null
          ? null
          : DateTime.parse(json['createdOn'] as String),
      vmiBinProductId: json['vmiBinProductId'] as String?,
      includeOnOrder: json['includeOnOrder'] as bool?,
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$VmiNoteModelToJson(VmiNoteModel instance) =>
    <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      'id': instance.id,
      if (instance.vmiBinId case final value?) 'vmiBinId': value,
      'note': instance.note,
      if (instance.createdOn?.toIso8601String() case final value?)
        'createdOn': value,
      if (instance.vmiBinProductId case final value?) 'vmiBinProductId': value,
      if (instance.includeOnOrder case final value?) 'includeOnOrder': value,
    };
