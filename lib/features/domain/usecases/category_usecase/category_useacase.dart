import 'package:commerce_flutter_app/core/constants/core_constants.dart';
import 'package:commerce_flutter_app/features/domain/usecases/base_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class CategoryUseCase extends BaseUseCase {
  Future<Result<List<Category>, ErrorResponse>> getTopCategories() async {
    var startingCategoryId = await coreServiceProvider
        .getAppConfigurationService()
        .startingCategoryForBrowsing();
    if (startingCategoryId.isNullOrEmpty ||
        startingCategoryId == CoreConstants.emptyGuidString) {
      return getCategories();
    } else {
      var result = await getCategories(categoryId: startingCategoryId);
      if (result is Failure) {
        return getCategories();
      }
      return result;
    }
  }

  Future<Result<List<Category>, ErrorResponse>> getCategories(
      {String? categoryId}) async {
    final parameters = categoryId.isNullOrEmpty
        ? CategoryQueryParameters(maxDepth: 2)
        : CategoryQueryParameters(maxDepth: 2, startCategoryId: categoryId);

    final result = await commerceAPIServiceProvider
        .getCategoryService()
        .getCategoryList(parameters: parameters);
    return result;
  }
}
