// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:commerce_flutter_sdk/src/core/colors/app_colors.dart';
import 'package:commerce_flutter_sdk/src/core/config/base_configuration.dart';
import 'package:commerce_flutter_sdk/src/core/config/custom_configuration.dart';
import 'package:commerce_flutter_sdk/src/core/constants/asset_constants.dart';
import 'package:commerce_flutter_sdk/src/core/constants/core_constants.dart';
import 'package:commerce_flutter_sdk/src/core/extensions/result_extension.dart';
import 'package:commerce_flutter_sdk/src/core/extensions/url_string_extension.dart';
import 'package:commerce_flutter_sdk/src/core/utils/asset_provider.dart';
import 'package:commerce_flutter_sdk/src/features/domain/service/interfaces/interfaces.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/product_carousel/product_carousel_cubit.dart';
import 'package:flutter/services.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class AppConfigurationService extends ServiceBase
    implements IAppConfigurationService {
  final ICommerceAPIServiceProvider _commerceAPIServiceProvider;

  @override
  BaseConfiguration? baseConfig;

  @override
  CustomConfiguration? customConfig;

  @override
  String? termsOfUseUrl;

  @override
  bool? hasOrderHistory;

  @override
  String? privacyPolicyUrl;

  AppConfigurationService({
    required ICommerceAPIServiceProvider commerceAPIServiceProvider,
    required super.clientService,
    required super.cacheService,
    required super.networkService,
  }) : _commerceAPIServiceProvider = commerceAPIServiceProvider;

  Future<void> init() async {
    final baseConfigurationString =
        await rootBundle.loadString(AssetConstants.baseConfig);

    baseConfig = BaseConfiguration.fromJson(
        json.decode(baseConfigurationString) as Map<String, dynamic>);

    final customConfigurationString =
        await rootBundle.loadString(AssetConstants.customConfig);
    customConfig = CustomConfiguration.fromJson(
        json.decode(customConfigurationString) as Map<String, dynamic>);
  }

  static const String _spreedlyConfigurationUrl = "/api/v1/spreedly/config";
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
  Future<String?> checkoutUrl() async {
    var mobileSettingsResponse = await _commerceAPIServiceProvider
        .getSettingsService()
        .getMobileAppSettingAsync();
    return mobileSettingsResponse
            .getResultSuccessValue(trackError: false)
            ?.checkoutUrl ??
        baseConfig?.checkoutUrl;
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
        await getAsyncNoCache<TokenExDto>(url, TokenExDto.fromJson);

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

    return baseConfig?.hasCheckout ?? false;
  }

  @override
  Future<bool> hasWillCall() async {
    var result = await _commerceAPIServiceProvider
        .getSettingsService()
        .getAccountSettingsAsync();
    AccountSettings? accountSettings =
        result is Success ? (result as Success).value as AccountSettings : null;
    var hasWillCall = false;

    if (accountSettings != null) {
      hasWillCall |= accountSettings.enableWarehousePickup == true;
    }

    if (hasWillCall) {
      Session? session = _commerceAPIServiceProvider
          .getSessionService()
          .getCachedCurrentSession();
      if (session == null) {
        var sessionResult = await _commerceAPIServiceProvider
            .getSessionService()
            .getCurrentSession();
        session = sessionResult is Success
            ? (sessionResult as Success).value as Session
            : null;
      }
      hasWillCall &= session?.pickUpWarehouse != null;
    }

    return hasWillCall;
  }

  @override
  Future<void> loadRemoteSettings() async {
    var getWebsiteResult =
        await _commerceAPIServiceProvider.getWebsiteService().getWebsite();
    var websiteSettings = getWebsiteResult.getResultSuccessValue();
    if (websiteSettings != null) {
      OptiAppColors.primaryColor = websiteSettings.mobilePrimaryColor != null
          ? OptiAppColors.colorFromHexString(
              websiteSettings.mobilePrimaryColor!)
          : OptiAppColors.defaultPrimaryColor;
      await _commerceAPIServiceProvider.getLocalStorageService().save(
          CoreConstants.primaryColorCachingKey,
          OptiAppColors.primaryColor.value
              .toRadixString(16)); // Convert to hex string
      privacyPolicyUrl = websiteSettings.mobilePrivacyPolicyUrl?.makeValidUrl();
      termsOfUseUrl = websiteSettings.mobileTermsOfUseUrl?.makeValidUrl();
    }
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
  Future<String?> startingCategoryForBrowsing() async {
    var mobileSettingsResponse = await _commerceAPIServiceProvider
        .getSettingsService()
        .getMobileAppSettingAsync();
    return mobileSettingsResponse
            .getResultSuccessValue(trackError: false)
            ?.startingCategoryForBrowsing ??
        baseConfig?.startingCategoryForBrowsing;
  }

  @override
  bool? hideInventoryEnable;

  @override
  bool? hidePricingEnable;

  @override
  void setHideInventoryEnable(bool enable) {
    hideInventoryEnable = enable;
  }

  @override
  void setHidePricingEnable(bool enable) {
    hidePricingEnable = enable;
  }

  @override
  Future<Result<SpreedlyDto, ErrorResponse>> getSpreedlyConfiguration() async {
    var spreedlyDtoResponse = await getAsyncNoCache<SpreedlyDto>(
        _spreedlyConfigurationUrl, SpreedlyDto.fromJson);

    switch (spreedlyDtoResponse) {
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
}
