import 'package:commerce_flutter_app/features/presentation/cubit/product_carousel/product_carousel_cubit.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

abstract class IAppConfigurationService {
  String? get domain;

  String? get sandboxDomain;

  bool get hasCheckoutConfiguration;

  bool? get shouldUseStaticDomain;

  String? get tokenExIFrameUrl;

  String? get checkoutUrlConfiguration;

  bool? get hasOrderHistory;

  bool? get viewOnWebsiteEnabled;

  bool? get customHideCheckoutOrderNotes;

  String? get privacyPolicyUrl;

  String? get termsOfUseUrl;

  String? get firebaseAndroidApiKey;

  String? get firebaseAndroidAppId;

  String? get firebaseAndroidMessagingSenderId;

  String? get firebaseAndroidProjectId;

  String? get firebaseAndroidStorageBucket;

  String? get firebaseIOSApiKey;

  String? get firebaseIOSAppId;

  String? get firebaseIOSMessagingSenderId;

  String? get firebaseIOSProjectId;

  String? get firebaseIOSStorageBucket;

  String? get firebaseIOSBundleId;

  Future<void> loadRemoteSettings();

  Future<bool> hasWillCall();

  Future<bool> hasCheckout();

  Future<String> checkoutUrl();

  Future<String> startingCategoryForBrowsing();

  Future<Result<TokenExDto, ErrorResponse>> getTokenExConfiguration(
      String token);

  Future<bool?> productPricingEnabled();

  Future<bool?> addToCartEnabled();

  Future<RealTimeSupport?> getRealtimeSupportType();

  Future<bool> isSignInRequired();
}
