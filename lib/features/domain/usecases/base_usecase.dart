import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

abstract class BaseUseCase {
  final ICommerceAPIServiceProvider commerceAPIServiceProvider;

  BaseUseCase(this.commerceAPIServiceProvider);

  BaseUseCase.defaultConstructor()
      : commerceAPIServiceProvider = sl<ICommerceAPIServiceProvider>();
}
