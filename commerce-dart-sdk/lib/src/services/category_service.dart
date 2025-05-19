import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

/// Service which retrieves categories from Insite api.
class CategoryService extends ServiceBase implements ICategoryService {
  CategoryService({
    required super.clientService,
    required super.cacheService,
    required super.networkService,
  });

  List<Category> _flattenCategoryTree(List<Category>? categoryList) {
    List<Category> flattened = [];

    if (categoryList == null) {
      return flattened;
    }

    for (Category category in categoryList) {
      flattened.add(category);

      if (category.subCategories != null) {
        flattened.addAll(_flattenCategoryTree(category.subCategories));
      }
    }

    return flattened;
  }

  /// Gets a single category
  ///
  /// [categoryId]: Category id
  /// Returns: The category.
  @override
  Future<Result<Category, ErrorResponse>> getCategory(String categoryId) async {
    var urlString = '${CommerceAPIConstants.categoryUrl}/$categoryId';
    return await getAsyncNoCache<Category>(
      urlString,
      Category.fromJson,
    );
  }

  /// Gets a list of categories
  ///
  /// [startCategoryId]: Parent category or null for base level categories.
  /// [maxDepth]: depth of children to fetch.
  /// Returns: List of categories.
  @override
  Future<Result<List<Category>, ErrorResponse>> getCategoryList({
    CategoryQueryParameters? parameters,
  }) async {
    var url = Uri.parse(CommerceAPIConstants.categoryUrl);
    if (parameters != null) {
      url = url.replace(queryParameters: parameters.toJson());
    }

    var categoryResult = await getAsyncNoCache<CategoryResult>(
        url.toString(), CategoryResult.fromJson);

    switch (categoryResult) {
      case Success(value: final value):
        {
          return Success(value?.categories);
        }
      case Failure(errorResponse: final errorResponse):
        {
          return Failure(errorResponse);
        }
    }
  }

  @override
  Future<Result<List<Category>, ErrorResponse>> getFeaturedCategories({
    CategoryQueryParameters? parameters,
  }) async {
    var url = Uri.parse(CommerceAPIConstants.categoryUrl);
    if (parameters != null) {
      url = url.replace(queryParameters: parameters.toJson());
    }

    var categoryResult = await getAsyncNoCache<CategoryResult>(
        url.toString(), CategoryResult.fromJson);

    switch (categoryResult) {
      case Success(value: final value):
        {
          List<Category> featuredCategories =
              _flattenCategoryTree(value?.categories)
                  .where((c) => c.isFeatured!)
                  .toList();

          return Success(featuredCategories);
        }
      case Failure(errorResponse: final errorResponse):
        {
          return Failure(errorResponse);
        }
    }
  }

  @override
  Future<bool> hasCategoryCache(String categoryId) async {
    final url = "${CommerceAPIConstants.categoryUrl}/$categoryId";
    final sessionStateKey = await clientService.sessionStateKey;
    final key = (clientService.host ?? '') + url + (sessionStateKey ?? '');

    return await cacheService.hasOnlineCache(key);
  }
}
