import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/features/domain/service/interfaces/content_configuration_service_interface.dart';
import 'package:commerce_flutter_app/features/domain/service/interfaces/core_service_provider_interface.dart';
import 'package:mocktail/mocktail.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

import '../../features/domain/injector_mock.dart';

class MockAccountService extends Mock implements IAccountService {}

class MockAdminAuthenticationService extends Mock
    implements IAdminAuthenticationService {}

class MockAdminClientService extends Mock implements IAdminClientService {}

class MockAuthenticationService extends Mock
    implements IAuthenticationService {}

class MockAutocompleteService extends Mock implements IAutocompleteService {}

class MockBillToService extends Mock implements IBillToService {}

class MockBrandService extends Mock implements IBrandService {}

class MockCacheService extends Mock implements ICacheService {}

class MockCartService extends Mock implements ICartService {}

class MockCatalogpagesService extends Mock implements ICatalogpagesService {}

class MockCategoryService extends Mock implements ICategoryService {}

class MockClientService extends Mock implements IClientService {}

class MockDashboardPanelsService extends Mock
    implements IDashboardPanelsService {}

class MockDealerService extends Mock implements IDealerService {}

class MockInvoiceService extends Mock implements IInvoiceService {}

class MockJobQuoteService extends Mock implements IJobQuoteService {}

class MockLocalStorageService extends Mock implements ILocalStorageService {}

class MockMessageService extends Mock implements IMessageService {}

class MockMobileContentService extends Mock implements IMobileContentService {}

class MockMobileSpireContentService extends Mock
    implements IMobileSpireContentService {}

class MockNetworkService extends Mock implements INetworkService {}

class MockOrderService extends Mock implements IOrderService {}

class MockProductService extends Mock implements IProductService {}

class MockQuoteService extends Mock implements IQuoteService {}

class MockRealTimeInventoryService extends Mock
    implements IRealTimeInventoryService {}

class MockRealTimePricingService extends Mock
    implements IRealTimePricingService {}

class MockSecureStorageService extends Mock implements ISecureStorageService {}

class MockSessionService extends Mock implements ISessionService {}

class MockSettingsService extends Mock implements ISettingsService {}

class MockTokenExConfigService extends Mock implements ITokenExConfigService {}

class MockTranslationService extends Mock implements ITranslationService {}

class MockWarehouseService extends Mock implements IWarehouseService {}

class MockWebsiteService extends Mock implements IWebsiteService {}

class MockWishListService extends Mock implements IWishListService {}

class MockContentConfigurationService extends Mock
    implements IContentConfigurationService {}

class MockCoreServiceProvider extends Mock implements ICoreServiceProvider {}

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
