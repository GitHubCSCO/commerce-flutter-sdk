import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/features/domain/service/interfaces/interfaces.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

extension GetResultSuccessValue<S, E> on Result<S, E> {
  S? getResultSuccessValue({bool trackError = false}) {
    if (this is Success<S, E>) {
      return (this as Success<S, E>).value;
    }

    if (trackError && this is Failure<S, E>) {
      sl<ITrackingService>()
          .trackError((this as Failure<S, E>).errorResponse)
          .ignore();
    }

    return null;
  }
}
