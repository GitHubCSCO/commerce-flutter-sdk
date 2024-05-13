part of 'search_products_cubit.dart';

class SearchProductsState extends Equatable {

  final GetProductCollectionResult? productEntities;
  final SearchProductStatus searchProductStatus;

  const SearchProductsState({
    required this.productEntities,
    required this.searchProductStatus,
  });

  @override
  List<Object> get props => [searchProductStatus];

  SearchProductsState copyWith({
    GetProductCollectionResult? productEntities,
    SearchProductStatus? searchProductStatus,
  }) {
    return SearchProductsState(
      productEntities: productEntities ?? this.productEntities,
      searchProductStatus: searchProductStatus ?? this.searchProductStatus,
    );
  }

}
