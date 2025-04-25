import 'package:commerce_flutter_sdk/features/domain/usecases/base_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class AddShippingAddressUsecase extends BaseUseCase {
  AddShippingAddressUsecase() : super();

  Future<Result<CountryCollection, ErrorResponse>> getCountries() async {
    var parameters = CountriesQueryParameters(expand: ['states']);
    return commerceAPIServiceProvider
        .getWebsiteService()
        .getCountries(parameters: parameters);
  }
}
