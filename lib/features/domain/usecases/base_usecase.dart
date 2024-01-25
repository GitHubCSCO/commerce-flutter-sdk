import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class BaseUseCase {
  final ICommerceAPIServiceProvider commerceAPIServiceProvider;

  BaseUseCase()
      : commerceAPIServiceProvider = sl<ICommerceAPIServiceProvider>();
}
