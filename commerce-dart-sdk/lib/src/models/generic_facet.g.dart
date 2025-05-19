// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generic_facet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenericFacet _$GenericFacetFromJson(Map<String, dynamic> json) => GenericFacet(
      id: json['id'] as String?,
      name: json['name'] as String?,
      count: (json['count'] as num?)?.toInt(),
      selected: json['selected'] as bool?,
    );

Map<String, dynamic> _$GenericFacetToJson(GenericFacet instance) {
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
