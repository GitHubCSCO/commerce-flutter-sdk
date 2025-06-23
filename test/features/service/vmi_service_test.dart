import 'package:flutter_test/flutter_test.dart';
import 'package:commerce_flutter_sdk/src/features/domain/service/vmi_service.dart';
import 'package:mocktail/mocktail.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:commerce_flutter_sdk/src/features/domain/service/interfaces/core_service_provider_interface.dart';
import 'package:commerce_flutter_sdk/src/features/domain/service/interfaces/tracking_service_interface.dart';
import 'package:commerce_flutter_sdk/src/core/constants/core_constants.dart';
import 'package:dio/dio.dart';

// Create mocks for dependencies
class MockCommerceAPIServiceProvider extends Mock
    implements ICommerceAPIServiceProvider {}

class MockCoreServiceProvider extends Mock implements ICoreServiceProvider {}

class MockClientService extends Mock implements IClientService {}

class MockCacheService extends Mock implements ICacheService {}

class MockNetworkService extends Mock implements INetworkService {}

class MockSessionService extends Mock implements ISessionService {}

class MockVmiLocationsService extends Mock implements IVmiLocationsService {}

class MockSettingsService extends Mock implements ISettingsService {}

class MockTrackingService extends Mock implements ITrackingService {}

class MockSession extends Mock implements Session {}

class MockAddress extends Mock implements Address {}

class MockStateModel extends Mock implements StateModel {}

class MockGetVmiLocationResult extends Mock implements GetVmiLocationResult {}

// Create fake classes for fallback value registration
class FakeVmiLocationModel extends Fake implements VmiLocationModel {}

class FakeVmiLocationQueryParameters extends Fake
    implements VmiLocationQueryParameters {}

class FakeErrorResponse extends Fake implements ErrorResponse {}

class FakeString extends Fake {}

class FakeStackTrace extends Fake implements StackTrace {}

class FakeMap extends Fake implements Map<String, String> {}

void main() {
  late VMIService vmiService;
  late MockCommerceAPIServiceProvider mockCommerceAPIServiceProvider;
  late MockCoreServiceProvider mockCoreServiceProvider;
  late MockClientService mockClientService;
  late MockCacheService mockCacheService;
  late MockNetworkService mockNetworkService;
  late MockSessionService mockSessionService;
  late MockVmiLocationsService mockVmiLocationsService;
  late MockSettingsService mockSettingsService;
  late MockTrackingService mockTrackingService;

  setUpAll(() {
    // Register fallback values for Mocktail
    registerFallbackValue(FakeVmiLocationQueryParameters());
    registerFallbackValue(FakeVmiLocationModel());
    registerFallbackValue(FakeErrorResponse());
    registerFallbackValue(FakeString());
    registerFallbackValue(FakeStackTrace());
    registerFallbackValue(FakeMap());
  });

  setUp(() {
    mockCommerceAPIServiceProvider = MockCommerceAPIServiceProvider();
    mockCoreServiceProvider = MockCoreServiceProvider();
    mockClientService = MockClientService();
    mockCacheService = MockCacheService();
    mockNetworkService = MockNetworkService();
    mockSessionService = MockSessionService();
    mockVmiLocationsService = MockVmiLocationsService();
    mockSettingsService = MockSettingsService();
    mockTrackingService = MockTrackingService();

    // Set up service provider mocks
    when(() => mockCommerceAPIServiceProvider.getClientService())
        .thenReturn(mockClientService);
    when(() => mockCommerceAPIServiceProvider.getCacheService())
        .thenReturn(mockCacheService);
    when(() => mockCommerceAPIServiceProvider.getSessionService())
        .thenReturn(mockSessionService);
    when(() => mockCommerceAPIServiceProvider.getVmiLocationsService())
        .thenReturn(mockVmiLocationsService);
    when(() => mockCommerceAPIServiceProvider.getSettingsService())
        .thenReturn(mockSettingsService);
    when(() => mockCoreServiceProvider.getTrackingService())
        .thenReturn(mockTrackingService);

    when(() => mockClientService.host).thenReturn('test-host');

    final session = MockSession();
    when(() => session.userName).thenReturn('test-user');
    when(() => mockSessionService.getCachedCurrentSession())
        .thenReturn(session);

    // Create service instance
    vmiService = VMIService(
      commerceAPIServiceProvider: mockCommerceAPIServiceProvider,
      coreServiceProvider: mockCoreServiceProvider,
      clientService: mockClientService,
      cacheService: mockCacheService,
      networkService: mockNetworkService,
    );
  });

  group('VMIService', () {
    test('getClosestVmiLocation returns cached location if available',
        () async {
      // Arrange
      final cachedLocation = VmiLocationModel(
          id: '123',
          name: 'Cached Location',
          useBins: false,
          isPrimaryLocation: true,
          note: '',
          customer: null);

      final cacheKey =
          '${CoreConstants.currentVmiLocationKey}:test-host:test-user';

      // The method in VMI service uses loadPersistedData<VmiLocationModel>, not <VmiLocationModel?>
      when(() => mockCacheService.loadPersistedData<VmiLocationModel>(cacheKey))
          .thenAnswer((_) async => cachedLocation);

      // Act
      final result = await vmiService.getClosestVmiLocation();

      // Assert
      expect(result, cachedLocation);
      expect(vmiService.currentVmiLocation, cachedLocation);
      verify(() =>
              mockCacheService.loadPersistedData<VmiLocationModel>(cacheKey))
          .called(1);
      verifyNever(() => mockVmiLocationsService.getVmiLocations(
          parameters: any(named: 'parameters')));
    });

    test('getClosestVmiLocation fetches from API when no cached location',
        () async {
      // Arrange
      final cacheKey =
          '${CoreConstants.currentVmiLocationKey}:test-host:test-user';

      final apiLocation = VmiLocationModel(
          id: '456',
          name: 'API Location',
          useBins: false,
          isPrimaryLocation: true,
          note: '',
          customer: null);

      // Create a mock result with the location
      final mockResult = MockGetVmiLocationResult();
      when(() => mockResult.vmiLocations).thenReturn([apiLocation]);

      // This method should throw an exception to simulate the try-catch in getClosestVmiLocation
      when(() => mockCacheService.loadPersistedData<VmiLocationModel>(cacheKey))
          .thenThrow(Exception('No cached location'));

      // Important: Ensure the mock is properly set up for getVmiLocations
      when(() => mockVmiLocationsService.getVmiLocations(
              parameters: any(named: 'parameters')))
          .thenAnswer((_) async => Success(mockResult));

      when(() =>
              mockCacheService.persistData(cacheKey, any<VmiLocationModel>()))
          .thenAnswer((_) async => true);

      // Act
      final result = await vmiService.getClosestVmiLocation();

      // Assert
      expect(result?.id, apiLocation.id);
      expect(vmiService.currentVmiLocation?.id, apiLocation.id);
      verify(() =>
              mockCacheService.loadPersistedData<VmiLocationModel>(cacheKey))
          .called(1);
      verify(() => mockVmiLocationsService.getVmiLocations(
          parameters: any(named: 'parameters'))).called(1);
      verify(() =>
              mockCacheService.persistData(cacheKey, any<VmiLocationModel>()))
          .called(1);
    });

    test('getClosestVmiLocation handles API failure', () async {
      // Arrange
      final cacheKey =
          '${CoreConstants.currentVmiLocationKey}:test-host:test-user';
      final errorResponse = ErrorResponse(error: 'API Error');

      // This method should throw an exception to simulate the try-catch in getClosestVmiLocation
      when(() => mockCacheService.loadPersistedData<VmiLocationModel>(cacheKey))
          .thenThrow(Exception('No cached location'));

      // Handle the API failure case
      when(() => mockVmiLocationsService.getVmiLocations(
              parameters: any(named: 'parameters')))
          .thenAnswer((_) async => Failure(errorResponse));

      when(() => mockTrackingService.trackError(errorResponse))
          .thenAnswer((_) async {});

      // Act
      final result = await vmiService.getClosestVmiLocation();

      // Assert
      expect(result, isNull);
      verify(() =>
              mockCacheService.loadPersistedData<VmiLocationModel>(cacheKey))
          .called(1);
      verify(() => mockVmiLocationsService.getVmiLocations(
          parameters: any(named: 'parameters'))).called(1);
      // This verification needs to match exactly what happens in the service
      verify(() => mockTrackingService.trackError(errorResponse)).called(1);
    });

    test('getPlace returns GooglePlace when API returns valid data', () async {
      // Arrange
      final websiteSettings = WebsiteSettings(googleMapsApiKey: 'test-api-key');
      when(() => mockSettingsService.getWebsiteSettingsAsync())
          .thenAnswer((_) async => Success(websiteSettings));

      const jsonResponse = '''
      {
        "results": [
          {
            "formatted_address": "123 Main St, Anytown, USA",
            "geometry": {
              "location": {
                "lat": 40.7128,
                "lng": -74.0060
              }
            }
          }
        ]
      }
      ''';

      when(() => mockNetworkService.isOnline()).thenAnswer((_) async => true);

      when(() => mockClientService.getAsync(
                any(),
                timeout: any(named: 'timeout'),
                cancelToken: any(named: 'cancelToken'),
                responseType: ResponseType.plain,
              ))
          .thenAnswer((_) async => Success(Response(
              data: jsonResponse,
              statusCode: 200,
              requestOptions: RequestOptions(path: ''))));

      // Act
      final result = await vmiService.getPlace('123 Main St');

      // Assert
      expect(result, isNotNull);
      expect(result?.formattedName, '123 Main St, Anytown, USA');
      expect(result?.latitude, 40.7128);
      expect(result?.longitude, -74.0060);
    });

    test('getPlaceFromAddress returns LatLong when address is valid', () async {
      // Arrange
      final address = MockAddress();
      final state = MockStateModel();

      when(() => address.address1).thenReturn('123 Main St');
      when(() => address.city).thenReturn('Anytown');
      when(() => state.name).thenReturn('NY');
      when(() => address.state).thenReturn(state);
      when(() => address.postalCode).thenReturn('12345');

      final websiteSettings = WebsiteSettings(googleMapsApiKey: 'test-api-key');
      when(() => mockSettingsService.getWebsiteSettingsAsync())
          .thenAnswer((_) async => Success(websiteSettings));

      const jsonResponse = '''
      {
        "results": [
          {
            "formatted_address": "123 Main St, Anytown, USA",
            "geometry": {
              "location": {
                "lat": 40.7128,
                "lng": -74.0060
              }
            }
          }
        ]
      }
      ''';

      when(() => mockNetworkService.isOnline()).thenAnswer((_) async => true);

      when(() => mockClientService.getAsync(
                any(),
                timeout: any(named: 'timeout'),
                cancelToken: any(named: 'cancelToken'),
                responseType: ResponseType.plain,
              ))
          .thenAnswer((_) async => Success(Response(
              data: jsonResponse,
              statusCode: 200,
              requestOptions: RequestOptions(path: ''))));

      // Act
      final result = await vmiService.getPlaceFromAddress(address);

      // Assert
      expect(result, isNotNull);
      expect(result?.latitude, 40.7128);
      expect(result?.longitude, -74.0060);
    });

    test('saveCurrentVmiLocation updates current location and persists it', () {
      // Arrange
      final vmiLocation = VmiLocationModel(
          id: '789',
          name: 'New Location',
          useBins: true,
          isPrimaryLocation: false,
          note: 'Test note',
          customer: null);

      final cacheKey =
          '${CoreConstants.currentVmiLocationKey}:test-host:test-user';

      when(() => mockCacheService.persistData(cacheKey, vmiLocation))
          .thenAnswer((_) async => true);

      // Act
      vmiService.saveCurrentVmiLocation(vmiLocation);

      // Assert
      expect(vmiService.currentVmiLocation, vmiLocation);
      verify(() => mockCacheService.persistData(cacheKey, vmiLocation))
          .called(1);
    });
  });
}
