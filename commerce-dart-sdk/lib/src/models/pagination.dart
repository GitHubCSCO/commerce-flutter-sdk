import 'models.dart';

part 'pagination.g.dart';

@JsonSerializable()
class Pagination {
  /// Gets or sets the current page.
  @Deprecated('Obsolete in the C# SDK')
  int? currentPage;

  /// Gets or sets the page.
  int? page;

  /// Gets or sets the size of the page.
  int? pageSize;

  /// Gets or sets the default size of the page.
  int? defaultPageSize;

  /// Gets or sets the total item count.
  int? totalItemCount;

  /// Gets or sets the number of pages.
  int? numberOfPages;

  /// Gets or sets the page size options.
  List<int>? pageSizeOptions;

  /// Gets or sets the sort options.
  List<SortOption>? sortOptions;

  /// Gets or sets the type of the sort.
  String? sortType;

  /// full url to rest endpoint? to retrieve next page or null if no next page
  String? nextPageUri;

  /// full url to rest endpoint? to retrieve previous page or null if no previous page
  String? prevPageUri;
  Pagination({
    this.currentPage,
    this.page,
    this.pageSize,
    this.defaultPageSize,
    this.totalItemCount,
    this.numberOfPages,
    this.pageSizeOptions,
    this.sortOptions,
    this.sortType,
    this.nextPageUri,
    this.prevPageUri,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) =>
      _$PaginationFromJson(json);
  Map<String, dynamic> toJson() => _$PaginationToJson(this);
}
