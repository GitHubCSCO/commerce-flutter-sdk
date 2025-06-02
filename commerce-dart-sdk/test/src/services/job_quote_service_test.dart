import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:test/test.dart';

import '../../mocks/mocks.dart';

void main() {
  late JobQuoteService jobQuoteService;
  late MockClientService clientService;
  late MockCacheService cacheService;
  late MockNetworkService networkService;

  setUp(() {
    clientService = MockClientService();
    cacheService = MockCacheService();
    networkService = MockNetworkService();

    jobQuoteService = JobQuoteService(
      clientService: clientService,
      cacheService: cacheService,
      networkService: networkService,
    );

    registerFallbackValue(Uri());
  });

  group('JobQuoteService', () {
    const jobQuoteId = 'test-id';
    const mockJobQuoteJson = {'jobQuoteId': jobQuoteId, 'jobName': 'Test Job'};
    const mockJobQuotesJson = {
      'jobQuotes': [mockJobQuoteJson],
      'pagination': {'totalResults': 1, 'pageSize': 10, 'currentPage': 1}
    };

    test('getJobQuote returns a JobQuoteDto on success', () async {
      // Arrange
      when(() => networkService.isOnline()).thenAnswer((_) async => true);
      when(() => clientService.getAsync(any())).thenAnswer(
        (_) async => Success(
            Response(data: mockJobQuoteJson, requestOptions: RequestOptions())),
      );

      // Act
      final result = await jobQuoteService.getJobQuote(jobQuoteId);

      // Assert
      expect(result, isA<Success>());
      final success = result as Success;
      expect(success.value.jobQuoteId, jobQuoteId);
      expect(success.value.jobName, 'Test Job');
      verify(() => clientService.getAsync(any())).called(1);
    });

    test('getJobQuote fails if jobQuoteId is empty', () async {
      // Act
      final result = await jobQuoteService.getJobQuote('');

      // Assert
      expect(result, isA<Failure>());
      final failure = result as Failure;
      expect(failure.errorResponse.message, 'jobQuoteId is required');
    });

    test('getJobQuotes returns JobQuoteResult on success', () async {
      // Arrange
      when(() => networkService.isOnline()).thenAnswer((_) async => true);
      when(() => clientService.getAsync(any())).thenAnswer(
        (_) async => Success(Response(
            data: mockJobQuotesJson, requestOptions: RequestOptions())),
      );

      // Act
      final result = await jobQuoteService.getJobQuotes();

      // Assert
      expect(result, isA<Success>());
      final success = result as Success;
      expect(success.value.jobQuotes?.length, 1);
      // expect(success.value.pagination?.totalItemCount, 1);
      verify(() => clientService.getAsync(any())).called(1);
    });

    test('updateJobQuote updates a job quote successfully', () async {
      // Arrange
      const mockUpdateJson = {
        'jobQuoteId': jobQuoteId,
        'jobName': 'Updated Job'
      };
      final jobQuoteUpdate = JobQuoteUpdateParameter(
        jobQuoteId: jobQuoteId,
        jobQuoteLineCollection: [],
      );

      when(() => networkService.isOnline()).thenAnswer((_) async => true);
      when(() => clientService.patchAsync(any(), any())).thenAnswer((_) async =>
          Success(Response(
              data: mockUpdateJson, requestOptions: RequestOptions())));

      // Act
      final result = await jobQuoteService.updateJobQuote(jobQuoteUpdate);

      // Assert
      expect(result, isA<Success>());
      final success = result as Success;
      expect(success.value.jobQuoteId, jobQuoteId);
      expect(success.value.jobName, 'Updated Job');
      verify(() => clientService.patchAsync(any(), any())).called(1);
    });

    test('updateJobQuote fails if jobQuoteId is empty', () async {
      // Arrange
      final jobQuoteUpdate = JobQuoteUpdateParameter(jobQuoteId: '');

      // Act
      final result = await jobQuoteService.updateJobQuote(jobQuoteUpdate);

      // Assert
      expect(result, isA<Failure>());
      final failure = result as Failure;
      expect(failure.errorResponse.message, 'jobQuoteId is required');
    });
  });
}
