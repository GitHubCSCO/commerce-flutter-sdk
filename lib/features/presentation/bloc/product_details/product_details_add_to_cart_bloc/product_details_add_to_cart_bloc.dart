import 'package:commerce_flutter_app/features/domain/usecases/porduct_details_usecase/product_details_style_traits_usecase.dart';
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
      {required ProductDetailsAddToCartUseCase productDetailsAddToCartUseCase,
      required ProductDetailsStyleTraitsUseCase
          productDetailsStyleTraitUseCase})
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

    productDetailsAddToCartEntity =
        _productDetailsAddToCartUseCase.updateAddToCartViewModel(productDetailsAddToCartEntity);
    emit(ProductDetailsAddtoCartSuccess(
        productDetailsAddToCartEntity: productDetailsAddToCartEntity));
  }

  Future<void> _onAddToCartEvent(
      AddToCartEvent event, Emitter<ProductDetailsAddtoCartState> emit) async {
    var product =
        event.productDetailsAddToCartEntity.productDetailsPriceEntity?.product;
    var styledProduct = event
        .productDetailsAddToCartEntity.productDetailsPriceEntity?.styledProduct;
    var productId = styledProduct?.productId ?? product?.id;
    var quantity = int.parse(event.productDetailsAddToCartEntity.quantityText!);
    List<SectionOptionDto> sectionOptions =
        event.productDetailsDataEntity.selectedConfigurations?.values.map((s) {
              return SectionOptionDto(
                sectionOptionId: s == null ? '' : s.sectionOptionId,
              );
            }).toList() ??
            [];
    String unitOfMeasure =
        event.productDetailsDataEntity.chosenUnitOfMeasure?.unitOfMeasure ?? '';
    var addCartLine = AddCartLine(
        productId: productId,
        unitOfMeasure: unitOfMeasure,
        qtyOrdered: quantity,
        sectionOptions: sectionOptions);

    final response =
        await _productDetailsAddToCartUseCase.addToCart(addCartLine);

    switch (response) {
      case Success(value: _):
        emit(ProductDetailsProdctAddedToCartSuccess());
        break;
      case Failure(errorResponse: final errorResponse):
        emit(
            ProductDetailsAddtoCartError(errorResponse.errorDescription ?? ''));
        break;
    }
  }
}
