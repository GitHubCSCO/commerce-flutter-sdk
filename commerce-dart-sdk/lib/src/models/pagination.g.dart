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

Map<String, dynamic> _$PaginationToJson(Pagination instance) =>
    <String, dynamic>{
      if (instance.currentPage case final value?) 'currentPage': value,
      if (instance.page case final value?) 'page': value,
      if (instance.pageSize case final value?) 'pageSize': value,
      if (instance.defaultPageSize case final value?) 'defaultPageSize': value,
      if (instance.totalItemCount case final value?) 'totalItemCount': value,
      if (instance.numberOfPages case final value?) 'numberOfPages': value,
      if (instance.pageSizeOptions case final value?) 'pageSizeOptions': value,
      if (instance.sortOptions?.map((e) => e.toJson()).toList()
          case final value?)
        'sortOptions': value,
      if (instance.sortType case final value?) 'sortType': value,
      if (instance.nextPageUri case final value?) 'nextPageUri': value,
      if (instance.prevPageUri case final value?) 'prevPageUri': value,
    };
