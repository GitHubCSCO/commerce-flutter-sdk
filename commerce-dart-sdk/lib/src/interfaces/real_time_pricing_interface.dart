import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

abstract class IRealTimePricingService {
  Future<Result<GetRealTimePricingResult, ErrorResponse>>
      getProductRealTimePrices(RealTimePricingParameters parameters);
}
