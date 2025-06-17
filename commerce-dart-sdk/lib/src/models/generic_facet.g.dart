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

Map<String, dynamic> _$GenericFacetToJson(GenericFacet instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.name case final value?) 'name': value,
      if (instance.count case final value?) 'count': value,
      if (instance.selected case final value?) 'selected': value,
    };
