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

Map<String, dynamic> _$ProductLineToJson(ProductLine instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('count', instance.count);
  writeNotNull('selected', instance.selected);
  return val;
}
