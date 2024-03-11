import 'package:commerce_flutter_app/features/domain/enums/domain_change_status.dart';
import 'package:commerce_flutter_app/features/domain/usecases/domain_usecase/domain_usecase.dart';
import 'package:mocktail/mocktail.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:test/test.dart';
import '../../injector_mock.dart';

void main() {
  group('DomainUsecase', () {
    late DomainUsecase domainSelectionUsecase;

    setUpAll(() {
      initInjectionContainerMock();
      domainSelectionUsecase = DomainUsecase();
    });

    test('getSavedDomain should load and set the saved domain', () async {
      const savedDomain = 'test.com';

      when(() => domainSelectionUsecase.commerceAPIServiceProvider
          .getLocalStorageService()
          .load(any())).thenAnswer((_) async => savedDomain);

      final result = await domainSelectionUsecase.getSavedDomain();

      expect(result, equals(savedDomain));
      verify(() => domainSelectionUsecase.commerceAPIServiceProvider
          .getLocalStorageService()
          .load("DomainKey"));
      verify(() => domainSelectionUsecase.commerceAPIServiceProvider
          .getClientService()
          .host = savedDomain);
      verify(() => domainSelectionUsecase.commerceAPIServiceProvider
          .getAdminClientService()
          .host = savedDomain);
    });

    test(
      'domainSelectHandler should set the extracted domain and return success status when settings are retrieved successfully',
      () async {
        const domain = 'test.com';
        const extractedDomain = 'www.test.com';

        when(() => domainSelectionUsecase.commerceAPIServiceProvider
            .getNetworkService()
            .isOnline()).thenAnswer((_) async => true);
        when(() => domainSelectionUsecase.commerceAPIServiceProvider
                .getSettingsService()
                .getProductSettingsAsync())
            .thenAnswer((_) async => Success(ProductSettings()));
        when(() => domainSelectionUsecase.commerceAPIServiceProvider
                .getSettingsService()
                .getWebsiteSettingsAsync())
            .thenAnswer(
                (_) async => Success(WebsiteSettings(mobileAppEnabled: true)));

        when(() => domainSelectionUsecase.commerceAPIServiceProvider
            .getClientService()
            .host).thenReturn(null);
        when(() => domainSelectionUsecase.commerceAPIServiceProvider
            .getLocalStorageService()
            .save("DomainKey", extractedDomain)).thenAnswer((_) async {});

        final result = await domainSelectionUsecase.domainSelectHandler(domain);

        expect(result, equals(DomainChangeStatus.success));
        expect(ClientConfig.hostUrl, equals(extractedDomain));
        verify(() => domainSelectionUsecase.commerceAPIServiceProvider
            .getClientService()
            .host = extractedDomain);
        verify(() => domainSelectionUsecase.commerceAPIServiceProvider
            .getAdminClientService()
            .host = extractedDomain);
      },
    );
    test(
        'domainSelectHandler should return failedOffline status when device is offline',
        () async {
      const domain = 'test.com';

      when(() => domainSelectionUsecase.commerceAPIServiceProvider
          .getNetworkService()
          .isOnline()).thenAnswer((_) async => false);

      final result = await domainSelectionUsecase.domainSelectHandler(domain);

      expect(result, equals(DomainChangeStatus.failedOffline));
    });

    test(
        'domainSelectHandler should return failedInvalidDomain status when settings retrieval fails',
        () async {
      const domain = 'test.com';

      when(() => domainSelectionUsecase.commerceAPIServiceProvider
          .getNetworkService()
          .isOnline()).thenAnswer((_) async => true);
      when(() => domainSelectionUsecase.commerceAPIServiceProvider
              .getSettingsService()
              .getProductSettingsAsync())
          .thenAnswer((_) async => Failure(ErrorResponse()));
      when(() => domainSelectionUsecase.commerceAPIServiceProvider
              .getSettingsService()
              .getWebsiteSettingsAsync())
          .thenAnswer((_) async => Failure(ErrorResponse()));

      when(() => domainSelectionUsecase.commerceAPIServiceProvider
          .getClientService()
          .host).thenReturn('test.com');

      final result = await domainSelectionUsecase.domainSelectHandler(domain);

      expect(result, equals(DomainChangeStatus.failedInvalidDomain));
    });

    test(
        'domainSelectHandler should return failedMobileAppDisabled status when mobile app is disabled',
        () async {
      const domain = 'test.com';

      when(() => domainSelectionUsecase.commerceAPIServiceProvider
          .getNetworkService()
          .isOnline()).thenAnswer((_) async => true);
      when(() => domainSelectionUsecase.commerceAPIServiceProvider
              .getSettingsService()
              .getProductSettingsAsync())
          .thenAnswer((_) async => Success(ProductSettings()));
      when(() => domainSelectionUsecase.commerceAPIServiceProvider
              .getSettingsService()
              .getWebsiteSettingsAsync())
          .thenAnswer(
              (_) async => Success(WebsiteSettings(mobileAppEnabled: false)));

      final result = await domainSelectionUsecase.domainSelectHandler(domain);

      expect(result, equals(DomainChangeStatus.failedMobileAppDisabled));
    });

    test(
      'domainSelectHandler should not add www. prefix if it already exists',
      () async {
        const domain = 'www.test.com';

        when(() => domainSelectionUsecase.commerceAPIServiceProvider
            .getNetworkService()
            .isOnline()).thenAnswer((_) async => true);
        when(() => domainSelectionUsecase.commerceAPIServiceProvider
                .getSettingsService()
                .getProductSettingsAsync())
            .thenAnswer((_) async => Success(ProductSettings()));
        when(() => domainSelectionUsecase.commerceAPIServiceProvider
                .getSettingsService()
                .getWebsiteSettingsAsync())
            .thenAnswer(
                (_) async => Success(WebsiteSettings(mobileAppEnabled: true)));

        when(() => domainSelectionUsecase.commerceAPIServiceProvider
            .getClientService()
            .host).thenReturn(null);
        when(() => domainSelectionUsecase.commerceAPIServiceProvider
            .getLocalStorageService()
            .save("DomainKey", domain)).thenAnswer((_) async {});

        final result = await domainSelectionUsecase.domainSelectHandler(domain);

        expect(result, equals(DomainChangeStatus.success));
        expect(ClientConfig.hostUrl, equals(domain));
        verify(() => domainSelectionUsecase.commerceAPIServiceProvider
            .getClientService()
            .host = domain);
        verify(() => domainSelectionUsecase.commerceAPIServiceProvider
            .getAdminClientService()
            .host = domain);
      },
    );

    test(
      'domainSelectHandler should return failedInvalidDomain status when domain is null or empty',
      () async {
        const domain = '';

        final result = await domainSelectionUsecase.domainSelectHandler(domain);

        expect(result, equals(DomainChangeStatus.failedInvalidDomain));
      },
    );
  });
}
