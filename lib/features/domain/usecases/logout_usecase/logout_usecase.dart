import 'package:commerce_flutter_app/features/domain/usecases/domain_usecase/domain_usecase.dart';

class LogoutUsecase extends DomainUsecase {
  LogoutUsecase() : super();

  Future<void> logout() async {
    await commerceAPIServiceProvider.getAuthenticationService().logoutAsync();
  }
}
