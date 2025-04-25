import 'package:commerce_flutter_sdk/features/domain/entity/product_details/product_details_price_entity.dart';
import 'package:equatable/equatable.dart';

abstract class ProductDetailsPricingState extends Equatable {}

class ProductDetailsPricingInitial extends ProductDetailsPricingState {
  @override
  List<Object?> get props => [];
}

class ProductDetailsPricingLoading extends ProductDetailsPricingState {
  @override
  List<Object?> get props => [];
}

class ProductDetailsPricingLoaded extends ProductDetailsPricingState {
  ProductDetailsPriceEntity productDetailsPriceEntity;

  ProductDetailsPricingLoaded({required this.productDetailsPriceEntity});

  @override
  List<Object?> get props => [productDetailsPriceEntity];
}

class ProductDetailsPricingErrorState extends ProductDetailsPricingState {
  final String errorMessage;

  ProductDetailsPricingErrorState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
