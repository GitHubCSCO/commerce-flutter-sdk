import 'package:commerce_flutter_app/features/domain/service/interfaces/content_configuration_service_interface.dart';
import 'package:commerce_flutter_app/features/domain/service/interfaces/core_service_provider_interface.dart';
import 'package:commerce_flutter_app/features/domain/service/interfaces/tracking_service_interface.dart';
import 'package:mocktail/mocktail.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

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

class MockTrackingService extends Mock implements ITrackingService {}

class MockContentConfigurationService extends Mock
    implements IContentConfigurationService {}

class MockCoreServiceProvider extends Mock implements ICoreServiceProvider {}
