part of 'product_carousel_cubit.dart';

abstract class ProductCarouselState {}

class ProductCarouselInitialState extends ProductCarouselState {}

class ProductCarouseLoadingState extends ProductCarouselState {}

class ProductCarouselLoadedState extends ProductCarouselState {
  final List<ProductEntity> productList;

  ProductCarouselLoadedState({required this.productList});
}

class ProductCarouselFailureState extends ProductCarouselState {
  final String error;

  ProductCarouselFailureState({required this.error});
}
