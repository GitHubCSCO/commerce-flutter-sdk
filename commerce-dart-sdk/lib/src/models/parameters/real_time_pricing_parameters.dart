import '../models.dart';

part 'real_time_pricing_parameters.g.dart';

@JsonSerializable(createFactory: false)
class RealTimePricingParameters {
  List<ProductPriceQueryParameter>? productPriceParameters;

  RealTimePricingParameters({
    this.productPriceParameters,
  });

  Map<String, dynamic> toJson() => _$RealTimePricingParametersToJson(this);
}
