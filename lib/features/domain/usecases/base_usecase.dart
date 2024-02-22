import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/features/domain/service/interfaces/core_service_provider_interface.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class BaseUseCase {
  final ICommerceAPIServiceProvider commerceAPIServiceProvider;
  final ICoreServiceProvider coreServiceProvider;

  BaseUseCase()
      : commerceAPIServiceProvider = sl<ICommerceAPIServiceProvider>(),
        coreServiceProvider = sl<ICoreServiceProvider>();
}
