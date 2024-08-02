import 'package:commerce_flutter_app/features/domain/usecases/base_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class CategoryUseCase extends BaseUseCase {
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
