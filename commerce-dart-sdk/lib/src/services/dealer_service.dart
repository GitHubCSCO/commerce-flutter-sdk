import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:dio/dio.dart';

class DealerService extends ServiceBase implements IDealerService {
  DealerService({
    required super.clientService,
    required super.cacheService,
    required super.networkService,
  });

  @override
  Future<Result<GetDealerCollectionResult, ErrorResponse>> getDealers({
    DealerLocationFinderQueryParameters? parameters,
    CancelToken? cancelToken,
  }) async {
    var url = Uri.parse(CommerceAPIConstants.dealersUrl);
    if (parameters != null) {
      url = url.replace(queryParameters: parameters.toJson());
    }

    return await getAsyncNoCache<GetDealerCollectionResult>(
      url.toString(),
      GetDealerCollectionResult.fromJson,
      cancelToken: cancelToken,
    );
  }
}
