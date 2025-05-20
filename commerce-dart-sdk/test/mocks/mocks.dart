import 'package:dio/dio.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthenticationService extends Mock
    implements IAuthenticationService {}

class MockClientService extends Mock implements IClientService {}

class MockLocalStorageService extends Mock implements ILocalStorageService {}

class MockProductService extends Mock implements IProductService {}

class MockSecureStorageService extends Mock implements ISecureStorageService {}

class MockSessionService extends Mock implements ISessionService {}

class MockCacheService extends Mock implements ICacheService {}

class MockNetworkService extends Mock implements INetworkService {}

class MockErrorInterceptorHandler extends Mock
    implements ErrorInterceptorHandler {}

class MockRequestInterceptorHandler extends Mock
    implements RequestInterceptorHandler {}

class MockResponseInterceptorHandler extends Mock
    implements ResponseInterceptorHandler {}

class MockDioException extends Mock implements DioException {}

class MockRequestOptions extends Mock implements RequestOptions {}

class MockResponse extends Mock implements Response {}
