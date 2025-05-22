// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pagination _$PaginationFromJson(Map<String, dynamic> json) => Pagination(
      currentPage: (json['currentPage'] as num?)?.toInt(),
      page: (json['page'] as num?)?.toInt(),
      pageSize: (json['pageSize'] as num?)?.toInt(),
      defaultPageSize: (json['defaultPageSize'] as num?)?.toInt(),
      totalItemCount: (json['totalItemCount'] as num?)?.toInt(),
      numberOfPages: (json['numberOfPages'] as num?)?.toInt(),
      pageSizeOptions: (json['pageSizeOptions'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      sortOptions: (json['sortOptions'] as List<dynamic>?)
          ?.map((e) => SortOption.fromJson(e as Map<String, dynamic>))
          .toList(),
      sortType: json['sortType'] as String?,
      nextPageUri: json['nextPageUri'] as String?,
      prevPageUri: json['prevPageUri'] as String?,
    );

Map<String, dynamic> _$PaginationToJson(Pagination instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('currentPage', instance.currentPage);
  writeNotNull('page', instance.page);
  writeNotNull('pageSize', instance.pageSize);
  writeNotNull('defaultPageSize', instance.defaultPageSize);
  writeNotNull('totalItemCount', instance.totalItemCount);
  writeNotNull('numberOfPages', instance.numberOfPages);
  writeNotNull('pageSizeOptions', instance.pageSizeOptions);
  writeNotNull(
      'sortOptions', instance.sortOptions?.map((e) => e.toJson()).toList());
  writeNotNull('sortType', instance.sortType);
  writeNotNull('nextPageUri', instance.nextPageUri);
  writeNotNull('prevPageUri', instance.prevPageUri);
  return val;
}
