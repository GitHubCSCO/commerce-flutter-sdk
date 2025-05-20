import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:test/test.dart';

import '../../mocks/mocks.dart';

void main() {
  late DashboardPanelsService dashboardPanelsService;
  late MockClientService clientService;
  late MockNetworkService networkService;
  late MockCacheService cacheService;

  setUp(() {
    clientService = MockClientService();
    networkService = MockNetworkService();
    cacheService = MockCacheService();
    dashboardPanelsService = DashboardPanelsService(
      clientService: clientService,
      networkService: networkService,
      cacheService: cacheService,
    );
  });

  group('getDashboardPanelsAsync', () {
    final dashboardPanelsResult = DashboardPanelsResult(
      dashboardPanels: [
        DashboardPanel(
          text: 'Orders',
          quickLinkText: 'View Orders',
          url: '/orders',
          count: 5,
          isPanel: true,
          isQuickLink: true,
          panelType: 'Orders',
          order: 1,
          quickLinkOrder: 1,
          openInNewTab: false,
        ),
        DashboardPanel(
          text: 'Products',
          quickLinkText: 'Browse Products',
          url: '/products',
          count: 10,
          isPanel: true,
          isQuickLink: false,
          panelType: 'Products',
          order: 2,
          quickLinkOrder: 2,
          openInNewTab: false,
        ),
      ],
    );

    test('should return dashboard panels when API call is successful',
        () async {
      // Arrange
      when(() => networkService.isOnline()).thenAnswer((_) async => true);
      when(() => clientService.getAsync(any())).thenAnswer(
        (_) async => Success(
          Response(
            data: dashboardPanelsResult.toJson(),
            requestOptions: RequestOptions(),
            statusCode: 200,
          ),
        ),
      );

      // Act
      final result = await dashboardPanelsService.getDashboardPanelsAsync();

      // Assert
      switch (result) {
        case Success(value: final value):
          expect(value?.dashboardPanels, isNotNull);
          expect(value?.dashboardPanels?.length, equals(2));
          expect(value?.dashboardPanels?[0].text, equals('Orders'));
          verify(() => clientService
              .getAsync(CommerceAPIConstants.dashboardPanelUrl)).called(1);
        case Failure():
          fail('Expected Success but got Failure');
      }
    });

    test('should return failure when API call fails', () async {
      // Arrange
      final errorResponse = ErrorResponse(
        error: 'API Error',
        message: 'Failed to fetch dashboard panels',
      );
      when(() => networkService.isOnline()).thenAnswer((_) async => true);
      when(() => clientService.getAsync(any())).thenAnswer(
        (_) async => Failure(errorResponse),
      );

      // Act
      final result = await dashboardPanelsService.getDashboardPanelsAsync();

      // Assert
      switch (result) {
        case Success():
          fail('Expected Failure but got Success');
        case Failure(errorResponse: final errorResponse):
          expect(errorResponse.error, equals('API Error'));
          expect(errorResponse.message,
              equals('Failed to fetch dashboard panels'));
          verify(() => clientService
              .getAsync(CommerceAPIConstants.dashboardPanelUrl)).called(1);
      }
    });

    test('should handle network offline scenario gracefully', () async {
      // Arrange
      when(() => networkService.isOnline()).thenAnswer((_) async => false);

      // Act
      final result = await dashboardPanelsService.getDashboardPanelsAsync();

      // Assert
      switch (result) {
        case Success():
          fail('Expected Failure but got Success');
        case Failure(errorResponse: final errorResponse):
          expect(errorResponse.error, contains('No internet found'));
      }
      verifyNever(() => clientService.getAsync(any()));
    });
  });
}
