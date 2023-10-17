/// This is an example of how to use the cart service
/// Do not run this file in here since it will fail to run
/// due to not having the correct configuration set for
/// different platforms

import 'package:commerce_dart_sdk/commerce_dart_sdk.dart';
import 'package:commerce_dart_sdk/src/services/session_service.dart';
import '../../test/fakes/fakes.dart';

void main() async {
  final ILocalStorageService localStorageService = FakeLocalStorageService();
  final ISecureStorageService secureStorageService = FakeSecureStorageService();

  ClientConfig.hostUrl = 'https://example.com';
  ClientConfig.clientId = 'fluttermobile';
  ClientConfig.clientSecret = '1234-1234-1234-1234';

  final ClientService clientService = ClientService(
      localStorageService: localStorageService,
      secureStorageService: secureStorageService);

  final ISessionService sessionService =
      SessionService(clientService: clientService);
  final IAuthenticationService authenticationService = AuthenticationService(
      clientService: clientService, sessionService: sessionService);
  final ICartService cartService = CartService(clientService: clientService);

  // Authenticate
  await authenticationService.logInAsync('user', 'password1');

  // Get all carts
  final getCartResponse = await cartService
      .getCurrentCart(CartQueryParameters(expand: ['cartLines']));

  // ignore: avoid_print
  print(getCartResponse);
}
