import 'package:commerce_flutter_sdk/src/core/injection/injection_container.dart';
import 'package:commerce_flutter_sdk/src/features/domain/service/interfaces/interfaces.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

extension GetResultSuccessValue<S, E> on Result<S, E> {
  S? getResultSuccessValue({bool trackError = true}) {
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
