// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sort_options.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SortOption _$SortOptionFromJson(Map<String, dynamic> json) => SortOption(
      displayName: json['displayName'] as String?,
      sortType: json['sortType'] as String?,
    );

Map<String, dynamic> _$SortOptionToJson(SortOption instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('displayName', instance.displayName);
  writeNotNull('sortType', instance.sortType);
  return val;
}
