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

Map<String, dynamic> _$VmiNoteModelToJson(VmiNoteModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uri', instance.uri);
  writeNotNull('properties', instance.properties);
  val['id'] = instance.id;
  writeNotNull('vmiBinId', instance.vmiBinId);
  val['note'] = instance.note;
  writeNotNull('createdOn', instance.createdOn?.toIso8601String());
  writeNotNull('vmiBinProductId', instance.vmiBinProductId);
  writeNotNull('includeOnOrder', instance.includeOnOrder);
  return val;
}
