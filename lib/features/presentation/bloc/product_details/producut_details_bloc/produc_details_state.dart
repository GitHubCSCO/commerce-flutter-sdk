import 'package:commerce_flutter_app/features/domain/entity/product_details/product_details_base_entity.dart';

abstract class ProductDetailsState {}

class ProductDetailsInitial extends ProductDetailsState {}

class ProductDetailsLoading extends ProductDetailsState {}

class ProductDetailsLoaded extends ProductDetailsState {
  List<ProductDetailsBaseEntity> productDetailsEntities = [];

  ProductDetailsLoaded({required this.productDetailsEntities});
}

class ProductDetailsErrorState extends ProductDetailsState {
  final String errorMessage;

  ProductDetailsErrorState(this.errorMessage);
}
