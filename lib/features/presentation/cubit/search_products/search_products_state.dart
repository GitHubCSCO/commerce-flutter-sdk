part of 'search_products_cubit.dart';

class SearchProductsState extends Equatable {
  final GetProductCollectionResult? productEntities;
  final SearchProductStatus searchProductStatus;
  final List<SortOrderAttribute> availableSortOrders;
  final SortOrderAttribute selectedSortOrder;

  const SearchProductsState({
    required this.productEntities,
    required this.searchProductStatus,
    required this.availableSortOrders,
    required this.selectedSortOrder,
  });

  @override
  List<Object> get props => [
        searchProductStatus,
        availableSortOrders,
        selectedSortOrder,
      ];

  SearchProductsState copyWith({
    GetProductCollectionResult? productEntities,
    SearchProductStatus? searchProductStatus,
    List<SortOrderAttribute>? availableSortOrders,
    SortOrderAttribute? selectedSortOrder,
  }) {
    return SearchProductsState(
      productEntities: productEntities ?? this.productEntities,
      searchProductStatus: searchProductStatus ?? this.searchProductStatus,
      availableSortOrders: availableSortOrders ?? this.availableSortOrders,
      selectedSortOrder: selectedSortOrder ?? this.selectedSortOrder,
    );
  }
}
