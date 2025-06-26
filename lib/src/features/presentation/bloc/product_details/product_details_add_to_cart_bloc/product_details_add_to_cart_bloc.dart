import 'package:commerce_flutter_sdk/src/core/constants/analytics_constants.dart';
import 'package:commerce_flutter_sdk/src/core/constants/site_message_constants.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/analytics_event.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/telemetry_event.dart';
import 'package:commerce_flutter_sdk/src/features/domain/extensions/product_extensions.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/porduct_details_usecase/product_details_style_traits_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/porduct_details_usecase/product_details_add_to_cart_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/product_details/product_details_add_to_cart_bloc/product_details_add_to_cart_event.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/product_details/product_details_add_to_cart_bloc/product_details_add_to_cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class ProductDetailsAddToCartBloc
    extends Bloc<ProductDetailsAddToCartEvent, ProductDetailsAddtoCartState> {
  final ProductDetailsAddToCartUseCase _productDetailsAddToCartUseCase;
  String quantityText = '1';
  String messageAddToCartSuccess =
      SiteMessageConstants.defaultValueAddToCartSuccess;
  String messageAddtoCartFail = SiteMessageConstants.defaultValueAddToCartFail;
  String messageAddToCartQuantityAdjusted =
      SiteMessageConstants.defaultValueAddToCartQuantityAdjusted;
  String messageAddtoCartFailInvalidPrice =
      SiteMessageConstants.defaultValueCartInvalidPrice;

  ProductDetailsAddToCartBloc(
      {required ProductDetailsAddToCartUseCase productDetailsAddToCartUseCase,
      required ProductDetailsStyleTraitsUseCase
          productDetailsStyleTraitUseCase})
      : _productDetailsAddToCartUseCase = productDetailsAddToCartUseCase,
        super(ProductDetailsAddtoCartInitial()) {
    on<LoadProductDetailsAddToCartEvent>(
        (event, emit) => _fetchProductDetailsAddToCartData(event, emit));
    on<AddToCartEvent>((event, emit) => _onAddToCartEvent(event, emit));
    on<AddToCartUpdateQuantityEvent>(
        (event, emit) => _onAddToCartUpdateQuantity(event.quantityText!));
  }

  void _onAddToCartUpdateQuantity(String quantityText) {
    this.quantityText = quantityText;
  }

  Future<void> _fetchProductDetailsAddToCartData(
      LoadProductDetailsAddToCartEvent event,
      Emitter<ProductDetailsAddtoCartState> emit) async {
    emit(ProductDetailsAddtoCartLoading());

    var productDetailsAddToCartEntity = event.productDetailsAddToCartEntity;

    await _loadSiteMessages();

    productDetailsAddToCartEntity = _productDetailsAddToCartUseCase
        .updateAddToCartViewModel(productDetailsAddToCartEntity);
    emit(ProductDetailsAddtoCartSuccess(
        productDetailsAddToCartEntity: productDetailsAddToCartEntity));
  }

  Future<void> _onAddToCartEvent(
      AddToCartEvent event, Emitter<ProductDetailsAddtoCartState> emit) async {
    trackAddToCardEvent(
        event.productDetailsAddToCartEntity.productDetailsPriceEntity?.product
                ?.getProductNumber() ??
            "",
        event.productDetailsAddToCartEntity.quantityText!);
    var product =
        event.productDetailsAddToCartEntity.productDetailsPriceEntity?.product;
    var styledProduct = event
        .productDetailsAddToCartEntity.productDetailsPriceEntity?.styledProduct;
    var productId = styledProduct?.productId ?? product?.id;
    var quantity = int.parse(event.productDetailsAddToCartEntity.quantityText!);

    if (product?.allowZeroPricing != true &&
        product?.pricing != null &&
        product?.pricing?.unitNetPrice == 0) {
      emit(ProductDetailsAddToCartInvalidPrice());
      return;
    }

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
      case Success(value: final data):
        if (data != null && data.isQtyAdjusted == true) {
          emit(ProductDetailsAddtoCartWarning());
        } else if (data != null) {
          emit(ProductDetailsProdctAddedToCartSuccess());
        } else {
          emit(ProductDetailsAddtoCartError());
        }

        break;
      case Failure(errorResponse: final errorResponse):
        emit(ProductDetailsAddtoCartError(
            errorMessage: errorResponse.errorDescription));
        break;
    }
  }

  Future<void> _loadSiteMessages() async {
    final futureResult = await Future.wait([
      _productDetailsAddToCartUseCase.getSiteMessage(
        SiteMessageConstants.nameAddToCartSuccess,
        SiteMessageConstants.defaultValueAddToCartSuccess,
      ),
      _productDetailsAddToCartUseCase.getSiteMessage(
        SiteMessageConstants.nameAddToCartFail,
        SiteMessageConstants.defaultValueAddToCartFail,
      ),
      _productDetailsAddToCartUseCase.getSiteMessage(
        SiteMessageConstants.nameAddToCartQuantityAdjusted,
        SiteMessageConstants.defaultValueAddToCartQuantityAdjusted,
      ),
      _productDetailsAddToCartUseCase.getSiteMessage(
        SiteMessageConstants.nameCartInvalidPrice,
        SiteMessageConstants.defaultValueCartInvalidPrice,
      ),
    ]);

    messageAddToCartSuccess = futureResult[0];
    messageAddtoCartFail = futureResult[1];
    messageAddToCartQuantityAdjusted = futureResult[2];
    messageAddtoCartFailInvalidPrice = futureResult[3];

    return;
  }

  void trackAddToCardEvent(String productNumber, String qty) {
    var analyticsEvent = AnalyticsEvent(AnalyticsConstants.eventAddToCart,
            AnalyticsConstants.screenNameProductDetail)
        .withProperty(
            name: AnalyticsConstants.eventPropertyProductNumber,
            strValue: productNumber)
        .withProperty(name: AnalyticsConstants.eventPropertyQty, strValue: qty);

    var telemetryEvent = TelemetryEvent(
      eventName: AnalyticsConstants.eventAddToCart,
      properties: {
        AnalyticsConstants.eventPropertyProductNumber: productNumber,
        AnalyticsConstants.eventPropertyQty: qty,
      },
    );

    _productDetailsAddToCartUseCase.trackTelemetryEvent(telemetryEvent);

    _productDetailsAddToCartUseCase.trackEvent(analyticsEvent);
  }
}
