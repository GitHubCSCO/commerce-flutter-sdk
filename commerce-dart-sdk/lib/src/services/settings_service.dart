import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class SettingsService extends ServiceBase implements ISettingsService {
  SettingsService({
    required super.clientService,
    required super.cacheService,
    required super.networkService,
  });

  @override
  Future<Result<AccountSettings, ErrorResponse>>
      getAccountSettingsAsync() async {
    final response = await getAsyncNoCache(
      CommerceAPIConstants.accountSettingsUrl,
      AccountSettings.fromJson,
      timeout: ServiceBase.defaultRequestTimeout,
    );

    switch (response) {
      case Success(value: final value):
        {
          if (value == null) {
            Failure(ErrorResponse(
                message:
                    'Attempted to load account settings for ${clientService.host}, but the account settings response is null. This website might either be an older ISC website or not an ISC website.'));
          }
          return Success(value);
        }
      case Failure(errorResponse: final errorResponse):
        {
          return Failure(errorResponse);
        }
    }
  }

  @override
  Future<Result<CartSettings, ErrorResponse>> getCartSettingAsync() async {
    final response = await getAsyncNoCache(
      CommerceAPIConstants.cartSettingsUrl,
      CartSettings.fromJson,
      timeout: ServiceBase.defaultRequestTimeout,
    );
    switch (response) {
      case Success(value: final value):
        {
          if (value == null) {
            Failure(ErrorResponse(
                message:
                    'Attempted to load cart settings for ${clientService.host}, but the cart settings response is null. This website might either be an older ISC website or not an ISC website.'));
          }
          return Success(value);
        }
      case Failure(errorResponse: final errorResponse):
        {
          return Failure(errorResponse);
        }
    }
  }

  @override
  Future<Result<MobileAppSettings, ErrorResponse>>
      getMobileAppSettingAsync() async {
    final response = await getAsyncNoCache(
      CommerceAPIConstants.mobileAppSettingsUrl,
      MobileAppSettings.fromJson,
      timeout: ServiceBase.defaultRequestTimeout,
    );

    switch (response) {
      case Success(value: final value):
        {
          if (value == null) {
            Failure(ErrorResponse(
                message:
                    'Attempted to load mobile app settings for ${clientService.host}, but the mobile app settings response is null. This website might either be an older ISC website or not an ISC website.'));
          }
          return Success(value);
        }
      case Failure(errorResponse: final errorResponse):
        {
          return Failure(errorResponse);
        }
    }
  }

  @override
  Future<Result<ProductSettings, ErrorResponse>>
      getProductSettingsAsync() async {
    final response = await getAsyncNoCache(
      CommerceAPIConstants.productSettingsUrl,
      ProductSettings.fromJson,
      timeout: ServiceBase.defaultRequestTimeout,
    );

    switch (response) {
      case Success(value: final value):
        {
          if (value == null) {
            Failure(ErrorResponse(
                message:
                    'Attempted to load product settings for ${clientService.host}, but the product settings response is null. This website might either be an older ISC website or not an ISC website.'));
          }
          return Success(value);
        }
      case Failure(errorResponse: final errorResponse):
        {
          return Failure(errorResponse);
        }
    }
  }

  @override
  Future<Result<QuoteSettings, ErrorResponse>> getQuoteSettingAsync() async {
    return await getAsyncNoCache<QuoteSettings>(
        CommerceAPIConstants.quoteSettingsUrl, QuoteSettings.fromJson);
  }

  @override
  Future<Result<Settings, ErrorResponse>> getSettingsAsync() async {
    final response = await getAsyncNoCache(
      CommerceAPIConstants.settingsUrl,
      Settings.fromJson,
      timeout: ServiceBase.defaultRequestTimeout,
    );

    switch (response) {
      case Success(value: final value):
        {
          if (value == null) {
            Failure(ErrorResponse(
                message:
                    'Attempted to load settings for ${clientService.host}, but the settings response is null. This website might either be an older ISC website or not an ISC website.'));
          }
          return Success(value);
        }
      case Failure(errorResponse: final errorResponse):
        {
          return Failure(errorResponse);
        }
    }
  }

  @override
  Future<Result<WebsiteSettings, ErrorResponse>>
      getWebsiteSettingsAsync() async {
    final response = await getAsyncNoCache(
      CommerceAPIConstants.websiteSettingsUrl,
      WebsiteSettings.fromJson,
      timeout: ServiceBase.defaultRequestTimeout,
    );

    switch (response) {
      case Success(value: final value):
        {
          if (value == null) {
            Failure(ErrorResponse(
                message:
                    'Attempted to load website settings for ${clientService.host}, but the website settings response is null. This website might either be an older ISC website or not an ISC website.'));
          }
          return Success(value);
        }
      case Failure(errorResponse: final errorResponse):
        {
          return Failure(errorResponse);
        }
    }
  }

  @override
  Future<Result<WishListSettings, ErrorResponse>>
      getWishListSettingAsync() async {
    final response = await getAsyncNoCache(
      CommerceAPIConstants.wishListSettingsUrl,
      WishListSettings.fromJson,
      timeout: ServiceBase.defaultRequestTimeout,
    );

    switch (response) {
      case Success(value: final value):
        {
          if (value == null) {
            Failure(ErrorResponse(
                message:
                    'Attempted to load wish list settings for ${clientService.host}, but the wish list settings response is null. This website might either be an older ISC website or not an ISC website.'));
          }
          return Success(value);
        }
      case Failure(errorResponse: final errorResponse):
        {
          return Failure(errorResponse);
        }
    }
  }
}
