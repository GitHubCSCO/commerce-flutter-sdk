import 'package:commerce_dart_sdk/commerce_dart_sdk.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class CartService extends ServiceBase implements ICartService {
  CartService({required super.clientService});

  CancelToken _cancellationTokenSource = CancelToken();

  List<AddCartLine> _addToCartRequests = [];
  bool _isAddingToCartSlow = false;

  bool? _isCartEmpty;

  @override
  bool? get isCartEmpty => _isCartEmpty;

  @override
  set isCartEmpty(bool? value) {
    if (_isCartEmpty != value) {
      _isCartEmpty = value;
      isCartEmptyPropertyChanged?.call();
    }
  }

  @Deprecated('Caution: Will be removed in a future release.')
  void _markCurrentlyAddingCartLinesFlagToTrueIfNeeded() async {
    await Future.delayed(const Duration(
        milliseconds: CommerceAPIConstants.addingToCartMillisecondsDelay));

    if (_addToCartRequests.isNotEmpty) {
      _isAddingToCartSlow = true;
      onIsAddingToCartSlowChange?.call();
    }
  }

  @Deprecated('Caution: Will be removed in a future release.')
  void _markCurrentlyAddingCartLinesFlagToFalseIfPossible() {
    if (_addToCartRequests.isEmpty) {
      _isAddingToCartSlow = false;
      onIsAddingToCartSlowChange?.call();
    }
  }

  @override
  Future<ServiceResponse<CartLine>> addCartLine(AddCartLine cartLine) async {
    final ServiceResponse<CartLine> response;
    try {
      _addToCartRequests.add(cartLine);
      onAddToCartRequestsCountChange?.call();
      _markCurrentlyAddingCartLinesFlagToTrueIfNeeded();

      var url = Uri.parse(CommerceAPIConstants.cartCurrentCartLineUrl);
      final data = await serializeToJson(
          cartLine, (AddCartLine addCartLine) => addCartLine.toJson());

      response = await postAsyncNoCache<CartLine>(
        url.toString(),
        data,
        CartLine.fromJson,
        cancelToken: _cancellationTokenSource,
      );
    } finally {
      _addToCartRequests.remove(cartLine);
      onAddToCartRequestsCountChange?.call();
      _markCurrentlyAddingCartLinesFlagToFalseIfPossible();
    }

    return response;
  }

  @override
  Future<ServiceResponse<List<CartLine>>> addCartLineCollection(
    List<AddCartLine> cartLineCollection,
  ) async {
    try {
      final data = {'cartLines': cartLineCollection};

      final response = await postAsyncNoCache<CartLineList>(
        '${CommerceAPIConstants.cartCurrentCartLineUrl}/batch',
        data,
        CartLineList.fromJson,
      );

      return ServiceResponse<List<CartLine>>(
        model: response.model?.cartLines,
        statusCode: response.statusCode,
        error: response.error,
        exception: response.exception,
        isCached: response.isCached,
      );
    } catch (e) {
      return ServiceResponse<List<CartLine>>(
          exception: Exception(e.toString()));
    }
  }

  @override
  int get addToCartRequestsCount => _addToCartRequests.length;

  @override
  Future<ServiceResponse<CartLineCollectionDto>> addWishListToCart(
      String wishListId) async {
    try {
      return await postAsyncNoCache<CartLineCollectionDto>(
        "api/v1/carts/current/cartlines/wishlist/$wishListId",
        {},
        CartLineCollectionDto.fromJson,
      );
    } catch (e) {
      return ServiceResponse<CartLineCollectionDto>(
          exception: Exception(e.toString()));
    }
  }

  @override
  Future<ServiceResponse<Promotion>> applyPromotion(
      AddPromotion promotion) async {
    try {
      var url = Uri.parse(CommerceAPIConstants.cartCurrentPromotionsUrl);
      final data = await serializeToJson(
          promotion, (AddPromotion addPromotion) => addPromotion.toJson());

      final response = await postAsyncNoCache<Promotion>(
          url.toString(), data, Promotion.fromJson);

      return response;
    } catch (e) {
      return ServiceResponse<Promotion>(exception: Exception(e.toString()));
    }
  }

  @override
  Future<ServiceResponse<Cart>> approveCart(Cart cart) async {
    final cartId = cart.id;
    if (cartId.isNullOrEmpty) throw Exception('cartId is empty');

    try {
      var url = Uri.parse('${CommerceAPIConstants.cartsUrl}/$cartId');
      final data = await serializeToJson(cart, (Cart cart) => cart.toJson());

      final response =
          await patchAsyncNoCache<Cart>(url.toString(), data, Cart.fromJson);

      return response;
    } catch (e) {
      return ServiceResponse<Cart>(exception: Exception(e.toString()));
    }
  }

  @override
  @Deprecated('Caution: Will be removed in a future release.')
  void cancelAllAddCartLineFutures() {
    _cancellationTokenSource.cancel();
    _cancellationTokenSource = CancelToken();
  }

  @override
  Future<bool> clearCart() async {
    try {
      var url = Uri.parse(CommerceAPIConstants.cartCurrentUrl);
      final clearCartResponse = await deleteAsync(url.toString());

      bool result = clearCartResponse.model != null &&
          StatusCodeExtension.isSuccessStatusCode(
              clearCartResponse.model!.statusCode);

      if (result) {
        isCartEmpty = true;
      }

      return result;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<ServiceResponse<Cart>> createAlternateCart(
      AddCartModel addCartModel) async {
    return await _getCart(
      addCartModel: addCartModel,
      cartType: CartType.alternate,
    );
  }

  @override
  Future<bool> deleteCart(String cartId) async {
    if (cartId.isEmpty) throw Exception('cartId is empty');

    try {
      var url = Uri.parse('${CommerceAPIConstants.cartsUrl}/$cartId');
      final deleteCartResponse = await deleteAsync(url.toString());

      return deleteCartResponse.model != null &&
          StatusCodeExtension.isSuccessStatusCode(
              deleteCartResponse.model!.statusCode);
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> deleteCartLine(CartLine cartLine) async {
    try {
      var url = Uri.parse(
          '${CommerceAPIConstants.cartCurrentCartLineUrl}/${cartLine.id}');
      final deleteCartLineResponse = await deleteAsync(url.toString());

      return deleteCartLineResponse.statusCode != null &&
          StatusCodeExtension.isSuccessStatusCode(
              deleteCartLineResponse.statusCode!);
    } catch (e) {
      return false;
    }
  }

  @override
  Future<ServiceResponse<Cart>> getCart(
      String cartId, CartQueryParameters parameters) async {
    try {
      var url = Uri.parse('${CommerceAPIConstants.cartsUrl}/$cartId');
      final parametersMap = await compute(
          (CartQueryParameters parameters) => parameters.toJson(), parameters);

      url = url.replace(queryParameters: parametersMap);
      final urlString = url.toString();

      final response = await getAsyncNoCache<Cart>(urlString, Cart.fromJson);
      isCartEmpty = response.model?.cartLines == null ||
          response.model!.cartLines!.isEmpty;

      return response;
    } catch (e) {
      return ServiceResponse<Cart>(exception: Exception(e.toString()));
    }
  }

  Future<ServiceResponse<Cart>> _getCart({
    AddCartModel? addCartModel,
    CartType cartType = CartType.regular,
    CartQueryParameters? parameters,
  }) async {
    try {
      var url = Uri.parse(CommerceAPIConstants.cartCurrentUrl);
      final ServiceResponse<Cart> response;

      if (cartType == CartType.alternate) {
        url = Uri.parse(CommerceAPIConstants.cartsUrl);
        final data = await serializeToJson(addCartModel!,
            (AddCartModel addCartModel) => addCartModel.toJson());

        response =
            await postAsyncNoCache<Cart>(url.toString(), data, Cart.fromJson);
      } else {
        if (cartType == CartType.regular) {
          await clientService.removeAlternateCartCookie();
        }

        String urlString = url.toString();
        if (parameters != null) {
          urlString =
              url.replace(queryParameters: parameters.toJson()).toString();
        }

        response = await getAsyncNoCache<Cart>(urlString, Cart.fromJson);
      }

      isCartEmpty = response.model?.cartLines == null ||
          response.model!.cartLines!.isEmpty;

      return response;
    } catch (e) {
      return ServiceResponse<Cart>(exception: Exception(e.toString()));
    }
  }

  @override
  Future<ServiceResponse<GetCartLinesResult>> getCartLines() async {
    try {
      var url = Uri.parse(CommerceAPIConstants.cartCurrentCartLinesUrl);
      final response = await getAsyncNoCache<GetCartLinesResult>(
          url.toString(), GetCartLinesResult.fromJson);

      isCartEmpty = response.model?.cartLines == null ||
          response.model!.cartLines!.isEmpty;

      return response;
    } catch (e) {
      return ServiceResponse<GetCartLinesResult>(
          exception: Exception(e.toString()));
    }
  }

  @override
  Future<ServiceResponse<PromotionCollectionModel>> getCartPromotions(
    String cartId,
  ) async {
    try {
      var url = Uri.parse(
          CommerceAPIConstants.cartPromotionsUrl.replaceAll('{0}', cartId));

      final response = await getAsyncNoCache<PromotionCollectionModel>(
        url.toString(),
        PromotionCollectionModel.fromJson,
      );

      return response;
    } catch (e) {
      return ServiceResponse<PromotionCollectionModel>(
          exception: Exception(e.toString()));
    }
  }

  @override
  Future<ServiceResponse<CartCollectionModel>> getCarts({
    CartsQueryParameters? parameters,
  }) async {
    try {
      var url = Uri.parse(CommerceAPIConstants.cartsUrl);

      if (parameters != null) {
        final parametersMap = await compute(
            (CartsQueryParameters parameters) => parameters.toJson(),
            parameters);

        url = url.replace(queryParameters: parametersMap);
      }

      final urlString = url.toString();

      final response = await getAsyncNoCache<CartCollectionModel>(
          urlString, CartCollectionModel.fromJson);

      return response;
    } catch (e) {
      return ServiceResponse<CartCollectionModel>(
          exception: Exception(e.toString()));
    }
  }

  @override
  Future<ServiceResponse<Cart>> getCurrentCart(
      CartQueryParameters parameters) async {
    return await _getCart(parameters: parameters, cartType: CartType.current);
  }

  @override
  Future<ServiceResponse<PromotionCollectionModel>>
      getCurrentCartPromotions() async {
    try {
      var url = Uri.parse(CommerceAPIConstants.cartCurrentPromotionsUrl);
      final response = await getAsyncNoCache<PromotionCollectionModel>(
        url.toString(),
        PromotionCollectionModel.fromJson,
      );

      return response;
    } catch (e) {
      return ServiceResponse<PromotionCollectionModel>(
          exception: Exception(e.toString()));
    }
  }

  @override
  Future<ServiceResponse<Cart>> getRegularCart(
    CartQueryParameters parameters,
  ) async {
    return await _getCart(parameters: parameters, cartType: CartType.regular);
  }

  @override
  bool get isAddingToCartSlow => _isAddingToCartSlow;

  @override
  Future<ServiceResponse<Cart>> updateCart(Cart cart) async {
    try {
      var url = Uri.parse(CommerceAPIConstants.cartCurrentUrl);
      final data = await serializeToJson(cart, (Cart cart) => cart.toJson());

      final response =
          await patchAsyncNoCache<Cart>(url.toString(), data, Cart.fromJson);

      return response;
    } catch (e) {
      return ServiceResponse<Cart>(exception: Exception(e.toString()));
    }
  }

  @override
  Future<ServiceResponse<CartLine>> updateCartLine(CartLine cartLine) async {
    try {
      var url = Uri.parse(
          '${CommerceAPIConstants.cartCurrentCartLineUrl}/${cartLine.id}');
      final data = await serializeToJson(
          cartLine, (CartLine cartLine) => cartLine.toJson());

      final response = await patchAsyncNoCache<CartLine>(
          url.toString(), data, CartLine.fromJson);

      return response;
    } catch (e) {
      return ServiceResponse<CartLine>(exception: Exception(e.toString()));
    }
  }

  @override
  VoidCallback? isCartEmptyPropertyChanged;

  @override
  void removeIsCartEmptyPropertyChanged() {
    isCartEmptyPropertyChanged = null;
  }

  @override
  VoidCallback? onIsAddingToCartSlowChange;

  @override
  void removeIsAddingToCartSlowChange() {
    onIsAddingToCartSlowChange = null;
  }

  @override
  VoidCallback? onAddToCartRequestsCountChange;

  @override
  void removeAddToCartRequestsCountChange() {
    onAddToCartRequestsCountChange = null;
  }
}
