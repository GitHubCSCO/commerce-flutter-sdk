import 'package:commerce_flutter_sdk/src/core/constants/core_constants.dart';
import 'package:commerce_flutter_sdk/src/features/domain/enums/domain_change_status.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/domain_usecase/domain_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:test/test.dart';
import '../../injector_mock.dart';

void main() async {
  late DomainUsecase sut;
  setUp(() async {
    await initInjectionContainerMock();
    await GetIt.I.allReady();
    sut = DomainUsecase();
  });

  tearDown(() {
    // Reset GetIt after each test
    GetIt.I.reset();
  });

  group('DomainUsecase', () {
    test(
      'domainSelectHandler should set the extracted domain and return success status when settings are retrieved successfully',
      () async {
        const domain = 'test.com';
        const extractedDomain = 'www.test.com';

        when(() =>
                sut.commerceAPIServiceProvider.getNetworkService().isOnline())
            .thenAnswer((_) async => true);
        when(() => sut.commerceAPIServiceProvider
                .getSettingsService()
                .getProductSettingsAsync())
            .thenAnswer((_) async => Success(ProductSettings()));
        when(() => sut.commerceAPIServiceProvider
                .getSettingsService()
                .getWebsiteSettingsAsync())
            .thenAnswer(
                (_) async => Success(WebsiteSettings(mobileAppEnabled: true)));

        when(() => sut.commerceAPIServiceProvider.getClientService().host)
            .thenReturn(null);
        when(() => sut.commerceAPIServiceProvider.getLocalStorageService().save(
            CoreConstants.domainKey, extractedDomain)).thenAnswer((_) async {});

        final result = await sut.domainSelectHandler(domain);

        expect(result, equals(DomainChangeStatus.success));
        expect(ClientConfig.hostUrl, equals(extractedDomain));
        verify(() => sut.commerceAPIServiceProvider.getClientService().host =
            extractedDomain);
        verify(() => sut.commerceAPIServiceProvider
            .getAdminClientService()
            .host = extractedDomain);
      },
    );
    test(
        'domainSelectHandler should return failedOffline status when device is offline',
        () async {
      const domain = 'test.com';

      when(() => sut.commerceAPIServiceProvider.getNetworkService().isOnline())
          .thenAnswer((_) async => false);

      final result = await sut.domainSelectHandler(domain);

      expect(result, equals(DomainChangeStatus.failedOffline));
    });

    test(
        'domainSelectHandler should return failedInvalidDomain status when settings retrieval fails',
        () async {
      const domain = 'test.com';

      when(() => sut.commerceAPIServiceProvider.getNetworkService().isOnline())
          .thenAnswer((_) async => true);
      when(() => sut.commerceAPIServiceProvider
              .getSettingsService()
              .getProductSettingsAsync())
          .thenAnswer((_) async => Failure(ErrorResponse()));
      when(() => sut.commerceAPIServiceProvider
              .getSettingsService()
              .getWebsiteSettingsAsync())
          .thenAnswer((_) async => Failure(ErrorResponse()));

      when(() => sut.commerceAPIServiceProvider.getClientService().host)
          .thenReturn('test.com');

      final result = await sut.domainSelectHandler(domain);

      expect(result, equals(DomainChangeStatus.failedInvalidDomain));
    });

    test(
        'domainSelectHandler should return failedMobileAppDisabled status when mobile app is disabled',
        () async {
      const domain = 'test.com';

      when(() => sut.commerceAPIServiceProvider.getNetworkService().isOnline())
          .thenAnswer((_) async => true);
      when(() => sut.commerceAPIServiceProvider
              .getSettingsService()
              .getProductSettingsAsync())
          .thenAnswer((_) async => Success(ProductSettings()));
      when(() => sut.commerceAPIServiceProvider
              .getSettingsService()
              .getWebsiteSettingsAsync())
          .thenAnswer(
              (_) async => Success(WebsiteSettings(mobileAppEnabled: false)));

      final result = await sut.domainSelectHandler(domain);

      expect(result, equals(DomainChangeStatus.failedMobileAppDisabled));
    });

    test(
      'domainSelectHandler should not add www. prefix if it already exists',
      () async {
        const domain = 'www.test.com';

        when(() =>
                sut.commerceAPIServiceProvider.getNetworkService().isOnline())
            .thenAnswer((_) async => true);
        when(() => sut.commerceAPIServiceProvider
                .getSettingsService()
                .getProductSettingsAsync())
            .thenAnswer((_) async => Success(ProductSettings()));
        when(() => sut.commerceAPIServiceProvider
                .getSettingsService()
                .getWebsiteSettingsAsync())
            .thenAnswer(
                (_) async => Success(WebsiteSettings(mobileAppEnabled: true)));

        when(() => sut.commerceAPIServiceProvider.getClientService().host)
            .thenReturn(null);
        when(() => sut.commerceAPIServiceProvider
            .getLocalStorageService()
            .save(CoreConstants.domainKey, domain)).thenAnswer((_) async {});

        final result = await sut.domainSelectHandler(domain);

        expect(result, equals(DomainChangeStatus.success));
        expect(ClientConfig.hostUrl, equals(domain));
        verify(() =>
            sut.commerceAPIServiceProvider.getClientService().host = domain);
        verify(() => sut.commerceAPIServiceProvider
            .getAdminClientService()
            .host = domain);
      },
    );

    test(
      'domainSelectHandler should return failedInvalidDomain status when domain is null or empty',
      () async {
        const domain = '';

        final result = await sut.domainSelectHandler(domain);

        expect(result, equals(DomainChangeStatus.failedInvalidDomain));
      },
    );
  });
}
