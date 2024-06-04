part of 'product_list_filter_cubit.dart';

class ProductListFilterState extends Equatable {
  const ProductListFilterState({
    required this.productsParameters,
    required this.productSettings,
    required this.searchSettings,
    required this.status,
    required this.filterValues,
  });

  final ProductsQueryParameters productsParameters;
  final ProductSettings productSettings;
  final SearchSettings searchSettings;
  final ProductListFilterStatus status;
  final List<FilterValueViewModelCollection> filterValues;

  @override
  List<Object> get props => [
        productsParameters,
        productSettings,
        searchSettings,
        status,
      ];

  ProductListFilterState copyWith({
    ProductsQueryParameters? productsParameters,
    ProductSettings? productSettings,
    SearchSettings? searchSettings,
    ProductListFilterStatus? status,
    List<FilterValueViewModelCollection>? filterValues,
  }) {
    return ProductListFilterState(
      productsParameters: productsParameters ?? this.productsParameters,
      productSettings: productSettings ?? this.productSettings,
      searchSettings: searchSettings ?? this.searchSettings,
      status: status ?? this.status,
      filterValues: filterValues ?? this.filterValues,
    );
  }
}
