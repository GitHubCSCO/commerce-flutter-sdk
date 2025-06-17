// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vmi_location_query_parameters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$BaseVmiLocationQueryParametersToJson(
        BaseVmiLocationQueryParameters instance) =>
    <String, dynamic>{
      if (instance.page case final value?) 'page': value,
      if (instance.pageSize case final value?) 'pageSize': value,
      if (instance.sort case final value?) 'sort': value,
      if (instance.vmiLocationId case final value?) 'vmiLocationId': value,
    };

Map<String, dynamic> _$VmiLocationQueryParametersToJson(
        VmiLocationQueryParameters instance) =>
    <String, dynamic>{
      if (instance.page case final value?) 'page': value,
      if (instance.pageSize case final value?) 'pageSize': value,
      if (instance.sort case final value?) 'sort': value,
      if (instance.userId case final value?) 'userId': value,
      if (instance.filter case final value?) 'filter': value,
      if (JsonEncodingMethods.commaSeparatedJson(instance.expand)
          case final value?)
        'expand': value,
    };

Map<String, dynamic> _$VmiBinQueryParametersToJson(
        VmiBinQueryParameters instance) =>
    <String, dynamic>{
      if (instance.page case final value?) 'page': value,
      if (instance.pageSize case final value?) 'pageSize': value,
      if (instance.sort case final value?) 'sort': value,
      if (instance.vmiLocationId case final value?) 'vmiLocationId': value,
      if (instance.filter case final value?) 'filter': value,
      if (instance.searchCriteria case final value?) 'searchCriteria': value,
      if (instance.binNumberFrom case final value?) 'binNumberFrom': value,
      if (instance.binNumberTo case final value?) 'binNumberTo': value,
      if (instance.previousCountFromDate?.toIso8601String() case final value?)
        'previousCountFromDate': value,
      if (instance.previousCountToDate?.toIso8601String() case final value?)
        'previousCountToDate': value,
      'expand': instance.expand,
    };

Map<String, dynamic> _$VmiCountQueryParametersToJson(
        VmiCountQueryParameters instance) =>
    <String, dynamic>{
      if (instance.page case final value?) 'page': value,
      if (instance.pageSize case final value?) 'pageSize': value,
      if (instance.sort case final value?) 'sort': value,
      if (instance.vmiLocationId case final value?) 'vmiLocationId': value,
      'vmiBinId': instance.vmiBinId,
    };

Map<String, dynamic> _$VmiNoteQueryParametersToJson(
        VmiNoteQueryParameters instance) =>
    <String, dynamic>{
      if (instance.page case final value?) 'page': value,
      if (instance.pageSize case final value?) 'pageSize': value,
      if (instance.sort case final value?) 'sort': value,
      if (instance.vmiLocationId case final value?) 'vmiLocationId': value,
      'vmiBinId': instance.vmiBinId,
      if (instance.vmiNoteId case final value?) 'vmiNoteId': value,
    };

Map<String, dynamic> _$VmiLocationDetailParametersToJson(
        VmiLocationDetailParameters instance) =>
    <String, dynamic>{
      if (instance.page case final value?) 'page': value,
      if (instance.pageSize case final value?) 'pageSize': value,
      if (instance.sort case final value?) 'sort': value,
      if (instance.vmiLocationId case final value?) 'vmiLocationId': value,
      'expand': instance.expand,
    };

Map<String, dynamic> _$VmiBinDetailParametersToJson(
        VmiBinDetailParameters instance) =>
    <String, dynamic>{
      if (instance.page case final value?) 'page': value,
      if (instance.pageSize case final value?) 'pageSize': value,
      if (instance.sort case final value?) 'sort': value,
      if (instance.vmiLocationId case final value?) 'vmiLocationId': value,
      'vmiBinId': instance.vmiBinId,
    };

Map<String, dynamic> _$VmiCountDetailParametersToJson(
        VmiCountDetailParameters instance) =>
    <String, dynamic>{
      if (instance.page case final value?) 'page': value,
      if (instance.pageSize case final value?) 'pageSize': value,
      if (instance.sort case final value?) 'sort': value,
      if (instance.vmiLocationId case final value?) 'vmiLocationId': value,
      'vmiBinId': instance.vmiBinId,
      'vmiCountId': instance.vmiCountId,
    };

Map<String, dynamic> _$VmiNoteDetailParametersToJson(
        VmiNoteDetailParameters instance) =>
    <String, dynamic>{
      if (instance.page case final value?) 'page': value,
      if (instance.pageSize case final value?) 'pageSize': value,
      if (instance.sort case final value?) 'sort': value,
      if (instance.vmiLocationId case final value?) 'vmiLocationId': value,
      'vmiBinId': instance.vmiBinId,
      'vmiNoteId': instance.vmiNoteId,
    };

Map<String, dynamic> _$VmiLocationProductParametersToJson(
        VmiLocationProductParameters instance) =>
    <String, dynamic>{
      if (instance.page case final value?) 'page': value,
      if (instance.pageSize case final value?) 'pageSize': value,
      if (instance.sort case final value?) 'sort': value,
      if (instance.vmiLocationId case final value?) 'vmiLocationId': value,
      'searchCriteria': instance.searchCriteria,
      'expand': instance.expand,
      'filter': instance.filter,
    };
