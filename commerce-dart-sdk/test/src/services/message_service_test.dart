import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:test/test.dart';

import '../../mocks/mocks.dart';

void main() {
  late MessageService messageService;
  late MockClientService clientService;
  late MockCacheService cacheService;
  late MockNetworkService networkService;

  setUp(() {
    clientService = MockClientService();
    cacheService = MockCacheService();
    networkService = MockNetworkService();

    messageService = MessageService(
      clientService: clientService,
      cacheService: cacheService,
      networkService: networkService,
    );

    registerFallbackValue(Uri());
  });

  group('MessageService', () {
    const mockMessageJson = {
      'customerOrderId': 'order123',
      'toUserProfileId': 'user123',
      'toUserProfileName': 'John Doe',
      'subject': 'Test Subject',
      'message': 'This is a test message',
      'process': 'Test Process'
    };

    final mockMessageDto = MessageDto(
      customerOrderId: 'order123',
      toUserProfileId: 'user123',
      toUserProfileName: 'John Doe',
      subject: 'Test Subject',
      message: 'This is a test message',
      process: 'Test Process',
    );

    test('addMessage returns a MessageDto on success', () async {
      // Arrange
      when(() => networkService.isOnline()).thenAnswer((_) async => true);
      when(() => clientService.postAsync(any(), any())).thenAnswer(
        (_) async => Success(
            Response(data: mockMessageJson, requestOptions: RequestOptions())),
      );

      // Act
      final result = await messageService.addMessage(mockMessageDto);

      // Assert
      expect(result, isA<Success>());
      final success = result as Success;
      expect(success.value.customerOrderId, 'order123');
      expect(success.value.toUserProfileName, 'John Doe');
      verify(() => clientService.postAsync(any(), any())).called(1);
    });

    test('addMessage fails when message data is invalid', () async {
      // Arrange
      final invalidMessageDto = MessageDto(); // Empty MessageDto
      when(() => networkService.isOnline()).thenAnswer((_) async => true);
      when(() => clientService.postAsync(any(), any())).thenAnswer(
        (_) async => Failure(ErrorResponse(message: 'Invalid message data')),
      );

      // Act
      final result = await messageService.addMessage(invalidMessageDto);

      // Assert
      expect(result, isA<Failure>());
      final failure = result as Failure;
      expect(failure.errorResponse.message, 'Invalid message data');
      verify(() => clientService.postAsync(any(), any())).called(1);
    });

    test('addMessage handles network failure gracefully', () async {
      // Arrange
      when(() => networkService.isOnline()).thenAnswer((_) async => true);
      when(() => clientService.postAsync(any(), any())).thenAnswer(
        (_) async => Failure(ErrorResponse(
          error: "Connection timeout",
          exception: DioException(
            requestOptions: RequestOptions(),
            type: DioExceptionType.connectionTimeout,
          ),
        )),
      );

      // Act
      final result = await messageService.addMessage(mockMessageDto);

      // Assert
      expect(result, isA<Failure>());
      final failure = result as Failure;
      expect(failure.errorResponse.error, contains('Connection timeout'));
      verify(() => clientService.postAsync(any(), any())).called(1);
    });
  });
}
