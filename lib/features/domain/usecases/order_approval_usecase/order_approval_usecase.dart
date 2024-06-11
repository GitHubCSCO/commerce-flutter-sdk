import 'package:commerce_flutter_app/core/constants/core_constants.dart';
import 'package:commerce_flutter_app/features/domain/usecases/base_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class OrderApprovalUseCase extends BaseUseCase {
  Future<GetOrderApprovalCollectionResult?> loadOrderApproval({
    int? page,
  }) async {
    final result =
        await commerceAPIServiceProvider.getOrderService().getOrderApprovalList(
              OrderApprovalParameters(
                page: page,
                pageSize: CoreConstants.defaultPageSize,
              ),
            );

    switch (result) {
      case Success(value: final value):
        return value;
      case Failure():
        return null;
    }
  }
}
