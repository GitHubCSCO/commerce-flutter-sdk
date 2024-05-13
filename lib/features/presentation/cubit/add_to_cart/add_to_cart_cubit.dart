import 'package:commerce_flutter_app/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_app/features/domain/mapper/product_mapper.dart';
import 'package:commerce_flutter_app/features/domain/usecases/search_usecase/add_to_cart_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/add_to_cart/add_to_cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class AddToCartCubit extends Cubit<AddToCartState> {
  final AddToCartUsecase _addToCartUsecase;

  AddToCartCubit({required AddToCartUsecase addToCartUsecase})
      : _addToCartUsecase = addToCartUsecase,
        super(AddToCartInitial());

  Future<void> searchPorductAddToCard(String productId) async {
    var addCartLine = AddCartLine(
      productId: productId,
    );

    final response = await _addToCartUsecase.addToCart(addCartLine);

    switch (response) {
      case Success(value: final data):
        emit(AddToCartSuccess());
        break;
      case Failure(errorResponse: final errorResponse):
        emit(AddToCartFailure(
            errorResponse: errorResponse.errorDescription ?? ''));
        break;
    }
  }

  Future<void> updateAddToCartButton(ProductEntity product) async {

    emit(AddToCartButtonLoading());
    var realTimeInventory = await _addToCartUsecase
        .loadRealTimeInventory(ProductEntityMapper().toModel(product));

    num qtyOnHand;

    if (realTimeInventory != null) {
      var inventory = realTimeInventory.realTimeInventoryResults
          ?.firstWhere((o) => o.productId == product.id);
      qtyOnHand = inventory!.qtyOnHand!;
      product = product.copyWith(qtyOnHand: qtyOnHand);
    }

    if (product.canAddToCart! &&
        !product.canBackOrder! &&
        product.trackInventory! &&
        product.qtyOnHand! <= 0) {
      product = product.copyWith(canAddToCart: false);
    }

    emit(AddToCartEnable(canAddToCart: product.canAddToCart!));
  }
}
