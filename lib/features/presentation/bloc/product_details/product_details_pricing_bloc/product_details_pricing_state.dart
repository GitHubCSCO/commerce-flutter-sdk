import 'package:commerce_flutter_app/features/domain/entity/product_details/product_details_price_entity.dart';

abstract class ProductDetailsPricingState {}

class ProductDetailsPricingInitial extends ProductDetailsPricingState {}

class ProductDetailsPricingLoading extends ProductDetailsPricingState {}

class ProductDetailsPricingLoaded extends ProductDetailsPricingState {
  ProductDetailsPriceEntity productDetailsPriceEntity;

  ProductDetailsPricingLoaded({required this.productDetailsPriceEntity});
}

class ProductDetailsPricingErrorState extends ProductDetailsPricingState {
  final String errorMessage;

  ProductDetailsPricingErrorState(this.errorMessage);
}
