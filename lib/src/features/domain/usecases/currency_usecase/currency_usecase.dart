import 'package:commerce_flutter_sdk/src/features/domain/usecases/base_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class CurrencyUsecase extends BaseUseCase {
  Currency? _currentCurrency;
  CurrencyUsecase() : super();

  Currency? getCurrentCurrency() {
    return _currentCurrency;
  }

  Future<Result<bool, ErrorResponse>> loadCurrentCurrency() async {
    var sessionResult = await commerceAPIServiceProvider
        .getSessionService()
        .getCurrentSession();
    switch (sessionResult) {
      case Success(value: final session):
        {
          if (session == null) {
            return Failure(ErrorResponse(
                message: "Could not load session to get the currency"));
          } else {
            _currentCurrency = session.currency;

            return const Success(true);
          }
        }
      case Failure(errorResponse: final errorResponse):
        {
          return Failure(errorResponse);
        }
    }
  }

  Future<Result<CurrencyCollection, ErrorResponse>> loadCurrencyList() async {
    return commerceAPIServiceProvider.getWebsiteService().getCurrencies();
  }

  Future<Result<bool, ErrorResponse>> changeCurrency(Currency? currency) async {
    if (currency == null) {
      return Failure(ErrorResponse(
          message: "Provided currency is null in changeCurrency"));
    }
    var sessionResult = await commerceAPIServiceProvider
        .getSessionService()
        .getCurrentSession();
    switch (sessionResult) {
      case Success(value: final session):
        {
          if (session == null) {
            return Failure(ErrorResponse(
                message: "Session is null during changeCurrency"));
          } else {
            session.currency = currency;
            var patchSessionResult = await commerceAPIServiceProvider
                .getSessionService()
                .patchSession(session);
            switch (patchSessionResult) {
              case Success(value: final patchedSession):
                {
                  if (patchedSession == null ||
                      patchedSession.currency?.id != currency.id) {
                    return Failure(ErrorResponse(
                        message:
                            "Session could not be patched with currency:  ${currency.toJson().toString()}"));
                  }
                  _currentCurrency = currency;
                }
              case Failure(errorResponse: final errorResponse):
                {
                  return Failure(errorResponse);
                }
            }
          }
        }
      case Failure(errorResponse: final errorResponse):
        {
          return Failure(errorResponse);
        }
    }

    return const Success(true);
  }
}
