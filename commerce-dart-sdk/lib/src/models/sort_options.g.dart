// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sort_options.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SortOption _$SortOptionFromJson(Map<String, dynamic> json) => SortOption(
      displayName: json['displayName'] as String?,
      sortType: json['sortType'] as String?,
    );

Map<String, dynamic> _$SortOptionToJson(SortOption instance) =>
    <String, dynamic>{
      if (instance.displayName case final value?) 'displayName': value,
      if (instance.sortType case final value?) 'sortType': value,
    };
