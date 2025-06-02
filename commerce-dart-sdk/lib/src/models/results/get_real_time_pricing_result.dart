import '../models.dart';

part 'get_real_time_pricing_result.g.dart';

@JsonSerializable()
class GetRealTimePricingResult {
  List<ProductPrice>? realTimePricingResults;

  GetRealTimePricingResult({
    this.realTimePricingResults,
  });

  factory GetRealTimePricingResult.fromJson(Map<String, dynamic> json) =>
      _$GetRealTimePricingResultFromJson(json);

  Map<String, dynamic> toJson() => _$GetRealTimePricingResultToJson(this);
}
