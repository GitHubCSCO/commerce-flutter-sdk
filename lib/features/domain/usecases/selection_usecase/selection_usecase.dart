import 'package:collection/collection.dart';
import 'package:commerce_flutter_app/features/domain/usecases/base_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class SelectionUsecase extends BaseUseCase {
  Future<List<CatalogTypeDto>?> getUsersList() async {
    final result =
        await commerceAPIServiceProvider.getAccountService().getAccountsAsync();
    final currentAccountId =
        commerceAPIServiceProvider.getAccountService().currentAccount?.id;

    switch (result) {
      case Failure():
        return null;
      case Success(value: final accounts):
        return (accounts?.accounts ?? [])
            .whereNot((account) => account.id == currentAccountId)
            .map((account) {
          return CatalogTypeDto(
            id: account.id,
            title: account.userName,
          );
        }).toList();
    }
  }
}
