import 'package:commerce_flutter_app/features/domain/usecases/base_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class DealerLocationUsecase extends BaseUseCase {
  DealerLocationUsecase() : super();

  Future<Result<GetDealerCollectionResult, ErrorResponse>> getDealersLocation(
      {required DealerLocationFinderQueryParameters parameters}) async {
    return await commerceAPIServiceProvider
        .getDealerService()
        .getDealers(parameters: parameters);
  }
}
