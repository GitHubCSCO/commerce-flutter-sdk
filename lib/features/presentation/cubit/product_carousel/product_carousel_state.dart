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
  final bool isPricingLoading;
  final bool? hidePricingEnable;

  ProductCarouselLoadedState(
      {required this.productCarouselList,
      required this.isPricingLoading, this.hidePricingEnable});

  @override
  List<Object?> get props => [productCarouselList, isPricingLoading, hidePricingEnable];
}

class ProductCarouselFailureState extends ProductCarouselState {
  final String error;

  ProductCarouselFailureState({required this.error});

  @override
  List<Object?> get props => [error];
}
