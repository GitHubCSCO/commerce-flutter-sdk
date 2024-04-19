// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:commerce_flutter_app/core/constants/asset_constants.dart';
import 'package:commerce_flutter_app/features/domain/service/interfaces/app_configuration_service_interface.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/product_carousel/product_carousel_cubit.dart';
import 'package:flutter/services.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class Configuration {
  bool? ShouldUseStaticDomain;

  String? AppCenterSecretiOS;

  String? AppCenterSecretAndroid;

  String? Domain;

  String? SandboxDomain;

  bool? HasCheckoutConfiguration;

  String? CheckoutUrl;

  bool? ViewOnWebsiteEnabled;

  String? StartingCategoryForBrowsing;

  bool? CustomHideCheckoutOrderNotes;

  Configuration({
    this.ShouldUseStaticDomain,
    this.AppCenterSecretiOS,
    this.AppCenterSecretAndroid,
    this.Domain,
    this.SandboxDomain,
    this.HasCheckoutConfiguration,
    this.CheckoutUrl,
    this.ViewOnWebsiteEnabled,
    this.StartingCategoryForBrowsing,
    this.CustomHideCheckoutOrderNotes,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ShouldUseStaticDomain': ShouldUseStaticDomain,
      'AppCenterSecretiOS': AppCenterSecretiOS,
      'AppCenterSecretAndroid': AppCenterSecretAndroid,
      'Domain': Domain,
      'SandboxDomain': SandboxDomain,
      'HasCheckout': HasCheckoutConfiguration,
      'CheckoutUrl': CheckoutUrl,
      'ViewOnWebsiteEnabled': ViewOnWebsiteEnabled,
      'StartingCategoryForBrowsing': StartingCategoryForBrowsing,
      'CustomHideCheckoutOrderNotes': CustomHideCheckoutOrderNotes,
    };
  }

  factory Configuration.fromMap(Map<String, dynamic> map) {
    return Configuration(
      ShouldUseStaticDomain: map['ShouldUseStaticDomain'] != null
          ? map['ShouldUseStaticDomain'] as bool
          : null,
      AppCenterSecretiOS: map['AppCenterSecretiOS'] != null
          ? map['AppCenterSecretiOS'] as String
          : null,
      AppCenterSecretAndroid: map['AppCenterSecretAndroid'] != null
          ? map['AppCenterSecretAndroid'] as String
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
  String? appCenterSecretAndroid;

  @override
  String? appCenterSecretiOS;

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

    appCenterSecretAndroid = configuration.AppCenterSecretAndroid;
    appCenterSecretiOS = configuration.AppCenterSecretiOS;
    domain = configuration.Domain;
    sandboxDomain = configuration.SandboxDomain;
    shouldUseStaticDomain = configuration.ShouldUseStaticDomain;
    viewOnWebsiteEnabled = configuration.ViewOnWebsiteEnabled;
    termsOfUseUrl = configuration.CheckoutUrl;
    privacyPolicyUrl = configuration.CheckoutUrl;
    customHideCheckoutOrderNotes = configuration.CustomHideCheckoutOrderNotes;
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
}
