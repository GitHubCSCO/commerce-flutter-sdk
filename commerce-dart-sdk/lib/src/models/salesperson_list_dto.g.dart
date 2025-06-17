// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'salesperson_list_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SalespersonListDto _$SalespersonListDtoFromJson(Map<String, dynamic> json) =>
    SalespersonListDto(
      name: json['name'] as String?,
      salespersonNumber: json['salespersonNumber'] as String?,
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$SalespersonListDtoToJson(SalespersonListDto instance) =>
    <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.name case final value?) 'name': value,
      if (instance.salespersonNumber case final value?)
        'salespersonNumber': value,
    };
