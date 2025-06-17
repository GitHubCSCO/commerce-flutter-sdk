// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_line.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductLine _$ProductLineFromJson(Map<String, dynamic> json) => ProductLine(
      count: (json['count'] as num?)?.toInt(),
      id: json['id'] as String?,
      name: json['name'] as String?,
      selected: json['selected'] as bool?,
    );

Map<String, dynamic> _$ProductLineToJson(ProductLine instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.name case final value?) 'name': value,
      if (instance.count case final value?) 'count': value,
      if (instance.selected case final value?) 'selected': value,
    };
