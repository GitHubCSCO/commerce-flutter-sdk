import 'package:commerce_flutter_sdk/core/constants/site_message_constants.dart';
import 'package:commerce_flutter_sdk/features/domain/entity/product_details/product_details_add_to_cart_entity.dart';
import 'package:commerce_flutter_sdk/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_sdk/features/domain/entity/style_value_entity.dart';
import 'package:commerce_flutter_sdk/features/domain/entity/styled_product_entity.dart';
import 'package:commerce_flutter_sdk/features/domain/extensions/product_pricing_extensions.dart';
import 'package:commerce_flutter_sdk/features/domain/usecases/base_usecase.dart';
import 'package:commerce_flutter_sdk/features/domain/usecases/porduct_details_usecase/product_details_style_traits_usecase.dart';
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

  ProductDetailsAddtoCartEntity updateAddToCartViewModel(
      ProductDetailsAddtoCartEntity productDetailsAddtoCartEntity) {
    if (productDetailsAddtoCartEntity == null) {
      return productDetailsAddtoCartEntity;
    }
    //var alternateUnitsOfMeasureEnabled = true;

    var productDetailsPriceEntity =
        productDetailsAddtoCartEntity.productDetailsPriceEntity;

    var quantity = int.parse(productDetailsAddtoCartEntity.quantityText!);
    var styledProduct = productDetailsPriceEntity?.styledProduct;
    var product = productDetailsPriceEntity?.product;

    var productUnitOfMeasures = styledProduct == null
        ? product?.productUnitOfMeasures
        : styledProduct.productUnitOfMeasures;

    if (productUnitOfMeasures != null) {
      for (int i = 0; i < productUnitOfMeasures.length; i++) {
        var productUnitOfMeasure = productUnitOfMeasures[i];
        String? dataSouceItem;

        if (productUnitOfMeasure.description != null &&
            productUnitOfMeasure.description!.isNotEmpty) {
          dataSouceItem = productUnitOfMeasure.qtyPerBaseUnitOfMeasure! > 1
              ? '${productUnitOfMeasure.description} /${productUnitOfMeasure.qtyPerBaseUnitOfMeasure}'
              : productUnitOfMeasure.description;
        } else if (productUnitOfMeasure.unitOfMeasureDisplay != null &&
            productUnitOfMeasure.unitOfMeasureDisplay!.isNotEmpty) {
          dataSouceItem = productUnitOfMeasure.qtyPerBaseUnitOfMeasure! > 1
              ? '${productUnitOfMeasure.unitOfMeasureDisplay} /${productUnitOfMeasure.qtyPerBaseUnitOfMeasure}'
              : productUnitOfMeasure.unitOfMeasureDisplay;
        }

        productUnitOfMeasures[i] = productUnitOfMeasure.copyWith(
            unitOfMeasureTextDisplayWithQuantity: dataSouceItem);
      }
    }

    if (productUnitOfMeasures != null && productUnitOfMeasures.isNotEmpty) {
      productDetailsAddtoCartEntity = productDetailsAddtoCartEntity.copyWith(
          isUnitOfMeasuresVisible: productUnitOfMeasures.length > 1,
          productUnitOfMeasures: productUnitOfMeasures,
          selectedUnitOfMeasure: productUnitOfMeasures.first);
    } else {
      productDetailsAddtoCartEntity = productDetailsAddtoCartEntity.copyWith(
          isUnitOfMeasuresVisible: false,
          productUnitOfMeasures: [],
          selectedUnitOfMeasure: null);
    }

    // update subtotal value
    var isQuoteRequired = styledProduct != null
        ? styledProduct.quoteRequired
        : product?.quoteRequired;
    var shouldHideSubtotalValue = quantity < 1 || isQuoteRequired!;

    if (shouldHideSubtotalValue ||
        productDetailsPriceEntity?.product?.pricing == null) {
      productDetailsAddtoCartEntity =
          productDetailsAddtoCartEntity.copyWith(subtotalValueText: '');
    } else if (productDetailsPriceEntity
            ?.product?.pricing?.extendedUnitNetPriceDisplay ==
        null) {
      productDetailsAddtoCartEntity = productDetailsAddtoCartEntity.copyWith(
          subtotalValueText: SiteMessageConstants.valueRealTimePricingLoadFail);
    } else if (productDetailsPriceEntity
                ?.product?.pricing?.extendedUnitNetPrice ==
            0 &&
        productDetailsPriceEntity?.product?.allowZeroPricing != true) {
      productDetailsAddtoCartEntity = productDetailsAddtoCartEntity.copyWith(
          subtotalValueText: SiteMessageConstants.valuePricingZeroPriceMessage);
    } else {
      productDetailsAddtoCartEntity = productDetailsAddtoCartEntity.copyWith(
          subtotalValueText: productDetailsPriceEntity
              ?.product?.pricing?.extendedUnitNetPriceDisplay);
    }

    final hidePricingEnable =
        coreServiceProvider.getAppConfigurationService().hidePricingEnable;

    productDetailsAddtoCartEntity = productDetailsAddtoCartEntity.copyWith(
      selectedUnitOfMeasureValueText:
          productDetailsPriceEntity?.product?.pricing?.getUnitOfMeasure(
              productDetailsAddtoCartEntity.selectedUnitOfMeasureValueText ??
                  ''),
      hidePricing: hidePricingEnable,
    );

    return productDetailsAddtoCartEntity;
  }
}
