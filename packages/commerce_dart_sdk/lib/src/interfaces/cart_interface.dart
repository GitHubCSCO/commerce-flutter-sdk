import 'package:commerce_dart_sdk/commerce_dart_sdk.dart';
import 'package:flutter/foundation.dart';

///
/// A service which manages the shopping cart
///
abstract class ICartService {
  ///
  /// Indicate last known IsCartEmpty state
  ///
  bool? isCartEmpty;

  VoidCallback? isCartEmptyPropertyChanged;
  void removeIsCartEmptyPropertyChanged();

  Future<ServiceResponse<Cart>> getCart(
      String cartId, CartQueryParameters parameters);

  ///
  /// This will create an Alternate Cart as opposed to regular cart, by setting AlternateCart cookie in cookie jar
  /// Any subsequent call to GetCurrentCart will give AlternateCart
  /// To get back to regular cart call GetRegularCart
  /// Or Remove cookie by calling RemoveAlternateCartCookie from IClientService
  ///
  Future<ServiceResponse<Cart>> createAlternateCart(AddCartModel addCartModel);

  Future<ServiceResponse<Cart>> getCurrentCart(CartQueryParameters parameters);

  Future<ServiceResponse<Cart>> getRegularCart(CartQueryParameters parameters);

  Future<ServiceResponse<GetCartLinesResult>> getCartLines();

  Future<ServiceResponse<PromotionCollectionModel>> getCurrentCartPromotions();

  Future<ServiceResponse<PromotionCollectionModel>> getCartPromotions(
      String cartId);

  Future<ServiceResponse<Promotion>> applyPromotion(AddPromotion promotion);

  Future<ServiceResponse<Cart>> updateCart(Cart cart);

  Future<bool> clearCart();

  Future<ServiceResponse<CartLineCollectionDto>> addWishListToCart(
      String wishListId);

  Future<ServiceResponse<CartCollectionModel>> getCarts(
      {CartsQueryParameters? parameters});

  Future<bool> deleteCart(String cartId);

  Future<ServiceResponse<Cart>> approveCart(Cart cart);

  ///
  /// CartLineService
  ///

  VoidCallback? onIsAddingToCartSlowChange;
  void removeIsAddingToCartSlowChange();

  bool get isAddingToCartSlow;

  int get addToCartRequestsCount;

  VoidCallback? onAddToCartRequestsCountChange;
  void removeAddToCartRequestsCountChange();

  Future<ServiceResponse<CartLine>> addCartLine(AddCartLine cartLine);

  void cancelAllAddCartLineFutures();

  Future<ServiceResponse<CartLine>> updateCartLine(CartLine cartLine);

  Future<bool> deleteCartLine(CartLine cartLine);

  Future<ServiceResponse<List<CartLine>>> addCartLineCollection(
      List<AddCartLine> cartLineCollection);
}
