import 'package:commerce_flutter_app/features/domain/usecases/base_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class BillToShipToUseCase extends BaseUseCase {

  Future<Session> getCurrentSession() async {
    Session? currentSession = commerceAPIServiceProvider.getSessionService().currentSession;

    if (currentSession == null) {
      final result = await commerceAPIServiceProvider.getSessionService().getCurrentSession();
      currentSession = result is Success
          ? (result as Success).value
          : null;
    }
    return Future.value(currentSession!);
  }

  Future<bool> hasWillCall() async {
    return await coreServiceProvider.getAppConfigurationService().hasWillCall();
  }

}