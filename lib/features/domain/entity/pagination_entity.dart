import 'package:equatable/equatable.dart';

import 'package:commerce_flutter_sdk/features/domain/entity/sort_options_entity.dart';

class PaginationEntity extends Equatable {
  /// Gets or sets the current page.
  @Deprecated('Obsolete in the C# SDK')
  final int? currentPage;

  /// Gets or sets the page.
  final int? page;

  /// Gets or sets the size of the page.
  final int? pageSize;

  /// Gets or sets the default size of the page.
  final int? defaultPageSize;

  /// Gets or sets the total item count.
  final int? totalItemCount;

  /// Gets or sets the number of pages.
  final int? numberOfPages;

  /// Gets or sets the page size options.
  final List<int>? pageSizeOptions;

  /// Gets or sets the sort options.
  final List<SortOptionEntity>? sortOptions;

  /// Gets or sets the type of the sort.
  final String? sortType;

  /// full url to rest endpoint? to retrieve next page or null if no next page
  final String? nextPageUri;

  /// full url to rest endpoint? to retrieve previous page or null if no previous page
  final String? prevPageUri;

  const PaginationEntity({
    required this.currentPage,
    required this.page,
    required this.pageSize,
    required this.defaultPageSize,
    required this.totalItemCount,
    required this.numberOfPages,
    required this.pageSizeOptions,
    required this.sortOptions,
    required this.sortType,
    required this.nextPageUri,
    required this.prevPageUri,
  });

  @override
  List<Object?> get props => [
        currentPage,
        page,
        pageSize,
        defaultPageSize,
        totalItemCount,
        numberOfPages,
        pageSizeOptions,
        sortOptions,
        sortType,
        nextPageUri,
        prevPageUri,
      ];

  PaginationEntity copyWith({
    int? currentPage,
    int? page,
    int? pageSize,
    int? defaultPageSize,
    int? totalItemCount,
    int? numberOfPages,
    List<int>? pageSizeOptions,
    List<SortOptionEntity>? sortOptions,
    String? sortType,
    String? nextPageUri,
    String? prevPageUri,
  }) {
    return PaginationEntity(
      currentPage: currentPage ?? this.currentPage,
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
      defaultPageSize: defaultPageSize ?? this.defaultPageSize,
      totalItemCount: totalItemCount ?? this.totalItemCount,
      numberOfPages: numberOfPages ?? this.numberOfPages,
      pageSizeOptions: pageSizeOptions ?? this.pageSizeOptions,
      sortOptions: sortOptions ?? this.sortOptions,
      sortType: sortType ?? this.sortType,
      nextPageUri: nextPageUri ?? this.nextPageUri,
      prevPageUri: prevPageUri ?? this.prevPageUri,
    );
  }
}
