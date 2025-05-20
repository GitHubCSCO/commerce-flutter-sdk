import 'package:collection/collection.dart';
import 'package:commerce_flutter_sdk/src/core/constants/core_constants.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/base_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class SelectionUsecase extends BaseUseCase {
  Future<List<CatalogTypeDto>?> getUsersList({
    required bool removeMyself,
  }) async {
    final result =
        await commerceAPIServiceProvider.getAccountService().getAccountsAsync();
    final currentAccountId =
        commerceAPIServiceProvider.getAccountService().currentAccount?.id;

    switch (result) {
      case Failure():
        return null;
      case Success(value: final accounts):
        return (accounts?.accounts ?? [])
            .whereNot(
                (account) => removeMyself && account.id == currentAccountId)
            .map((account) {
          return CatalogTypeDto(
            id: account.id,
            title: account.userName,
          );
        }).toList();
    }
  }

  Future<QuoteResult?> getSalesRepList({
    required int page,
  }) async {
    final parameters = QuoteQueryParameters(
      page: page,
      pageSize: CoreConstants.defaultPageSize,
      expand: ['saleslist'],
    );

    final result = await commerceAPIServiceProvider
        .getQuoteService()
        .getQuotes(quoteQueryParameters: parameters);

    switch (result) {
      case Failure():
        return null;
      case Success(value: final quotes):
        return quotes;
    }
  }
}
