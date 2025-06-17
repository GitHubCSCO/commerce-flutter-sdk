// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vmi_location_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetVmiLocationResult _$GetVmiLocationResultFromJson(
        Map<String, dynamic> json) =>
    GetVmiLocationResult(
      pagination:
          Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
      vmiLocations: (json['vmiLocations'] as List<dynamic>)
          .map((e) => VmiLocationModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$GetVmiLocationResultToJson(
        GetVmiLocationResult instance) =>
    <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      'pagination': instance.pagination.toJson(),
      'vmiLocations': instance.vmiLocations.map((e) => e.toJson()).toList(),
    };

GetVmiBinResult _$GetVmiBinResultFromJson(Map<String, dynamic> json) =>
    GetVmiBinResult(
      pagination:
          Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
      vmiBins: (json['vmiBins'] as List<dynamic>)
          .map((e) => VmiBinModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$GetVmiBinResultToJson(GetVmiBinResult instance) =>
    <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      'pagination': instance.pagination.toJson(),
      'vmiBins': instance.vmiBins.map((e) => e.toJson()).toList(),
    };

GetVmiCountResult _$GetVmiCountResultFromJson(Map<String, dynamic> json) =>
    GetVmiCountResult(
      pagination:
          Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
      vmiCounts: (json['vmiCounts'] as List<dynamic>)
          .map((e) => VmiCountModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$GetVmiCountResultToJson(GetVmiCountResult instance) =>
    <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      'pagination': instance.pagination.toJson(),
      'vmiCounts': instance.vmiCounts.map((e) => e.toJson()).toList(),
    };

GetVmiNoteResult _$GetVmiNoteResultFromJson(Map<String, dynamic> json) =>
    GetVmiNoteResult(
      pagination:
          Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
      vmiNotes: (json['vmiNotes'] as List<dynamic>)
          .map((e) => VmiNoteModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$GetVmiNoteResultToJson(GetVmiNoteResult instance) =>
    <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      'pagination': instance.pagination.toJson(),
      'vmiNotes': instance.vmiNotes.map((e) => e.toJson()).toList(),
    };
