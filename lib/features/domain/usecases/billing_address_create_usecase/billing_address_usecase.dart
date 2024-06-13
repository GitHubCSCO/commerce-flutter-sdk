import 'package:commerce_flutter_app/features/domain/usecases/base_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class BillingAddressUsecase extends BaseUseCase {
  BillingAddressUsecase() : super();

  Future<Result<CountryCollection, ErrorResponse>> getCountries() async {
    var parameters = CountriesQueryParameters(expand: ['states']);
    return commerceAPIServiceProvider
        .getWebsiteService()
        .getCountries(parameters: parameters);
  }

  Future<Result<Session, ErrorResponse>> getCurrentSession() async {
    return await commerceAPIServiceProvider
        .getSessionService()
        .getCurrentSession();
  }
}
