import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

/// Service which retrieves categories from Insite api.
abstract class ICategoryService {
  /// Get a list of categories.
  ///
  /// [startCategoryId]: Parent category or null for base level categories.
  /// [maxDepth]: depth of children to fetch.
  /// Returns: List of categories.
  Future<Result<List<Category>, ErrorResponse>> getCategoryList(
      {CategoryQueryParameters? parameters});

  Future<Result<Category, ErrorResponse>> getCategory(String categoryId);

  Future<bool> hasCategoryCache(String categoryId);

  Future<Result<List<Category>, ErrorResponse>> getFeaturedCategories(
      {CategoryQueryParameters? parameters});
}
