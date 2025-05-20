# Optimizely Configured Commerce Mobile API SDK(optimizely_commerce_api)

![Coverage](./coverage_badge.svg?sanitize=true)

Optimizely's (SAAS)Commerce API SDK for Dart and Flutter is a package designed to simplify interaction with the Commerce API using Dart's language features. This SDK offers a robust, object-oriented interface, eliminating the need for direct HTTP calls and ensuring stability by abstracting underlying API changes.

Developers can seamlessly integrate B2B Commerce functionalities into Dart applications, benefiting from the versatility of Flutter for cross-platform development.

By adopting the Dart and Flutter-based SDK, developers gain an efficient means to extract data from the (SAAS)Commerce system.

This package contains all of the endpoints provided by Optimizely Commerce API. A comprehensive list of services can be found in the swagger API documentation [here](https://docs.developers.optimizely.com/configured-commerce/reference/getting-started-with-the-b2b-commerce-rest-apis).

## Setup

To use `optimizely_commerce_api` in your project, see the [example].

## Example

```dart
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

void main() async {
  final localStorageService = FakeLocalStorageService();
  final secureStorageService = FakeSecureStorageService();

  ClientConfig.hostUrl = "your_commerce_website_url_goes_here";
  ClientConfig.clientId = "get_the_client_id_from_admin_console";
  ClientConfig.clientSecret = "get_the_client_secret_from_admin_console";

  final clientService = ClientService(
    localStorageService: localStorageService,
    secureStorageService: secureStorageService,
  );

  final cacheService = FakeCacheService();
  final networkService = FakeNetworkService(true);

  final sessionService = SessionService(
    clientService: clientService,
    cacheService: cacheService,
    networkService: networkService,
  );

  final authenticationService = AuthenticationService(
    clientService: clientService,
    sessionService: sessionService,
    cacheService: cacheService,
    networkService: networkService,
  );

  final accountService = AccountService(
    clientService: clientService,
    networkService: networkService,
    cacheService: cacheService,
  );

  // Authenticate
  await authenticationService.logInAsync(
      "your_username", "your_password");

  // Get all account
  final accountResponse = await accountService.getAccountsAsync();

  switch (accountResponse) {
    case Success(value: final value):
      {
        print(value?.accounts?[0].userName);
      }
    case Failure(errorResponse: final errorResponse):
      {
        print(errorResponse.message);
      }
  }
}
```

## Test coverage

- These instructions are tested in mac
- Run `dart pub global activate coverage`
- Run `dart pub global run coverage:test_with_coverage`
- Run `brew install lcov`
- Run `genhtml coverage/lcov.info -o coverage/`
- Open `coverage/index.html` in your browser to see test coverage report
- To create the badge run `node badge_generator.js`
