import 'package:commerce_flutter_app/features/presentation/cubit/product_carousel/product_carousel_cubit.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

abstract class IAppConfigurationService {
  String? get domain;

  String? get sandboxDomain;

  bool? get shouldUseStaticDomain;

  String? get appCenterSecretiOS;

  String? get tokenExIFrameUrl;

  String? get appCenterSecretAndroid;

  bool? get hasOrderHistory;

  bool? get viewOnWebsiteEnabled;

  bool? get customHideCheckoutOrderNotes;

  String? get privacyPolicyUrl;

  String? get termsOfUseUrl;

  Future loadRemoteSettings();

  Future<bool> hasWillCall();

  Future<bool> hasCheckout();

  Future<String> checkoutUrl();

  Future<String> startingCategoryForBrowsing();

  Future<Result<TokenExDto, ErrorResponse>> getTokenExConfiguration(
      String token);

  Future<bool> productPricingEnabled();

  Future<bool> addToCartEnabled();

  Future<RealTimeSupport> getRealtimeSupportType();

  Future<bool> isSignInRequired();
}
