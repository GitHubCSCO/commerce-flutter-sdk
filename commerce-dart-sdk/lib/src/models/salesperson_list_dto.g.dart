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

Map<String, dynamic> _$SalespersonListDtoToJson(SalespersonListDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uri', instance.uri);
  writeNotNull('properties', instance.properties);
  writeNotNull('name', instance.name);
  writeNotNull('salespersonNumber', instance.salespersonNumber);
  return val;
}
