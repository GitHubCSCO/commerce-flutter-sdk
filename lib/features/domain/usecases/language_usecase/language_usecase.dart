import 'package:commerce_flutter_sdk/core/constants/site_message_constants.dart';
import 'package:commerce_flutter_sdk/features/domain/usecases/base_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class LanguageUsecase extends BaseUseCase {
  LanguageUsecase() : super();

  Language? getCurrentLanguage() {
    return coreServiceProvider.getLocalizationService().getCurrentLanguage();
  }

  Future<Result<bool, ErrorResponse>> loadCurrentLanguage() async {
    return await coreServiceProvider
        .getLocalizationService()
        .loadCurrentLanguage();
  }

  Future<Result<LanguageCollection, ErrorResponse>> loadLanguageList() async {
    return await commerceAPIServiceProvider.getWebsiteService().getLanguages();
  }

  Future<Result<bool, ErrorResponse>> changeLanguage(Language language) async {
    return await coreServiceProvider
        .getLocalizationService()
        .changeLanguage(language);
  }

  Future<void> loadDefaultSiteMessage() async {
    SiteMessageConstants.valuePricingSignInForPrice = await getSiteMessage(
        SiteMessageConstants.namePricingSignInForPrice,
        SiteMessageConstants.defaultValuePricingSignInForPrice);
    SiteMessageConstants.valuePricingZeroPriceMessage = await getSiteMessage(
        SiteMessageConstants.namePricingZeroPriceMessage,
        SiteMessageConstants.defaultValuePricingZeroPriceMessage);
    SiteMessageConstants.valueRealTimePricingLoadFail = await getSiteMessage(
        SiteMessageConstants.nameRealTimePricingLoadFail,
        SiteMessageConstants.defaultValueRealTimePricingLoadFail);
    SiteMessageConstants.valueRealTimeInventoryLoadFail = await getSiteMessage(
        SiteMessageConstants.nameRealTimeInventoryLoadFail,
        SiteMessageConstants.defaultValueRealTimeInventoryLoadFail);
  }
}
