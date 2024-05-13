import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:commerce_flutter_app/core/constants/site_message_constants.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_details/product_details_add_to_cart_entity.dart';
import 'package:commerce_flutter_app/features/domain/extensions/product_pricing_extensions.dart';
import 'package:commerce_flutter_app/features/domain/usecases/porduct_details_usecase/product_details_add_to_cart_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/product_details/product_details_add_to_cart_bloc/product_details_add_to_cart_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/product_details/product_details_add_to_cart_bloc/product_details_add_to_cart_state.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class ProductDetailsAddToCartBloc
    extends Bloc<ProductDetailsAddToCartEvent, ProductDetailsAddtoCartState> {
  final ProductDetailsAddToCartUseCase _productDetailsAddToCartUseCase;

  ProductDetailsAddToCartBloc(
      {required ProductDetailsAddToCartUseCase productDetailsAddToCartUseCase})
      : _productDetailsAddToCartUseCase = productDetailsAddToCartUseCase,
        super(ProductDetailsAddtoCartInitial()) {
    on<LoadProductDetailsAddToCartEvent>(
        (event, emit) => _fetchProductDetailsAddToCartData(event, emit));
    on<AddToCartEvent>((event, emit) => _onAddToCartEvent(event, emit));
  }

  Future<void> _fetchProductDetailsAddToCartData(
      LoadProductDetailsAddToCartEvent event,
      Emitter<ProductDetailsAddtoCartState> emit) async {
    emit(ProductDetailsAddtoCartLoading());
    var productDetailsAddToCartEntity = event.productDetailsAddToCartEntity;
    var productDetailsPriceEntity =
        event.productDetailsAddToCartEntity.productDetailsPriceEntity;

    productDetailsAddToCartEntity =
        updateAddToCartViewModel(productDetailsAddToCartEntity);
    emit(ProductDetailsAddtoCartSuccess(
        productDetailsAddToCartEntity: productDetailsAddToCartEntity));
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
        0) {
      productDetailsAddtoCartEntity = productDetailsAddtoCartEntity.copyWith(
          subtotalValueText: SiteMessageConstants.valuePricingZeroPriceMessage);
    } else {
      productDetailsAddtoCartEntity = productDetailsAddtoCartEntity.copyWith(
          subtotalValueText: productDetailsPriceEntity
              ?.product?.pricing?.extendedUnitNetPriceDisplay);
    }

    productDetailsAddtoCartEntity = productDetailsAddtoCartEntity.copyWith(
        selectedUnitOfMeasureValueText:
            productDetailsPriceEntity?.product?.pricing?.getUnitOfMeasure(
                productDetailsAddtoCartEntity.selectedUnitOfMeasureValueText ??
                    ''));

    return productDetailsAddtoCartEntity;
  }

  Future<void> _onAddToCartEvent(
      AddToCartEvent event, Emitter<ProductDetailsAddtoCartState> emit) async {
    // emit(ProductDetailsAddtoCartLoading());
    var product =
        event.productDetailsAddToCartEntity.productDetailsPriceEntity?.product;
    var styledProduct = event
        .productDetailsAddToCartEntity.productDetailsPriceEntity?.styledProduct;
    var productId = styledProduct?.productId ?? product?.id;
    var quantity = int.parse(event.productDetailsAddToCartEntity.quantityText!);
    var addCartLine = AddCartLine(
        productId: productId,
        unitOfMeasure: product?.unitOfMeasure,
        qtyOrdered: quantity);

    final response =
        await _productDetailsAddToCartUseCase.addToCart(addCartLine);

    switch (response) {
      case Success(value: final data):
        emit(ProductDetailsProdctAddedToCartSuccess());
        break;
      case Failure(errorResponse: final errorResponse):
        emit(
            ProductDetailsAddtoCartError(errorResponse.errorDescription ?? ''));
        break;
    }
  }
}
