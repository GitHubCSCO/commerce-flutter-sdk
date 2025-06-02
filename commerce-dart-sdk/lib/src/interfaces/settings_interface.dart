import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

abstract class ISettingsService {
  Future<Result<Settings, ErrorResponse>> getSettingsAsync();

  Future<Result<ProductSettings, ErrorResponse>> getProductSettingsAsync();

  Future<Result<AccountSettings, ErrorResponse>> getAccountSettingsAsync();

  Future<Result<WebsiteSettings, ErrorResponse>> getWebsiteSettingsAsync();

  Future<Result<WishListSettings, ErrorResponse>> getWishListSettingAsync();

  Future<Result<CartSettings, ErrorResponse>> getCartSettingAsync();

  Future<Result<MobileAppSettings, ErrorResponse>> getMobileAppSettingAsync();

  Future<Result<QuoteSettings, ErrorResponse>> getQuoteSettingAsync();
}
