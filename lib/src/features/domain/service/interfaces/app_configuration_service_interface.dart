import 'package:commerce_flutter_sdk/src/core/config/base_configuration.dart';
import 'package:commerce_flutter_sdk/src/core/config/custom_configuration.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/product_carousel/product_carousel_cubit.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

abstract class IAppConfigurationService {
  BaseConfiguration? get baseConfig;

  CustomConfiguration? get customConfig;

  String? get tokenExIFrameUrl;

  bool? get hasOrderHistory;

  String? get privacyPolicyUrl;

  String? get termsOfUseUrl;

  Future<void> loadRemoteSettings();

  bool? get hidePricingEnable;

  bool? get hideInventoryEnable;

  Future<bool> hasWillCall();

  Future<bool> hasCheckout();

  Future<String?> checkoutUrl();

  Future<String?> startingCategoryForBrowsing();

  Future<Result<TokenExDto, ErrorResponse>> getTokenExConfiguration(
      String token);

  Future<Result<SpreedlyDto, ErrorResponse>> getSpreedlyConfiguration();

  Future<bool?> productPricingEnabled();

  Future<bool?> addToCartEnabled();

  Future<RealTimeSupport?> getRealtimeSupportType();

  void setHidePricingEnable(bool enable);

  void setHideInventoryEnable(bool enable);
}
