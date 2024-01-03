import 'package:commerce_flutter_app/features/domain/usecases/login_usecase/login_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class MockAuthenticationService extends Mock
    implements IAuthenticationService {}

void main() {
  late LoginUsecase loginUsecase;
  late MockAuthenticationService mockAuthService;

  setUp(() {
    mockAuthService = MockAuthenticationService();
    loginUsecase = LoginUsecase(mockAuthService);
  });

  tearDown(() {

  });

  test('logInAsync should return Result with bool on successful login', () async {
    // Arrange
    const username = 'testUser';
    const password = 'testPassword';
    const expectedResult = Success(true);

    when(() => mockAuthService.logInAsync(username, password))
        .thenAnswer((_) async => Future.value(const Success(true)));

    // Act
    final result = await loginUsecase.logInAsync(username, password);

    // Assert
    // expect(result, expectedResult);
    switch (result) {
      case Success(value: final value):
        {
          expect(value, expectedResult.value);
        }
      case Failure():
        {
          fail('Should not be a failure');
        }
    }

    verify(() => mockAuthService.logInAsync(username, password)).called(1);
    verifyNoMoreInteractions(mockAuthService);
  });

  test('logoutAsync should call authService.logoutAsync', () async {
    // Arrange

    when(() => mockAuthService.logoutAsync()).thenAnswer((_) async => Future.value());
    // Act
    await loginUsecase.logoutAsync();

    // Assert
    verify(() => mockAuthService.logoutAsync()).called(1);
    verifyNoMoreInteractions(mockAuthService);
  });
}