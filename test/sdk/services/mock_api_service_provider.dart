import 'package:mocktail/mocktail.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import '../../features/domain/injector_mock.dart';

class MockAPIServiceProvider extends Mock
    implements ICommerceAPIServiceProvider {
  MockAPIServiceProvider();

  @override
  IAccountService getAccountService() => mockSL<IAccountService>();
  @override
  IAdminAuthenticationService getAdminAuthenticationService() =>
      mockSL<IAdminAuthenticationService>();
  @override
  IAdminClientService getAdminClientService() => mockSL<IAdminClientService>();
  @override
  IAuthenticationService getAuthenticationService() =>
      mockSL<IAuthenticationService>();
  @override
  IAutocompleteService getAutocompleteService() =>
      mockSL<IAutocompleteService>();
  @override
  IBillToService getBillToService() => mockSL<IBillToService>();
  @override
  IBrandService getBrandService() => mockSL<IBrandService>();
  @override
  ICacheService getCacheService() => mockSL<ICacheService>();
  @override
  ICartService getCartService() => mockSL<ICartService>();
  @override
  ICatalogpagesService getCatalogpagesService() =>
      mockSL<ICatalogpagesService>();
  @override
  ICategoryService getCategoryService() => mockSL<ICategoryService>();
  @override
  IClientService getClientService() => mockSL<IClientService>();
  @override
  IDashboardPanelsService getDashboardPanelsService() =>
      mockSL<IDashboardPanelsService>();
  @override
  IDealerService getDealerService() => mockSL<IDealerService>();
  @override
  IInvoiceService getInvoiceService() => mockSL<IInvoiceService>();
  @override
  IJobQuoteService getJobQuoteService() => mockSL<IJobQuoteService>();
  @override
  ILocalStorageService getLocalStorageService() =>
      mockSL<ILocalStorageService>();
  @override
  IMessageService getMessageService() => mockSL<IMessageService>();
  @override
  IMobileContentService getMobileContentService() =>
      mockSL<IMobileContentService>();
  @override
  IMobileSpireContentService getMobileSpireContentService() =>
      mockSL<IMobileSpireContentService>();
  @override
  INetworkService getNetworkService() => mockSL<INetworkService>();
  @override
  IOrderService getOrderService() => mockSL<IOrderService>();
  @override
  IProductService getProductService() => mockSL<IProductService>();
  @override
  IQuoteService getQuoteService() => mockSL<IQuoteService>();
  @override
  IRealTimeInventoryService getRealTimeInventoryService() =>
      mockSL<IRealTimeInventoryService>();
  @override
  IRealTimePricingService getRealTimePricingService() =>
      mockSL<IRealTimePricingService>();
  @override
  ISecureStorageService getSecureStorageService() =>
      mockSL<ISecureStorageService>();
  @override
  ISessionService getSessionService() => mockSL<ISessionService>();
  @override
  ISettingsService getSettingsService() => mockSL<ISettingsService>();
  @override
  ITokenExConfigService getTokenExConfigService() =>
      mockSL<ITokenExConfigService>();
  @override
  ITranslationService getTranslationService() => mockSL<ITranslationService>();
  @override
  IWarehouseService getWarehouseService() => mockSL<IWarehouseService>();
  @override
  IWebsiteService getWebsiteService() => mockSL<IWebsiteService>();
  @override
  IWishListService getWishListService() => mockSL<IWishListService>();
}
