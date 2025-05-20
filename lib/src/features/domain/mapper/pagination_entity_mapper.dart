import 'package:commerce_flutter_sdk/src/features/domain/entity/pagination_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/sort_option_entity_mapper.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class PaginationEntityMapper {
  static PaginationEntity toEntity(Pagination model) => PaginationEntity(
        currentPage: model.currentPage,
        page: model.page,
        pageSize: model.pageSize,
        defaultPageSize: model.defaultPageSize,
        totalItemCount: model.totalItemCount,
        numberOfPages: model.numberOfPages,
        pageSizeOptions: model.pageSizeOptions,
        sortOptions: model.sortOptions
            ?.map((sortOption) => SortOptionEntityMapper.toEntity(sortOption))
            .toList(),
        sortType: model.sortType,
        nextPageUri: model.nextPageUri,
        prevPageUri: model.prevPageUri,
      );

  static Pagination toModel(PaginationEntity entity) => Pagination(
        currentPage: entity.currentPage,
        page: entity.page,
        pageSize: entity.pageSize,
        defaultPageSize: entity.defaultPageSize,
        totalItemCount: entity.totalItemCount,
        numberOfPages: entity.numberOfPages,
        pageSizeOptions: entity.pageSizeOptions,
        sortOptions: entity.sortOptions
            ?.map((sortOption) => SortOptionEntityMapper.toModel(sortOption))
            .toList(),
        sortType: entity.sortType,
        nextPageUri: entity.nextPageUri,
        prevPageUri: entity.prevPageUri,
      );
}
