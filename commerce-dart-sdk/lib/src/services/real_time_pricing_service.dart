import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class RealTimePricingService extends ServiceBase
    implements IRealTimePricingService {
  RealTimePricingService({
    required super.clientService,
    required super.cacheService,
    required super.networkService,
  });

  @override
  Future<Result<GetRealTimePricingResult, ErrorResponse>>
      getProductRealTimePrices(RealTimePricingParameters parameters) async {
    bool isOnline = await networkService.isOnline();
    if (isOnline) {
      var data = parameters.toJson();
      return postAsyncNoCache<GetRealTimePricingResult>(
        CommerceAPIConstants.realTimePricingUrl,
        data,
        GetRealTimePricingResult.fromJson,
      );
    } else {
      return Failure(ErrorResponse(message: "No internet connection"));
    }
  }
}
