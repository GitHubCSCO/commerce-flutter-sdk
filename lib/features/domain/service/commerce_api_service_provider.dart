import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class CommerceAPIServiceProvider implements ICommerceAPIServiceProvider {
  CommerceAPIServiceProvider();

  @override
  IAccountService getAccountService() => sl<IAccountService>();
  @override
  IAdminAuthenticationService getAdminAuthenticationService() =>
      sl<IAdminAuthenticationService>();
  @override
  IAdminClientService getAdminClientService() => sl<IAdminClientService>();
  @override
  IAuthenticationService getAuthenticationService() =>
      sl<IAuthenticationService>();
  @override
  IAutocompleteService getAutocompleteService() => sl<IAutocompleteService>();
  @override
  IBillToService getBillToService() => sl<IBillToService>();
  @override
  IBrandService getBrandService() => sl<IBrandService>();
  @override
  ICacheService getCacheService() => sl<ICacheService>();
  @override
  ICartService getCartService() => sl<ICartService>();
  @override
  ICatalogpagesService getCatalogpagesService() => sl<ICatalogpagesService>();
  @override
  ICategoryService getCategoryService() => sl<ICategoryService>();
  @override
  IClientService getClientService() => sl<IClientService>();
  @override
  IDashboardPanelsService getDashboardPanelsService() =>
      sl<IDashboardPanelsService>();
  @override
  IDealerService getDealerService() => sl<IDealerService>();
  @override
  IInvoiceService getInvoiceService() => sl<IInvoiceService>();
  @override
  IJobQuoteService getJobQuoteService() => sl<IJobQuoteService>();
  @override
  ILocalStorageService getLocalStorageService() => sl<ILocalStorageService>();
  @override
  ILoggerService getLoggerService() => sl<ILoggerService>();
  @override
  IMessageService getMessageService() => sl<IMessageService>();
  @override
  IMobileContentService getMobileContentService() =>
      sl<IMobileContentService>();
  @override
  IMobileSpireContentService getMobileSpireContentService() =>
      sl<IMobileSpireContentService>();
  @override
  INetworkService getNetworkService() => sl<INetworkService>();
  // @override
  // IOptimizelyService getOptimizelyService() => sl<IOptimizelyService>();
  @override
  IOrderService getOrderService() => sl<IOrderService>();
  @override
  IProductService getProductService() => sl<IProductService>();
  // @override
  // IProductV2Service getProductV2Service() => sl<IProductV2Service>();
  @override
  IQuoteService getQuoteService() => sl<IQuoteService>();
  @override
  IRealTimeInventoryService getRealTimeInventoryService() =>
      sl<IRealTimeInventoryService>();
  @override
  IRealTimePricingService getRealTimePricingService() =>
      sl<IRealTimePricingService>();
  @override
  ISecureStorageService getSecureStorageService() =>
      sl<ISecureStorageService>();
  @override
  ISessionService getSessionService() => sl<ISessionService>();
  @override
  ISettingsService getSettingsService() => sl<ISettingsService>();
  @override
  ITokenExConfigService getTokenExConfigService() =>
      sl<ITokenExConfigService>();
  @override
  ITranslationService getTranslationService() => sl<ITranslationService>();
  @override
  IVmiLocationsService getVmiLocationsService() => sl<IVmiLocationsService>();
  @override
  IWarehouseService getWarehouseService() => sl<IWarehouseService>();
  @override
  IWebsiteService getWebsiteService() => sl<IWebsiteService>();
  @override
  IWishListService getWishListService() => sl<IWishListService>();
}
