import 'package:commerce_flutter_app/features/domain/service/interfaces/app_configuration_service_interface.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/product_carousel/product_carousel_cubit.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class AppConfigurationService extends ServiceBase
    implements IAppConfigurationService {
  final ICommerceAPIServiceProvider _commerceAPIServiceProvider;
  String _termsOfUseUrl = '';

  @override
  String get termsOfUseUrl => _termsOfUseUrl;

  set termsOfUseUrl(String value) {
    _termsOfUseUrl = value;
  }

  String _appCenterSecretAndroid = '';

  @override
  String get appCenterSecretAndroid => _appCenterSecretAndroid;

  set appCenterSecretAndroid(String value) {
    _appCenterSecretAndroid = value;
  }

  String _appCenterSecretiOS = '';

  @override
  String get appCenterSecretiOS => _appCenterSecretiOS;

  set appCenterSecretiOS(String value) {
    _appCenterSecretiOS = value;
  }

  bool _customHideCheckoutOrderNotes = false;

  @override
  bool get customHideCheckoutOrderNotes => _customHideCheckoutOrderNotes;

  set customHideCheckoutOrderNotes(bool value) {
    _customHideCheckoutOrderNotes = value;
  }

  String _domain = '';

  @override
  String get domain => _domain;

  set domain(String value) {
    _domain = value;
  }

  bool _hasOrderHistory = false;

  @override
  bool get hasOrderHistory => _hasOrderHistory;

  set hasOrderHistory(bool value) {
    _hasOrderHistory = value;
  }

  String _privacyPolicyUrl = '';

  @override
  String get privacyPolicyUrl => _privacyPolicyUrl;

  set privacyPolicyUrl(String value) {
    _privacyPolicyUrl = value;
  }

  String _sandboxDomain = '';

  @override
  String get sandboxDomain => _sandboxDomain;

  set sandboxDomain(String value) {
    _sandboxDomain = value;
  }

  bool _shouldUseStaticDomain = false;

  @override
  bool get shouldUseStaticDomain => _shouldUseStaticDomain;

  set shouldUseStaticDomain(bool value) {
    _shouldUseStaticDomain = value;
  }

  bool _viewOnWebsiteEnabled = false;

  @override
  bool get viewOnWebsiteEnabled => _viewOnWebsiteEnabled;

  set viewOnWebsiteEnabled(bool value) {
    _viewOnWebsiteEnabled = value;
  }

  AppConfigurationService(
      {required ICommerceAPIServiceProvider commerceAPIServiceProvider,
      required super.clientService,
      required super.cacheService,
      required super.networkService})
      : _commerceAPIServiceProvider = commerceAPIServiceProvider;

  static const String _tokenExConfigurationUrl = "/api/v1/tokenexconfig";
  static const String _tokenExIFramePath = "mobilecreditcard";

  @override
  String get tokenExIFrameUrl {
    var url = _commerceAPIServiceProvider.getClientService().url.toString();
    return "$url${url.endsWith("/") ? '' : '/'}$_tokenExIFramePath";
  }

  @override
  Future<bool> addToCartEnabled() {
    return Future.value(true);
  }

  @override
  Future<String> checkoutUrl() {
    // TODO: implement checkoutUrl
    throw UnimplementedError();
  }

  @override
  Future<RealTimeSupport> getRealtimeSupportType() {
    // TODO: implement getRealtimeSupportType
    throw UnimplementedError();
  }

  @override
  Future<Result<TokenExDto, ErrorResponse>> getTokenExConfiguration(
      String token ) async {
    var url = token.isEmpty
        ? _tokenExConfigurationUrl
        : '$_tokenExConfigurationUrl?token=$token';

    var tokenExDtoResponse =
        await getAsyncWithCachedResponse<TokenExDto>(url, TokenExDto.fromJson);

    switch (tokenExDtoResponse) {
      case Success(value: final value):
        {
          return Success(value!);
        }
      case Failure(errorResponse: final errorResponse):
        {
          return Failure(ErrorResponse(errorDescription: errorResponse.errorDescription));
        }
    }
  }

  @override
  Future<bool> hasCheckout() {
    // TODO: implement hasCheckout
    throw UnimplementedError();
  }

  @override
  Future<bool> hasWillCall() {
    // TODO: implement hasWillCall
    throw UnimplementedError();
  }

  @override
  Future<bool> isSignInRequired() {
    // TODO: implement isSignInRequired
    throw UnimplementedError();
  }

  @override
  Future loadRemoteSettings() {
    // TODO: implement loadRemoteSettings
    throw UnimplementedError();
  }

  @override
  Future<bool> productPricingEnabled() {
    // TODO: implement productPricingEnabled
    throw UnimplementedError();
  }

  @override
  Future<String> startingCategoryForBrowsing() {
    // TODO: implement startingCategoryForBrowsing
    throw UnimplementedError();
  }
}
