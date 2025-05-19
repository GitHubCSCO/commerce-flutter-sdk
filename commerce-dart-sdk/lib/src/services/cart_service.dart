import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:dio/dio.dart';

class CartService extends ServiceBase implements ICartService {
  CartService({
    required super.clientService,
    required super.cacheService,
    required super.networkService,
  });

  CancelToken _cancellationTokenSource = CancelToken();

  final List<AddCartLine> _addToCartRequests = [];
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
  Future<Result<CartLine, ErrorResponse>> addCartLine(
      AddCartLine cartLine) async {
    Result<dynamic, ErrorResponse> response;
    try {
      _addToCartRequests.add(cartLine);
      onAddToCartRequestsCountChange?.call();
      _markCurrentlyAddingCartLinesFlagToTrueIfNeeded();

      var url = Uri.parse(CommerceAPIConstants.cartCurrentCartLineUrl);
      final data = serialize(
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

    switch (response) {
      case Success(value: final value):
        {
          return Success(value);
        }
      case Failure(errorResponse: final errorResponse):
        {
          return Failure(errorResponse);
        }
    }
  }

  @override
  Future<Result<List<CartLine>, ErrorResponse>> addCartLineCollection(
    List<AddCartLine> cartLineCollection,
  ) async {
    final data = {'cartLines': cartLineCollection};

    final response = await postAsyncNoCache<CartLineList>(
      '${CommerceAPIConstants.cartCurrentCartLineUrl}/batch',
      data,
      CartLineList.fromJson,
    );

    switch (response) {
      case Success(value: final value):
        {
          return Success(value?.cartLines);
        }
      case Failure(errorResponse: final errorResponse):
        {
          return Failure(errorResponse);
        }
    }
  }

  @override
  int get addToCartRequestsCount => _addToCartRequests.length;

  @override
  Future<Result<CartLineCollectionDto, ErrorResponse>> addWishListToCart(
      String wishListId) async {
    return await postAsyncNoCache<CartLineCollectionDto>(
      "${CommerceAPIConstants.wishListAddToCartUrl}/$wishListId",
      {},
      CartLineCollectionDto.fromJson,
    );
  }

  @override
  Future<Result<Promotion, ErrorResponse>> applyPromotion(
      AddPromotion promotion) async {
    var url = Uri.parse(CommerceAPIConstants.cartCurrentPromotionsUrl);
    final data = serialize(
        promotion, (AddPromotion addPromotion) => addPromotion.toJson());

    return await postAsyncNoCache<Promotion>(
        url.toString(), data, Promotion.fromJson);
  }

  @override
  Future<Result<Cart, ErrorResponse>> approveCart(Cart cart) async {
    final cartId = cart.id;
    if (cartId.isNullOrEmpty) {
      throw Exception('cartId is empty');
    }

    var url = Uri.parse('${CommerceAPIConstants.cartsUrl}/$cartId');
    final data = serialize(cart, (Cart cart) => cart.toJson());

    return await patchAsyncNoCache<Cart>(url.toString(), data, Cart.fromJson);
  }

  @override
  @Deprecated('Caution: Will be removed in a future release.')
  void cancelAllAddCartLineFutures() {
    _cancellationTokenSource.cancel();
    _cancellationTokenSource = CancelToken();
  }

  @override
  Future<Result<bool, ErrorResponse>> clearCart() async {
    var url = Uri.parse(CommerceAPIConstants.cartCurrentUrl);
    final clearCartResponse = await deleteAsync(url.toString());

    switch (clearCartResponse) {
      case Success(value: final value):
        {
          bool result =
              value != null && StatusCodeExtension.isSuccessStatusCode(value);

          if (result) {
            isCartEmpty = true;
          }

          return Success(result);
        }
      case Failure(errorResponse: final errorResponse):
        {
          return Failure(errorResponse);
        }
    }
  }

  @override
  Future<Result<Cart, ErrorResponse>> createAlternateCart(
      AddCartModel addCartModel) async {
    return await _getCart(
      addCartModel: addCartModel,
      cartType: CartType.alternate,
    );
  }

  @override
  Future<Result<bool, ErrorResponse>> deleteCart(String cartId) async {
    if (cartId.isEmpty) {
      Failure(ErrorResponse(message: 'cartId is empty'));
    }

    var url = Uri.parse('${CommerceAPIConstants.cartsUrl}/$cartId');
    final deleteCartResponse = await deleteAsync(url.toString());

    switch (deleteCartResponse) {
      case Success(value: final value):
        {
          bool data =
              value != null && StatusCodeExtension.isSuccessStatusCode(value);

          return Success(data);
        }
      case Failure(errorResponse: final errorResponse):
        {
          return Failure(errorResponse);
        }
    }
  }

  @override
  Future<Result<bool, ErrorResponse>> deleteCartLine(CartLine cartLine) async {
    var url = Uri.parse(
        '${CommerceAPIConstants.cartCurrentCartLineUrl}/${cartLine.id}');
    final deleteCartLineResponse = await deleteAsync(url.toString());

    switch (deleteCartLineResponse) {
      case Success(value: final value):
        {
          bool data =
              value != null && StatusCodeExtension.isSuccessStatusCode(value);

          return Success(data);
        }
      case Failure(errorResponse: final errorResponse):
        {
          return Failure(errorResponse);
        }
    }
  }

  @override
  Future<Result<Cart, ErrorResponse>> getCart(
      String cartId, CartQueryParameters parameters) async {
    var url = Uri.parse('${CommerceAPIConstants.cartsUrl}/$cartId');
    final parametersMap = parameters.toJson();

    url = url.replace(queryParameters: parametersMap);
    final urlString = url.toString();

    final response = await getAsyncNoCache<Cart>(urlString, Cart.fromJson);

    switch (response) {
      case Success(value: final value):
        {
          isCartEmpty = value?.cartLines == null || value!.cartLines!.isEmpty;

          return Success(value);
        }

      case Failure(errorResponse: final errorResponse):
        {
          return Failure(errorResponse);
        }
    }
  }

  Future<Result<Cart, ErrorResponse>> _getCart({
    AddCartModel? addCartModel,
    CartType cartType = CartType.regular,
    CartQueryParameters? parameters,
  }) async {
    var url = Uri.parse(CommerceAPIConstants.cartCurrentUrl);
    final Result<dynamic, ErrorResponse> response;

    if (cartType == CartType.alternate) {
      url = Uri.parse(CommerceAPIConstants.cartsUrl);
      final data = serialize(
          addCartModel!, (AddCartModel addCartModel) => addCartModel.toJson());

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

    switch (response) {
      case Success(value: final value):
        {
          isCartEmpty = value?.cartLines == null || value?.cartLines!.isEmpty;

          return Success(value);
        }
      case Failure(errorResponse: final errorResponse):
        {
          return Failure(errorResponse);
        }
    }
  }

  @override
  Future<Result<GetCartLinesResult, ErrorResponse>> getCartLines() async {
    var url = Uri.parse(CommerceAPIConstants.cartCurrentCartLinesUrl);
    final response = await getAsyncNoCache<GetCartLinesResult>(
        url.toString(), GetCartLinesResult.fromJson);

    switch (response) {
      case Success(value: final value):
        {
          isCartEmpty = value?.cartLines == null || value!.cartLines!.isEmpty;
          return Success(value);
        }
      case Failure(errorResponse: final errorResponse):
        {
          return Failure(errorResponse);
        }
    }
  }

  @override
  Future<Result<PromotionCollectionModel, ErrorResponse>> getCartPromotions(
    String cartId,
  ) async {
    var url = Uri.parse(
        CommerceAPIConstants.cartPromotionsUrl.replaceAll('{0}', cartId));

    return await getAsyncNoCache<PromotionCollectionModel>(
      url.toString(),
      PromotionCollectionModel.fromJson,
    );
  }

  @override
  Future<Result<CartCollectionModel, ErrorResponse>> getCarts({
    CartsQueryParameters? parameters,
  }) async {
    var url = Uri.parse(CommerceAPIConstants.cartsUrl);

    if (parameters != null) {
      final parametersMap = parameters.toJson();

      url = url.replace(queryParameters: parametersMap);
    }

    final urlString = url.toString();

    return await getAsyncNoCache<CartCollectionModel>(
        urlString, CartCollectionModel.fromJson);
  }

  @override
  Future<Result<Cart, ErrorResponse>> getCurrentCart(
      CartQueryParameters parameters) async {
    return await _getCart(parameters: parameters, cartType: CartType.current);
  }

  @override
  Future<Result<PromotionCollectionModel, ErrorResponse>>
      getCurrentCartPromotions() async {
    var url = Uri.parse(CommerceAPIConstants.cartCurrentPromotionsUrl);
    return await getAsyncNoCache<PromotionCollectionModel>(
      url.toString(),
      PromotionCollectionModel.fromJson,
    );
  }

  @override
  Future<Result<Cart, ErrorResponse>> getRegularCart(
    CartQueryParameters parameters,
  ) async {
    return await _getCart(parameters: parameters, cartType: CartType.regular);
  }

  @override
  bool get isAddingToCartSlow => _isAddingToCartSlow;

  @override
  Future<Result<Cart, ErrorResponse>> updateCart(Cart cart) async {
    var url = Uri.parse(CommerceAPIConstants.cartCurrentUrl);
    final data = serialize(cart, (Cart cart) => cart.toJson());

    return await patchAsyncNoCache<Cart>(url.toString(), data, Cart.fromJson);
  }

  @override
  Future<Result<CartLine, ErrorResponse>> updateCartLine(
      CartLine cartLine) async {
    var url = Uri.parse(
        '${CommerceAPIConstants.cartCurrentCartLineUrl}/${cartLine.id}');
    final data = serialize(cartLine, (CartLine cartLine) => cartLine.toJson());

    return await patchAsyncNoCache<CartLine>(
        url.toString(), data, CartLine.fromJson);
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
