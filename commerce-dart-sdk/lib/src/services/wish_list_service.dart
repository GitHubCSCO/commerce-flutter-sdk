import 'dart:io';

import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class WishListService extends ServiceBase implements IWishListService {
  WishListService({
    required super.clientService,
    required super.cacheService,
    required super.networkService,
  });

  String _getWishListUrl(String wishListId) =>
      "/api/v1/wishlists/$wishListId?expand=hiddenproducts,getalllines";

  @override
  Future<Result<WishListLine, ErrorResponse>> addProductToWishList(
    String wishListId,
    AddCartLine product,
  ) async {
    var url = Uri.parse('/api/v1/wishlists/$wishListId/wishlistlines');
    final data = product.toJson();
    final result = await postAsyncNoCache<WishListLine>(
      url.toString(),
      data,
      WishListLine.fromJson,
    );

    return result;
  }

  @override
  Future<Result<bool, ErrorResponse>> addWishListLinesToWishList(
    String wishListId,
    WishListAddToCartCollection wishListLines,
  ) async {
    var url = Uri.parse('/api/v1/wishlists/$wishListId/wishlistlines/batch');
    final data = wishListLines.toJson();

    final response = await postAsyncNoCache(
      url.toString(),
      data,
      WishListAddToCartCollection.fromJson,
    );

    switch (response) {
      case Success():
        {
          return const Success(true);
        }
      case Failure(errorResponse: final errorResponse):
        {
          return Failure(errorResponse);
        }
    }
  }

  @override
  Future<Result<WishList, ErrorResponse>> createWishList(
    CreateWishListQueryParameters parameters,
  ) async {
    var url = Uri.parse(CommerceAPIConstants.wishListUrl);
    final data = parameters.wishListObj!.toJson();

    final result = await postAsyncNoCache<WishList>(
      url.toString(),
      data,
      WishList.fromJson,
    );

    return result;
  }

  @override
  Future<Result<bool, ErrorResponse>> deleteWishList(String wishListId) async {
    final response = await deleteAsync('/api/v1/wishlists/$wishListId');

    switch (response) {
      case Success(value: final value):
        {
          bool result =
              value != null && StatusCodeExtension.isSuccessStatusCode(value);
          return Success(result);
        }
      case Failure(errorResponse: final errorResponse):
        {
          return Failure(errorResponse);
        }
    }
  }

  @override
  Future<Result<bool, ErrorResponse>> deleteWishListLine(
    String wishListId,
    String wishListLineId,
  ) async {
    final response = await deleteAsync(
        '/api/v1/wishlists/$wishListId/wishlistlines/$wishListLineId');

    switch (response) {
      case Success(value: final value):
        {
          bool result =
              value != null && StatusCodeExtension.isSuccessStatusCode(value);

          return Success(result);
        }
      case Failure(errorResponse: final errorResponse):
        {
          return Failure(errorResponse);
        }
    }
  }

  @override
  Future<Result<bool, ErrorResponse>> deleteWishListLineCollection(
    String wishListId,
    List<WishListLine>? wishListLineCollection,
  ) async {
    if (wishListLineCollection == null || wishListLineCollection.isEmpty) {
      return const Success(false);
    }

    String queryString =
        '?${wishListLineCollection.map((o) => 'wishListLineIds=${o.id}').join('&')}';

    final response = await deleteAsync(
        '/api/v1/wishlists/$wishListId/wishlistlines/batch$queryString');

    switch (response) {
      case Success(value: final value):
        {
          bool result =
              value != null && StatusCodeExtension.isSuccessStatusCode(value);

          return Success(result);
        }
      case Failure(errorResponse: final errorResponse):
        {
          return Failure(errorResponse);
        }
    }
  }

  @override
  Future<Result<WishList, ErrorResponse>> getWishList(
    String wishListId,
    WishListQueryParameters parameters,
  ) async {
    var url = Uri.parse(_getWishListUrl(wishListId));
    url = url.replace(queryParameters: parameters.toJson());

    return await getAsyncNoCache<WishList>(
      url.toString(),
      WishList.fromJson,
    );
  }

  @override
  Future<Result<WishListLineCollectionModel, ErrorResponse>> getWishListLines(
    String wishListId,
    WishListLineQueryParameters parameters,
  ) async {
    var url = Uri.parse(
        '${CommerceAPIConstants.wishListUrl}/$wishListId/wishlistlines');
    url = url.replace(queryParameters: parameters.toJson());

    return await getAsyncNoCache<WishListLineCollectionModel>(
      url.toString(),
      WishListLineCollectionModel.fromJson,
    );
  }

  @override
  Future<Result<WishListCollectionModel, ErrorResponse>> getWishLists(
      WishListsQueryParameters parameters) async {
    var url = Uri.parse(CommerceAPIConstants.wishListUrl);
    url = url.replace(queryParameters: parameters.toJson());

    return await getAsyncNoCache<WishListCollectionModel>(
      url.toString(),
      WishListCollectionModel.fromJson,
    );
  }

  /// If failure, treat it as success in the app
  @override
  Future<Result<bool, ErrorResponse>> leaveWishList(String wishListId) async {
    final response =
        await deleteAsync('/api/v1/wishlists/$wishListId/share/current');

    switch (response) {
      case Success(value: final value):
        {
          // A NotFound response is treated as successful because the user wanted to leave the list anyway.
          bool result =
              value != null && StatusCodeExtension.isSuccessStatusCode(value) ||
                  value == HttpStatus.notFound;

          return Success(result);
        }
      case Failure(errorResponse: final errorResponse):
        {
          return Failure(errorResponse);
        }
    }
  }

  @override
  Future<Result<WishList, ErrorResponse>> updateWishList(
      WishList wishList) async {
    var url = Uri.parse('/api/v1/wishlists/${wishList.id}');
    final data = wishList.toJson();

    final result = await patchAsyncNoCache<WishList>(
      url.toString(),
      data,
      WishList.fromJson,
    );
    return result;
  }

  @override
  Future<Result<WishListLine, ErrorResponse>> updateWishListLine(
    String wishListId,
    WishListLine wishListLine,
  ) async {
    final data = wishListLine.toJson();
    final response = await patchAsyncNoCache<WishListLine>(
      '/api/v1/wishlists/$wishListId/wishlistlines/${wishListLine.id}',
      data,
      WishListLine.fromJson,
    );

    return response;
  }

  @override
  Future<Result<WishListLineCollectionModel, ErrorResponse>> copyWishListLines(
    String wishListId,
    WishListLineCollectionModel wishListLineCollection,
    String? copyFromWishListId,
  ) async {
    final data = wishListLineCollection.toJson();
    final response = await postAsyncNoCache(
      '/api/v1/wishlists/$wishListId/wishlistlines/batch/${copyFromWishListId ?? ''}',
      data,
      WishListLineCollectionModel.fromJson,
    );
    return response;
  }

  @override
  Future<Result<bool, ErrorResponse>> addWishListTags(
    String wishListId,
    WishListTagCollectionModel wishListTags,
  ) async {
    var url = Uri.parse('/api/v1/wishlists/$wishListId/tags/batch');
    final data = wishListTags.toJson();

    final response = await postAsyncNoCache(
      url.toString(),
      data,
      WishListTagCollectionModel.fromJson,
    );

    switch (response) {
      case Success():
        {
          return Success(true);
        }
      case Failure(errorResponse: final errorResponse):
        {
          return Failure(errorResponse);
        }
    }
  }

  @override
  Future<Result<bool, ErrorResponse>> deleteWishListTags(
    String wishListId,
    List<String> wishListTagIds,
  ) async {
    if (wishListTagIds.isEmpty) {
      return const Success(false);
    }

    String queryString =
        '?${wishListTagIds.map((o) => 'wishListTagIds=$o').join('&')}';

    final response = await deleteAsync(
        '/api/v1/wishlists/$wishListId/tags/batch$queryString');

    switch (response) {
      case Success(value: final value):
        {
          bool result =
              value != null && StatusCodeExtension.isSuccessStatusCode(value);

          return Success(result);
        }
      case Failure(errorResponse: final errorResponse):
        {
          return Failure(errorResponse);
        }
    }
  }
}
