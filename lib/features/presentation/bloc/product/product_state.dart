part of 'product_collection_bloc.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final GetProductCollectionResult? result;

  ProductLoaded({required this.result});
}

class ProductFailed extends ProductState {
  final String error;

  ProductFailed(this.error);
}
