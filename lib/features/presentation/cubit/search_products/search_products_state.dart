abstract class SearchProductsState {}

class SearchProductsInitial extends SearchProductsState {}

class SearchProductsAddToCartSuccess extends SearchProductsState {}

class SearchProductsAddToCartFailure extends SearchProductsState {
  final String errorResponse;
  SearchProductsAddToCartFailure({required this.errorResponse});
}
