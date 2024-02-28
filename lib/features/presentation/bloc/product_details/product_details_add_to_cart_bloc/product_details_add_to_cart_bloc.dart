import 'package:commerce_flutter_app/core/constants/site_message_constants.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_details/product_details_add_to_cart_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_details/product_details_price_entity.dart';
import 'package:commerce_flutter_app/features/domain/extensions/product_pricing_extensions.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/product_details/product_details_add_to_cart_bloc/product_details_add_to_cart_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/product_details/product_details_add_to_cart_bloc/product_details_add_to_cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsAddToCartBloc
    extends Bloc<ProductDetailsAddToCartEvent, ProductDetailsAddtoCartState> {
  ProductDetailsAddToCartBloc() : super(ProductDetailsAddtoCartInitial()) {
    on<LoadProductDetailsAddToCartEvent>(
        (event, emit) => _fetchProductDetailsAddToCartData(event, emit));
  }

  Future<void> _fetchProductDetailsAddToCartData(
      LoadProductDetailsAddToCartEvent event,
      Emitter<ProductDetailsAddtoCartState> emit) async {
    emit(ProductDetailsAddtoCartLoading());
    var productDetailsAddToCartEntity = event.productDetailsAddToCartEntity;
    var productDetailsPriceEntity = event.productDetailsPriceEntity;

    productDetailsAddToCartEntity = updateAddToCartViewModel(
        productDetailsAddToCartEntity, productDetailsPriceEntity);
    emit(ProductDetailsAddtoCartSuccess(
        productDetailsAddToCartEntity: productDetailsAddToCartEntity));
  }

  ProductDetailsAddtoCartEntity updateAddToCartViewModel(
      ProductDetailsAddtoCartEntity productDetailsAddtoCartEntity,
      ProductDetailsPriceEntity productDetailsPriceEntity) {
    if (productDetailsAddtoCartEntity == null) {
      return productDetailsAddtoCartEntity;
    }
    //var alternateUnitsOfMeasureEnabled = true;
    var quantity = int.parse(productDetailsAddtoCartEntity.quantityText!);
    var styledProduct = productDetailsPriceEntity.styledProduct;
    var product = productDetailsPriceEntity.product;

    var productUnitOfMeasures = styledProduct == null
        ? product?.productUnitOfMeasures
        : styledProduct.productUnitOfMeasures;

    if (productUnitOfMeasures != null && productUnitOfMeasures.isNotEmpty) {
      productDetailsAddtoCartEntity = productDetailsAddtoCartEntity.copyWith(
        isUnitOfMeasuresVisible: productUnitOfMeasures.length > 1,
        // productUnitOfMeasures: List<ProductUnitOfMeasure>.from(productUnitOfMeasures),
        // selectedUnitOfMeasure: chosenUnitOfMeasure
      );
    } else {
      productDetailsAddtoCartEntity = productDetailsAddtoCartEntity.copyWith(
          isUnitOfMeasuresVisible: false,
          // productUnitOfMeasures: <ProductUnitOfMeasure>[],
          selectedUnitOfMeasure: null);
    }

    // update subtotal value
    var isQuoteRequired = styledProduct != null
        ? styledProduct.quoteRequired
        : product?.quoteRequired;
    var shouldHideSubtotalValue = quantity < 1 || isQuoteRequired!;

    if (shouldHideSubtotalValue || productDetailsPriceEntity.pricing == null) {
      productDetailsAddtoCartEntity =
          productDetailsAddtoCartEntity.copyWith(subtotalValueText: '');
    } else if (productDetailsPriceEntity.pricing?.extendedUnitNetPriceDisplay ==
        null) {
      productDetailsAddtoCartEntity = productDetailsAddtoCartEntity.copyWith(
          subtotalValueText: SiteMessageConstants.valueRealTimePricingLoadFail);
    } else if (productDetailsPriceEntity.pricing?.extendedUnitNetPrice == 0) {
      productDetailsAddtoCartEntity = productDetailsAddtoCartEntity.copyWith(
          subtotalValueText: SiteMessageConstants.valuePricingZeroPriceMessage);
    } else {
      productDetailsAddtoCartEntity = productDetailsAddtoCartEntity.copyWith(
          subtotalValueText:
              productDetailsPriceEntity.pricing?.extendedUnitNetPriceDisplay);
    }

    productDetailsAddtoCartEntity = productDetailsAddtoCartEntity.copyWith(
        selectedUnitOfMeasureValueText: productDetailsPriceEntity.pricing
            .getUnitOfMeasure(
                productDetailsAddtoCartEntity.selectedUnitOfMeasureValueText ??
                    ''));

    return productDetailsAddtoCartEntity;
  }
}
