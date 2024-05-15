import 'package:commerce_flutter_app/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/style_value_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/styled_product_entity.dart';
import 'package:commerce_flutter_app/features/domain/usecases/base_usecase.dart';
import 'package:commerce_flutter_app/features/domain/usecases/porduct_details_usecase/product_details_style_traits_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class ProductDetailsAddToCartUseCase extends BaseUseCase {
  ProductDetailsAddToCartUseCase() : super();
  final ProductDetailsStyleTraitsUseCase _productDetailsStyleTraitsUseCase =
      ProductDetailsStyleTraitsUseCase();
  Future<Result<CartLine, ErrorResponse>> addToCart(
      AddCartLine addcartLine) async {
    var result = await commerceAPIServiceProvider
        .getCartService()
        .addCartLine(addcartLine);
    switch (result) {
      case Success(value: final data):
        return Success(data);
      case Failure(errorResponse: final errorResponse):
        return Failure(errorResponse);
    }
  }

  Future<bool> isOnline() async {
    return await commerceAPIServiceProvider.getNetworkService().isOnline();
  }

  Future<bool> getAddToCartVisibility(
      int quantity,
      bool hasCheckout,
      bool addToCartEnabled,
      ProductEntity productEntity,
      StyledProductEntity? styledProduct,
      Map<String, StyleValueEntity?>? selectedStyleValues,
      bool isProductConfigurable,
      bool isProductConfigurationCompleted) async {
    var isOnlineNow = await isOnline();
    var isAddToCartButtonAvailable = isOnlineNow && hasCheckout;
    isAddToCartButtonAvailable &= addToCartEnabled;
    isAddToCartButtonAvailable &= !productEntity.cantBuy!;
    isAddToCartButtonAvailable &=
        productEntity.allowedAddToCart! && !productEntity.canConfigure!;

    return isAddToCartButtonAvailable;
  }

  Future<bool> getAddToCartEnableState(
      int quantity,
      bool hasCheckout,
      bool addToCartEnabled,
      ProductEntity productEntity,
      StyledProductEntity? styledProduct,
      Map<String, StyleValueEntity?>? selectedStyleValues,
      bool isProductConfigurable,
      bool isProductConfigurationCompleted) async {
    var isAddToCartVisible = await getAddToCartVisibility(
        quantity,
        hasCheckout,
        addToCartEnabled,
        productEntity,
        styledProduct,
        selectedStyleValues,
        isProductConfigurable,
        isProductConfigurationCompleted);
    if (isAddToCartVisible) {
      var isAddToCartButtonEnabled = true;

      if (_productDetailsStyleTraitsUseCase
          .isProductStyleable(selectedStyleValues)) {
        isAddToCartButtonEnabled = _productDetailsStyleTraitsUseCase
            .isProductStyleSelectionCompleted(selectedStyleValues);
      }

      if (isProductConfigurable) {
        isAddToCartButtonEnabled = isProductConfigurationCompleted;
      }

      isAddToCartButtonEnabled &= quantity > 0;
      isAddToCartButtonEnabled = isAddToCartButtonEnabled &
          ((styledProduct == null
                  ? productEntity.availability?.messageType != 2
                  : styledProduct.availability?.messageType != 2) ||
              productEntity.canBackOrder!);

      return isAddToCartButtonEnabled;
    } else {
      return false;
    }
  }
}
