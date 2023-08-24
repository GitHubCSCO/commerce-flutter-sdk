// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_line.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductLine _$ProductLineFromJson(Map<String, dynamic> json) => ProductLine(
      count: json['count'] as int?,
      id: json['id'] as String?,
      name: json['name'] as String?,
      selected: json['selected'] as bool?,
    );

Map<String, dynamic> _$ProductLineToJson(ProductLine instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'count': instance.count,
      'selected': instance.selected,
    };
