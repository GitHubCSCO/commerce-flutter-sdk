import 'package:equatable/equatable.dart';

abstract class ProductIdFetchState extends Equatable {
  const ProductIdFetchState();

  @override
  List<Object> get props => [];
}

class ProductIdFetchInitial extends ProductIdFetchState {}

class ProductIdFetchLoading extends ProductIdFetchState {}

class ProductIdFetchSuccess extends ProductIdFetchState {
  final String productId;

  const ProductIdFetchSuccess({required this.productId});

  @override
  List<Object> get props => [productId];
}

class ProductIdFetchFailure extends ProductIdFetchState {
  final String errorMessage;

  const ProductIdFetchFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
