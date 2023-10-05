import 'package:commerce_dart_sdk/commerce_dart_sdk.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthenticationService extends Mock
    implements IAuthenticationService {}

class MockClientService extends Mock implements IClientService {}

class MockLocalStorageService extends Mock implements ILocalStorageService {}

class MockProductService extends Mock implements IProductService {}

class MockSecureStorageService extends Mock implements ISecureStorageService {}

class MockSessionService extends Mock implements ISessionService {}
