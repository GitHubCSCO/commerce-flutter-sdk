import 'package:commerce_flutter_app/features/domain/usecases/base_usecase.dart';

class LogoutUsecase extends BaseUseCase {
  LogoutUsecase() : super();

  Future<void> logout() async {
    await commerceAPIServiceProvider.getAuthenticationService().logoutAsync();
  }
}
