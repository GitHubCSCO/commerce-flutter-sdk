import 'dart:math';

import 'package:commerce_flutter_app/features/domain/entity/product_details/product_details_add_to_cart_entity.dart';
import 'package:equatable/equatable.dart';

abstract class ProductDetailsAddtoCartState extends Equatable {
  const ProductDetailsAddtoCartState();

  @override
  List<Object> get props => [];
}

class ProductDetailsAddtoCartInitial extends ProductDetailsAddtoCartState {}

class ProductDetailsAddtoCartLoading extends ProductDetailsAddtoCartState {}

// add to cart section load
class ProductDetailsAddtoCartSuccess extends ProductDetailsAddtoCartState {
  final ProductDetailsAddtoCartEntity productDetailsAddToCartEntity;
  ProductDetailsAddtoCartSuccess({required this.productDetailsAddToCartEntity});
}

class ProductDetailsAddtoCartError extends ProductDetailsAddtoCartState {
  final String errorMessage;

  const ProductDetailsAddtoCartError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

// product added to cart
class ProductDetailsProdctAddedToCartSuccess
    extends ProductDetailsAddtoCartState {
  @override
  List<Object> get props => [Random().nextDouble()];
}

class ProductDetailsProdctAddedToCartError
    extends ProductDetailsAddtoCartState {
  final String errorMessage;

  const ProductDetailsProdctAddedToCartError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
