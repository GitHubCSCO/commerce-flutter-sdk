import 'package:commerce_flutter_app/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_app/features/domain/usecases/porduct_details_usecase/product_details_usecase.dart';

abstract class ProductDetailsState {}

class ProductDetailsInitial extends ProductDetailsState {}

class ProductDetailsLoading extends ProductDetailsState {}

class ProductDetailsLoaded extends ProductDetailsState {
  final ProductEntity product;
  List<ProdcutDeatilsPageWidgets> productDetailsWidgets = [];

  ProductDetailsLoaded(
      {required this.product, required this.productDetailsWidgets});
}

class ProductDetailsErrorState extends ProductDetailsState {
  final String errorMessage;

  ProductDetailsErrorState(this.errorMessage);
}
