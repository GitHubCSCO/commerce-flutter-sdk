// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_line.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductLine _$ProductLineFromJson(Map<String, dynamic> json) => ProductLine(
      id: json['id'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$ProductLineToJson(ProductLine instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.name case final value?) 'name': value,
    };
