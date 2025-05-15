import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:dio/dio.dart';

abstract class IDealerService {
  /// Request dealer list from api. Consider using try catch to handle exception.
  ///
  /// [parameters] Request parameters.
  ///
  /// [cancelToken] Cancellation Token if needed.
  ///
  /// Returns: GetDealerCollectionResult.
  Future<Result<GetDealerCollectionResult, ErrorResponse>> getDealers({
    DealerLocationFinderQueryParameters? parameters,
    CancelToken? cancelToken,
  });
}
