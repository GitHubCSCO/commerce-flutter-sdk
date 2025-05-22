import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

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

  Future<Result<Cart, ErrorResponse>> getCart(
      String cartId, CartQueryParameters parameters);

  ///
  /// This will create an Alternate Cart as opposed to regular cart, by setting AlternateCart cookie in cookie jar
  /// Any subsequent call to GetCurrentCart will give AlternateCart
  /// To get back to regular cart call GetRegularCart
  /// Or Remove cookie by calling RemoveAlternateCartCookie from IClientService
  ///
  Future<Result<Cart, ErrorResponse>> createAlternateCart(
      AddCartModel addCartModel);

  Future<Result<Cart, ErrorResponse>> getCurrentCart(
      CartQueryParameters parameters);

  Future<Result<Cart, ErrorResponse>> getRegularCart(
      CartQueryParameters parameters);

  Future<Result<GetCartLinesResult, ErrorResponse>> getCartLines();

  Future<Result<PromotionCollectionModel, ErrorResponse>>
      getCurrentCartPromotions();

  Future<Result<PromotionCollectionModel, ErrorResponse>> getCartPromotions(
      String cartId);

  Future<Result<Promotion, ErrorResponse>> applyPromotion(
      AddPromotion promotion);

  Future<Result<Cart, ErrorResponse>> updateCart(Cart cart);

  Future<Result<bool, ErrorResponse>> clearCart();

  Future<Result<CartLineCollectionDto, ErrorResponse>> addWishListToCart(
      String wishListId);

  Future<Result<CartCollectionModel, ErrorResponse>> getCarts(
      {CartsQueryParameters? parameters});

  Future<Result<bool, ErrorResponse>> deleteCart(String cartId);

  Future<Result<Cart, ErrorResponse>> approveCart(Cart cart);

  ///////////
  /// CartLineService
  /// /////////

  VoidCallback? onIsAddingToCartSlowChange;
  void removeIsAddingToCartSlowChange();

  bool get isAddingToCartSlow;

  int get addToCartRequestsCount;

  VoidCallback? onAddToCartRequestsCountChange;
  void removeAddToCartRequestsCountChange();

  Future<Result<CartLine, ErrorResponse>> addCartLine(AddCartLine cartLine);

  void cancelAllAddCartLineFutures();

  Future<Result<CartLine, ErrorResponse>> updateCartLine(CartLine cartLine);

  Future<Result<bool, ErrorResponse>> deleteCartLine(CartLine cartLine);

  Future<Result<List<CartLine>, ErrorResponse>> addCartLineCollection(
      List<AddCartLine> cartLineCollection);
}
