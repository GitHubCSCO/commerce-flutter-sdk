import 'package:commerce_flutter_app/features/domain/enums/login_status.dart';
import 'package:commerce_flutter_app/features/domain/usecases/login_usecase/login_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import '../../injector_mock.dart';

void main() {
  late LoginUsecase loginUsecase;

  setUp(() {
    initInjectionContainerMock();
    loginUsecase = LoginUsecase();
  });

  tearDown(() {});

  test('logInAsync should return Result with bool on successful login',
      () async {
    // Arrange
    const userName = 'testUser';
    const passWord = 'testPassword';
    const expectedResult = LoginStatus.loginSuccessBillToShipTo;

    when(() => loginUsecase.commerceAPIServiceProvider
            .getAuthenticationService()
            .logInAsync(userName, passWord))
        .thenAnswer((_) async => const Success(true));

    when(() => loginUsecase.commerceAPIServiceProvider
        .getSessionService()
        .getCurrentSession()).thenAnswer((_) async => Success(Session()));

    when(() => loginUsecase.commerceAPIServiceProvider
        .getAccountService()
        .getCurrentAccountAsync()).thenAnswer((_) async => Success(Account()));

    // Act
    final result = await loginUsecase.attemptSignIn(userName, passWord);

    // Assert
    expect(result, expectedResult);
  });
}
