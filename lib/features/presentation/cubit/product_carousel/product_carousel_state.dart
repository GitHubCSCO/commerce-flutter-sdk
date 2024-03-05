part of 'product_carousel_cubit.dart';

abstract class ProductCarouselState extends Equatable {}

class ProductCarouselInitialState extends ProductCarouselState {
  @override
  List<Object?> get props => [];
}

class ProductCarouseLoadingState extends ProductCarouselState {
  @override
  List<Object?> get props => [];
}

class ProductCarouselLoadedState extends ProductCarouselState {
  final List<ProductCarouselEntity> productCarouselList;
  bool isPricingLoading;

  ProductCarouselLoadedState({required this.productCarouselList, required this.isPricingLoading});

  @override
  List<Object?> get props => [productCarouselList, isPricingLoading];
}

class ProductCarouselFailureState extends ProductCarouselState {
  final String error;

  ProductCarouselFailureState({required this.error});

  @override
  List<Object?> get props => [error];
}
