import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:test/test.dart';

import '../../mocks/mocks.dart';

void main() {
  late InvoiceService sut;
  late MockClientService clientService;
  late MockNetworkService networkService;

  setUp(() {
    clientService = MockClientService();
    networkService = MockNetworkService();
    sut = InvoiceService(
      clientService: clientService,
      networkService: networkService,
      cacheService: MockCacheService(),
    );
  });

  group('getInvoice', () {
    test('should return invoice when successful', () async {
      // Arrange
      final invoiceNumber = 'INV123';
      final expectedInvoice = Invoice(invoiceNumber: invoiceNumber);
      when(() => networkService.isOnline()).thenAnswer((_) async => true);
      when(
        () => clientService.getAsync(
          any(),
        ),
      ).thenAnswer(
        (_) async => Success(
          Response(
            data: expectedInvoice.toJson(),
            requestOptions: RequestOptions(),
            statusCode: 200,
          ),
        ),
      );

      // Act
      final result = await sut
          .getInvoice(InvoiceDetailParameter(invoiceNumber: invoiceNumber));

      // Assert
      switch (result) {
        case Success(value: final value):
          expect(value, isNotNull);
          expect(value?.invoiceNumber.isNullOrEmpty, false);
          expect(value?.invoiceNumber, equals(invoiceNumber));

          verify(() => clientService.getAsync(any())).called(1);
        case Failure():
          fail('Expected Success but got Failure');
      }
    });

    test('should return failure when no internet is found', () async {
      // Arrange
      final invoiceNumber = 'INV123';
      when(() => networkService.isOnline()).thenAnswer((_) async => false);

      // Act
      final result = await sut
          .getInvoice(InvoiceDetailParameter(invoiceNumber: invoiceNumber));

      // Assert
      switch (result) {
        case Success():
          fail('Expected Failure but got Success');
        case Failure(errorResponse: final errorResponse):
          expect(errorResponse.error, equals('No internet found'));
          verifyNever(() => clientService.getAsync(any()));
      }
    });

    test('should return failure when any other kind of failure occurs',
        () async {
      // Arrange
      final invoiceNumber = 'INV123';
      final errorResponse = ErrorResponse(
        error: 'Some error',
        message: 'An unexpected error occurred',
      );
      when(() => networkService.isOnline()).thenAnswer((_) async => true);
      when(() => clientService.getAsync(any())).thenAnswer(
        (_) async => Failure(errorResponse),
      );

      // Act
      final result = await sut
          .getInvoice(InvoiceDetailParameter(invoiceNumber: invoiceNumber));

      // Assert
      switch (result) {
        case Success():
          fail('Expected Failure but got Success');
        case Failure(errorResponse: final response):
          expect(response.error, equals('Some error'));
          expect(response.message, equals('An unexpected error occurred'));
          verify(() => clientService.getAsync(any())).called(1);
      }
    });
  });

  group('getInvoices', () {
    test('should return invoices when successful', () async {
      // Arrange
      final expectedInvoices = [
        Invoice(invoiceNumber: 'INV123'),
        Invoice(invoiceNumber: 'INV124'),
      ];
      final expectedResult = GetInvoiceResult(invoices: expectedInvoices);
      when(() => networkService.isOnline()).thenAnswer((_) async => true);
      when(() => clientService.getAsync(
            any(),
          )).thenAnswer((_) async => Success(Response(
            data: expectedResult.toJson(),
            requestOptions: RequestOptions(),
            statusCode: 200,
          )));

      // Act
      final result = await sut.getInvoices();

      // Assert
      switch (result) {
        case Success(value: final value):
          expect(value?.invoices, isNotEmpty);
          expect(value?.invoices?.length, equals(2));
          verify(() => clientService.getAsync(
                any(),
              )).called(1);
        case Failure():
          fail('Expected Success but got Failure');
      }
    });

    test('should return failure when no internet is found', () async {
      // Arrange
      when(() => networkService.isOnline()).thenAnswer((_) async => false);

      // Act
      final result = await sut.getInvoices();

      // Assert
      switch (result) {
        case Success():
          fail('Expected Failure but got Success');
        case Failure(errorResponse: final errorResponse):
          expect(errorResponse.error, equals('No internet found'));
          verifyNever(() => clientService.getAsync(any()));
      }
    });

    test('should return failure when any other kind of failure occurs',
        () async {
      // Arrange
      final errorResponse = ErrorResponse(
        error: 'Some error',
        message: 'An unexpected error occurred',
      );
      when(() => networkService.isOnline()).thenAnswer((_) async => true);
      when(() => clientService.getAsync(any())).thenAnswer(
        (_) async => Failure(errorResponse),
      );

      // Act
      final result = await sut.getInvoices();

      // Assert
      switch (result) {
        case Success():
          fail('Expected Failure but got Success');
        case Failure(errorResponse: final response):
          expect(response.error, equals('Some error'));
          expect(response.message, equals('An unexpected error occurred'));
          verify(() => clientService.getAsync(any())).called(1);
      }
    });
  });

  group('sendEmail', () {
    test('should send email successfully', () async {
      // Arrange
      final parameters = InvoiceEmailParameter(
        emailTo: 'recipient@example.com',
        emailFrom: 'sender@example.com',
        subject: 'Invoice Details',
        message: 'Please find your invoice attached.',
        entityId: 'INV123',
        entityName: 'Invoice',
      );

      when(() => networkService.isOnline()).thenAnswer((_) async => true);
      when(() => clientService.postAsync(
            any(),
            any(),
          )).thenAnswer((_) async => Success(Response(
            data: true,
            requestOptions: RequestOptions(),
            statusCode: 200,
          )));

      // Act
      final result = await sut.sendEmail(parameters: parameters);

      // Assert
      switch (result) {
        case Success(value: final value):
          expect(value, isTrue);
          verify(() => clientService.postAsync(
                '${CommerceAPIConstants.invoicesUrl}/shareinvoice',
                parameters.toJson(),
              )).called(1);
        case Failure():
          fail('Expected Success but got Failure');
      }
    });

    test('should return failure when no internet is found', () async {
      // Arrange
      final parameters = InvoiceEmailParameter(
        emailTo: 'recipient@example.com',
        emailFrom: 'sender@example.com',
        subject: 'Invoice Details',
        message: 'Please find your invoice attached.',
        entityId: 'INV123',
        entityName: 'Invoice',
      );
      when(() => networkService.isOnline()).thenAnswer((_) async => false);

      // Act
      final result = await sut.sendEmail(parameters: parameters);

      // Assert
      switch (result) {
        case Success():
          fail('Expected Failure but got Success');
        case Failure(errorResponse: final errorResponse):
          expect(errorResponse.error, equals('No internet found'));
          verifyNever(() => clientService.postAsync(any(), any()));
      }
    });

    test('should return failure when any other kind of failure occurs',
        () async {
      // Arrange
      final parameters = InvoiceEmailParameter(
        emailTo: 'recipient@example.com',
        emailFrom: 'sender@example.com',
        subject: 'Invoice Details',
        message: 'Please find your invoice attached.',
        entityId: 'INV123',
        entityName: 'Invoice',
      );
      final errorResponse = ErrorResponse(
        error: 'Some error',
        message: 'An unexpected error occurred',
      );
      when(() => networkService.isOnline()).thenAnswer((_) async => true);
      when(() => clientService.postAsync(any(), any())).thenAnswer(
        (_) async => Failure(errorResponse),
      );

      // Act
      final result = await sut.sendEmail(parameters: parameters);

      // Assert
      switch (result) {
        case Success():
          fail('Expected Failure but got Success');
        case Failure(errorResponse: final response):
          expect(response.error, equals('Some error'));
          expect(response.message, equals('An unexpected error occurred'));
          verify(() => clientService.postAsync(any(), any())).called(1);
      }
    });
  });
}
