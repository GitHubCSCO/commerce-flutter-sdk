import 'package:commerce_flutter_app/features/domain/enums/login_status.dart';
import 'package:commerce_flutter_app/features/domain/usecases/login_usecase/login_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import '../../injector_mock.dart';

void main() async {
  late LoginUsecase sut;

  setUp(() async {
    initInjectionContainerMock();
    await GetIt.I.allReady();

    sut = LoginUsecase();
  });

  tearDown(() {
    // Reset GetIt after each test
    GetIt.I.reset();
  });

  test('attemptSignIn should return loginErrorOffline when offline', () async {
    const userName = 'testUser';
    const passWord = 'testPassword';
    const expectedResult = LoginStatus.loginErrorOffline;

    when(() => sut.commerceAPIServiceProvider.getNetworkService().isOnline())
        .thenAnswer((_) async => false);

    final result = await sut.attemptSignIn(userName, passWord);

    expect(result, expectedResult);
  });

  test('attemptSignIn should return loginErrorUnsuccessful when login fails',
      () async {
    const userName = 'testUser';
    const passWord = 'testPassword';
    const expectedResult = LoginStatus.loginErrorUnsuccessful;

    when(() => sut.commerceAPIServiceProvider.getNetworkService().isOnline())
        .thenAnswer((_) async => true);

    when(() => sut.commerceAPIServiceProvider
        .getSessionService()
        .getCurrentSession()).thenAnswer((_) async => Success(Session()));

    when(() =>
        sut.commerceAPIServiceProvider
            .getAuthenticationService()
            .logInAsync(userName, passWord)).thenAnswer(
        (_) async => Failure(ErrorResponse(message: 'loginErrorUnsuccessful')));

    final result = await sut.attemptSignIn(userName, passWord);

    expect(result, expectedResult);
  });

  test(
      'attemptSignIn should return loginErrorUnknown when session retrieval fails',
      () async {
    const userName = 'testUser';
    const passWord = 'testPassword';
    const expectedResult = LoginStatus.loginErrorUnknown;

    when(() => sut.commerceAPIServiceProvider.getNetworkService().isOnline())
        .thenAnswer((_) async => true);

    when(() => sut.commerceAPIServiceProvider
        .getAuthenticationService()
        .logInAsync(userName, passWord)).thenAnswer((_) async => Success(true));

    when(() => sut.commerceAPIServiceProvider
            .getSessionService()
            .getCurrentSession())
        .thenAnswer(
            (_) async => Failure(ErrorResponse(message: 'loginErrorUnknown')));

    final result = await sut.attemptSignIn(userName, passWord);

    expect(result, expectedResult);
  });

  test(
      'attemptSignIn should return loginErrorUnknown when account retrieval fails',
      () async {
    const userName = 'testUser';
    const passWord = 'testPassword';
    const expectedResult = LoginStatus.loginErrorUnknown;

    when(() => sut.commerceAPIServiceProvider.getNetworkService().isOnline())
        .thenAnswer((_) async => true);

    when(() => sut.commerceAPIServiceProvider
        .getAuthenticationService()
        .logInAsync(userName, passWord)).thenAnswer((_) async => Success(true));

    when(() => sut.commerceAPIServiceProvider
        .getSessionService()
        .getCurrentSession()).thenAnswer((_) async => Success(Session()));

    when(() => sut.commerceAPIServiceProvider
            .getAccountService()
            .getCurrentAccountAsync())
        .thenAnswer(
            (_) async => Failure(ErrorResponse(message: 'loginErrorUnknown')));

    final result = await sut.attemptSignIn(userName, passWord);

    expect(result, expectedResult);
  });
}
