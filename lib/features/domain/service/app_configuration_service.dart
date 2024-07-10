// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:commerce_flutter_app/core/constants/asset_constants.dart';
import 'package:commerce_flutter_app/features/domain/service/interfaces/app_configuration_service_interface.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/product_carousel/product_carousel_cubit.dart';
import 'package:flutter/services.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class Configuration {
  bool? ShouldUseStaticDomain;

  String? Domain;

  String? SandboxDomain;

  bool? HasCheckoutConfiguration;

  String? CheckoutUrl;

  bool? ViewOnWebsiteEnabled;

  String? StartingCategoryForBrowsing;

  bool? CustomHideCheckoutOrderNotes;

  String? FirebaseAndroidApiKey;
  String? FirebaseAndroidAppId;
  String? FirebaseAndroidMessagingSenderId;
  String? FirebaseAndroidProjectId;
  String? FirebaseAndroidStorageBucket;

  String? FirebaseIOSApiKey;
  String? FirebaseIOSAppId;
  String? FirebaseIOSMessagingSenderId;
  String? FirebaseIOSProjectId;
  String? FirebaseIOSStorageBucket;
  String? FirebaseIOSBundleId;

  Configuration({
    this.ShouldUseStaticDomain,
    this.Domain,
    this.SandboxDomain,
    this.HasCheckoutConfiguration,
    this.CheckoutUrl,
    this.ViewOnWebsiteEnabled,
    this.StartingCategoryForBrowsing,
    this.CustomHideCheckoutOrderNotes,
    this.FirebaseAndroidApiKey,
    this.FirebaseAndroidAppId,
    this.FirebaseAndroidMessagingSenderId,
    this.FirebaseAndroidProjectId,
    this.FirebaseAndroidStorageBucket,
    this.FirebaseIOSApiKey,
    this.FirebaseIOSAppId,
    this.FirebaseIOSMessagingSenderId,
    this.FirebaseIOSProjectId,
    this.FirebaseIOSStorageBucket,
    this.FirebaseIOSBundleId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ShouldUseStaticDomain': ShouldUseStaticDomain,
      'Domain': Domain,
      'SandboxDomain': SandboxDomain,
      'HasCheckout': HasCheckoutConfiguration,
      'CheckoutUrl': CheckoutUrl,
      'ViewOnWebsiteEnabled': ViewOnWebsiteEnabled,
      'StartingCategoryForBrowsing': StartingCategoryForBrowsing,
      'CustomHideCheckoutOrderNotes': CustomHideCheckoutOrderNotes,
      'FirebaseAndroidApiKey': FirebaseAndroidApiKey,
      'FirebaseAndroidAppId': FirebaseAndroidAppId,
      'FirebaseAndroidMessagingSenderId': FirebaseAndroidMessagingSenderId,
      'FirebaseAndroidProjectId': FirebaseAndroidProjectId,
      'FirebaseAndroidStorageBucket': FirebaseAndroidStorageBucket,
      'FirebaseIOSApiKey': FirebaseIOSApiKey,
      'FirebaseIOSAppId': FirebaseIOSAppId,
      'FirebaseIOSMessagingSenderId': FirebaseIOSMessagingSenderId,
      'FirebaseIOSProjectId': FirebaseIOSProjectId,
      'FirebaseIOSStorageBucket': FirebaseIOSStorageBucket,
      'FirebaseIOSBundleId': FirebaseIOSBundleId,
    };
  }

  factory Configuration.fromMap(Map<String, dynamic> map) {
    return Configuration(
      ShouldUseStaticDomain: map['ShouldUseStaticDomain'] != null
          ? map['ShouldUseStaticDomain'] as bool
          : null,
      Domain: map['Domain'] != null ? map['Domain'] as String : null,
      SandboxDomain:
          map['SandboxDomain'] != null ? map['SandboxDomain'] as String : null,
      HasCheckoutConfiguration:
          map['HasCheckout'] != null ? map['HasCheckout'] as bool : null,
      CheckoutUrl:
          map['CheckoutUrl'] != null ? map['CheckoutUrl'] as String : null,
      ViewOnWebsiteEnabled: map['ViewOnWebsiteEnabled'] != null
          ? map['ViewOnWebsiteEnabled'] as bool
          : null,
      StartingCategoryForBrowsing: map['StartingCategoryForBrowsing'] != null
          ? map['StartingCategoryForBrowsing'] as String
          : null,
      CustomHideCheckoutOrderNotes: map['CustomHideCheckoutOrderNotes'] != null
          ? map['CustomHideCheckoutOrderNotes'] as bool
          : null,
      FirebaseAndroidApiKey: map['FirebaseAndroidApiKey'] != null
          ? map['FirebaseAndroidApiKey'] as String
          : null,
      FirebaseAndroidAppId: map['FirebaseAndroidAppId'] != null
          ? map['FirebaseAndroidAppId'] as String
          : null,
      FirebaseAndroidMessagingSenderId:
          map['FirebaseAndroidMessagingSenderId'] != null
              ? map['FirebaseAndroidMessagingSenderId'] as String
              : null,
      FirebaseAndroidProjectId: map['FirebaseAndroidProjectId'] != null
          ? map['FirebaseAndroidProjectId'] as String
          : null,
      FirebaseAndroidStorageBucket: map['FirebaseAndroidStorageBucket'] != null
          ? map['FirebaseAndroidStorageBucket'] as String
          : null,
      FirebaseIOSApiKey: map['FirebaseIOSApiKey'] != null
          ? map['FirebaseIOSApiKey'] as String
          : null,
      FirebaseIOSAppId: map['FirebaseIOSAppId'] != null
          ? map['FirebaseIOSAppId'] as String
          : null,
      FirebaseIOSMessagingSenderId: map['FirebaseIOSMessagingSenderId'] != null
          ? map['FirebaseIOSMessagingSenderId'] as String
          : null,
      FirebaseIOSProjectId: map['FirebaseIOSProjectId'] != null
          ? map['FirebaseIOSProjectId'] as String
          : null,
      FirebaseIOSStorageBucket: map['FirebaseIOSStorageBucket'] != null
          ? map['FirebaseIOSStorageBucket'] as String
          : null,
      FirebaseIOSBundleId: map['FirebaseIOSBundleId'] != null
          ? map['FirebaseIOSBundleId'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Configuration.fromJson(String source) =>
      Configuration.fromMap(json.decode(source) as Map<String, dynamic>);
}

class AppConfigurationService extends ServiceBase
    implements IAppConfigurationService {
  final ICommerceAPIServiceProvider _commerceAPIServiceProvider;
  @override
  String? termsOfUseUrl;

  @override
  bool? customHideCheckoutOrderNotes;

  @override
  String? domain;

  @override
  bool? hasOrderHistory;

  @override
  String? privacyPolicyUrl;

  @override
  String? sandboxDomain;

  @override
  bool? shouldUseStaticDomain;

  @override
  bool? viewOnWebsiteEnabled;

  @override
  String? firebaseAndroidApiKey;

  @override
  String? firebaseAndroidAppId;

  @override
  String? firebaseAndroidMessagingSenderId;

  @override
  String? firebaseAndroidProjectId;

  @override
  String? firebaseAndroidStorageBucket;

  @override
  String? firebaseIOSApiKey;

  @override
  String? firebaseIOSAppId;

  @override
  String? firebaseIOSMessagingSenderId;

  @override
  String? firebaseIOSProjectId;

  @override
  String? firebaseIOSStorageBucket;

  @override
  String? firebaseIOSBundleId;

  AppConfigurationService({
    required ICommerceAPIServiceProvider commerceAPIServiceProvider,
    required super.clientService,
    required super.cacheService,
    required super.networkService,
  }) : _commerceAPIServiceProvider = commerceAPIServiceProvider;

  Future<void> init() async {
    final configurationString =
        await rootBundle.loadString(AssetConstants.configuration);

    final configuration = Configuration.fromJson(configurationString);

    domain = configuration.Domain;
    sandboxDomain = configuration.SandboxDomain;
    shouldUseStaticDomain = configuration.ShouldUseStaticDomain;
    viewOnWebsiteEnabled = configuration.ViewOnWebsiteEnabled;
    termsOfUseUrl = configuration.CheckoutUrl;
    privacyPolicyUrl = configuration.CheckoutUrl;
    customHideCheckoutOrderNotes = configuration.CustomHideCheckoutOrderNotes;

    firebaseAndroidApiKey = configuration.FirebaseAndroidApiKey;
    firebaseAndroidAppId = configuration.FirebaseAndroidAppId;
    firebaseAndroidMessagingSenderId =
        configuration.FirebaseAndroidMessagingSenderId;
    firebaseAndroidProjectId = configuration.FirebaseAndroidProjectId;
    firebaseAndroidStorageBucket = configuration.FirebaseAndroidStorageBucket;

    firebaseIOSApiKey = configuration.FirebaseIOSApiKey;
    firebaseIOSAppId = configuration.FirebaseIOSAppId;
    firebaseIOSMessagingSenderId = configuration.FirebaseIOSMessagingSenderId;
    firebaseIOSProjectId = configuration.FirebaseIOSProjectId;
    firebaseIOSStorageBucket = configuration.FirebaseIOSStorageBucket;
    firebaseIOSBundleId = configuration.FirebaseIOSBundleId;
  }

  static const String _tokenExConfigurationUrl = "/api/v1/tokenexconfig";
  static const String _tokenExIFramePath = "mobilecreditcard";

  @override
  String get tokenExIFrameUrl {
    var url = _commerceAPIServiceProvider.getClientService().url.toString();
    return "$url${url.endsWith("/") ? '' : '/'}$_tokenExIFramePath";
  }

  @override
  Future<bool?> addToCartEnabled() async {
    var productSettings = await getProductSettings();

    if (productSettings != null) {
      var isUserSignedInResponse = await _commerceAPIServiceProvider
          .getAuthenticationService()
          .isAuthenticatedAsync();
      var isUserSignedIn = (isUserSignedInResponse is Success)
          ? (isUserSignedInResponse as Success).value
          : false;
      var isSignInRequiredForAddToCart = productSettings.storefrontAccess ==
              StorefrontAccessConstants.signInRequiredToAddToCart ||
          productSettings.storefrontAccess ==
              StorefrontAccessConstants.signInRequiredToAddToCartOrSeePrices;
      var result = !isSignInRequiredForAddToCart || isUserSignedIn;
      return result;
    }
    return null;
  }

  @override
  Future<String> checkoutUrl() {
    // TODO: implement checkoutUrl
    throw UnimplementedError();
  }

  @override
  Future<RealTimeSupport?> getRealtimeSupportType() async {
    var productSettings = await getProductSettings();

    if (productSettings == null) {
      return null;
    }

    var result = RealTimeSupport.NoRealTimePricingAndInventory;

    if (productSettings.realTimePricing!) {
      if (productSettings.realTimeInventory!) {
        if (productSettings.inventoryIncludedWithPricing!) {
          result = RealTimeSupport.RealTimePricingWithInventoryIncluded;
        } else {
          result = RealTimeSupport.RealTimePricingAndInventory;
        }
      } else {
        result = RealTimeSupport.RealTimePricingOnly;
      }
    } else {
      if (productSettings.realTimeInventory!) {
        result = RealTimeSupport.RealTimeInventory;
      }
    }

    return result;
  }

  Future<ProductSettings?> getProductSettings() async {
    var productSettingsResponse = await _commerceAPIServiceProvider
        .getSettingsService()
        .getProductSettingsAsync();

    switch (productSettingsResponse) {
      case Success(value: final value):
        {
          return value!;
        }
      case Failure():
        {
          return null;
        }
    }
  }

  @override
  Future<Result<TokenExDto, ErrorResponse>> getTokenExConfiguration(
      String token) async {
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
          return Failure(
              ErrorResponse(errorDescription: errorResponse.errorDescription));
        }
    }
  }

  @override
  Future<bool> hasCheckout() async {
    var mobileSettingsResponse = await _commerceAPIServiceProvider
        .getSettingsService()
        .getMobileAppSettingAsync();
    MobileAppSettings? mobileSettings = mobileSettingsResponse is Success
        ? (mobileSettingsResponse as Success).value
        : null;
    if (mobileSettings != null) {
      return mobileSettings.hasCheckout ?? true;
    }

    return hasCheckoutConfiguration;
  }

  @override
  Future<bool> hasWillCall() async {
    var result = await _commerceAPIServiceProvider
      .getSettingsService()
      .getAccountSettingsAsync();
    AccountSettings? accountSettings =
        result is Success ? (result as Success).value as AccountSettings : null;
    var hasWillCall = false;

    if (accountSettings != null)
    {
        hasWillCall |= accountSettings.enableWarehousePickup == true;
    }

    if (hasWillCall)
    {   
        Session? session = _commerceAPIServiceProvider.getSessionService().getCachedCurrentSession();
        if(session==null){
          var sessionResult = await _commerceAPIServiceProvider.getSessionService().getCurrentSession();
          session = sessionResult is Success ? (sessionResult as Success).value as Session : null;
        }
        hasWillCall &= session?.pickUpWarehouse != null;
    }

    return hasWillCall;
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
  Future<bool?> productPricingEnabled() async {
    var productSettings = await getProductSettings();
    if (productSettings != null) {
      var result = productSettings.canSeePrices ?? true;
      var isUserSignedInResponse = await _commerceAPIServiceProvider
          .getAuthenticationService()
          .isAuthenticatedAsync();
      var isUserSignedIn = (isUserSignedInResponse is Success)
          ? (isUserSignedInResponse as Success).value
          : false;

      result = result &
          (productSettings.storefrontAccess !=
                  StorefrontAccessConstants
                      .signInRequiredToAddToCartOrSeePrices ||
              isUserSignedIn);
      return result;
    }
    return null;
  }

  @override
  Future<String> startingCategoryForBrowsing() {
    // TODO: implement startingCategoryForBrowsing
    throw UnimplementedError();
  }

  @override
  // TODO: implement hasCheckoutConfiguration
  bool get hasCheckoutConfiguration => throw UnimplementedError();

  @override
  bool? showHideInventoryEnable;

  @override
  bool? showHidePricingEnable;

  @override
  void setHideInventoryEnable(bool enable) {
    showHideInventoryEnable = enable;
  }

  @override
  void setHidePricingEnable(bool enable) {
    showHidePricingEnable = enable;
  }

}
