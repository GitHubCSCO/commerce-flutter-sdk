import 'package:commerce_flutter_app/core/constants/core_constants.dart';
import 'package:commerce_flutter_app/features/domain/usecases/base_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class SavedOrderUsecase extends BaseUseCase {
  Future<CartSettings?> loadSettings() async {
    final result = await commerceAPIServiceProvider
        .getSettingsService()
        .getCartSettingAsync();
    switch (result) {
      case Success(value: final value):
        return value;
      case Failure():
        return null;
    }
  }

  Future<CartCollectionModel?> loadSavedOrders({
    int? page,
    required CartSortOrder sortOrder,
  }) async {
    final result = await commerceAPIServiceProvider.getCartService().getCarts(
          parameters: CartsQueryParameters(
            sort: sortOrder.value,
            page: page ?? 1,
            pageSize: CoreConstants.defaultPageSize,
            status: 'Saved',
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
