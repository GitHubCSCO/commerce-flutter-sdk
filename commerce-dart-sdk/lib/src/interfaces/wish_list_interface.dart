import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

abstract class IWishListService {
  Future<Result<WishListCollectionModel, ErrorResponse>> getWishLists(
      WishListsQueryParameters parameters);

  Future<Result<WishList, ErrorResponse>> getWishList(
      String wishListId, WishListQueryParameters parameters);

  Future<Result<bool, ErrorResponse>> deleteWishList(String wishListId);

  Future<Result<WishList, ErrorResponse>> createWishList(
      CreateWishListQueryParameters parameters);

  Future<Result<WishList, ErrorResponse>> updateWishList(WishList wishList);

  Future<Result<WishListLine, ErrorResponse>> addProductToWishList(
      String wishListId, AddCartLine product);

  Future<Result<bool, ErrorResponse>> addWishListLinesToWishList(
      String wishListId, WishListAddToCartCollection wishListLines);

  Future<Result<bool, ErrorResponse>> leaveWishList(String wishListId);

  Future<Result<WishListLineCollectionModel, ErrorResponse>> getWishListLines(
      String wishListId, WishListLineQueryParameters parameters);

  Future<Result<bool, ErrorResponse>> deleteWishListLine(
      String wishListId, String wishListLineId);

  Future<Result<bool, ErrorResponse>> deleteWishListLineCollection(
      String wishListId, List<WishListLine>? wishListLineCollection);

  Future<Result<WishListLine, ErrorResponse>> updateWishListLine(
      String wishListId, WishListLine wishListLine);

  Future<Result<WishListLineCollectionModel, ErrorResponse>> copyWishListLines(
    String wishListId,
    WishListLineCollectionModel wishListLineCollection,
    String? copyFromWishListId,
  );
}
