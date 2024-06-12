import 'package:commerce_flutter_app/features/domain/usecases/base_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class CategoryUseCase extends BaseUseCase {

  Future<Result<List<Category>, ErrorResponse>> getCategories() async {
    final parameters = CategoryQueryParameters(
      maxDepth: 2
    );

    final result = await commerceAPIServiceProvider.getCategoryService().getCategoryList(parameters: parameters);
    return result;
  }

}