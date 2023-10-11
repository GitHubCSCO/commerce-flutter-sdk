// ignore_for_file: avoid_print

// class MockLocalStorageService implements ILocalStorageService {
//   Map<String, String?> store = {};

//   @override
//   String? load(String key) => store[key];

//   @override
//   Future<void> remove(String key) async {
//     store.remove(key);
//   }

//   @override
//   Future<void> save(String key, String value) async {
//     store[key] = value;
//   }
// }

// class MockSecureStorageService implements ISecureStorageService {
//   Map<String, String?> store = {};

//   @override
//   String? load(String key) => store[key];

//   @override
//   Future<void> remove(String key) async {
//     store.remove(key);
//   }

//   @override
//   Future<void> save(String key, String value) async {
//     store[key] = value;
//   }
// }

void main() {
  // ILocalStorageService localStorageService = MockLocalStorageService();
  // ISecureStorageService secureStorageService = MockSecureStorageService();

  // // used Implementation rather than Interface of clientService
  // // to get the cookies
  // ClientService clientService = ClientService(
  //   localStorageService: localStorageService,
  //   secureStorageService: secureStorageService,
  // );

  // ISessionService sessionService = SessionService(clientService: clientService);

  // IAuthenticationService authService = AuthenticationService(
  //   clientService: clientService,
  //   sessionService: sessionService,
  // );

  // clientService.host = 'https://mobilespire.commerce.insitesandbox.com';
  // ClientConfig.hostUrl = 'https://mobilespire.commerce.insitesandbox.com';
  // ClientConfig.clientId = 'fluttermobile';
  // ClientConfig.clientSecret = 'd66d0479-07f7-47b2-ee1e-0d3a536e6091';

  // var userName = 'saif';
  // var password = 'tester1';

  // group(
  //   'Authentication Test',
  //   () => {
  //     test('Login and session', () async {
  //       await authService.logInAsync(userName, password);
  //       // var sessionResponse = await sessionService.getCurrentSession();
  //       // var session = sessionResponse.model;

  //       bool flag = (await authService.isAuthenticatedAsync()).model!;

  //       // if (session == null) {
  //       //   print('NULL SESSION!');
  //       //   return;
  //       // }

  //       // print(session);
  //       // print(session.toJson());

  //       expect(flag, true);
  //     }),
  //     test('Recieved cookies', () async {
  //       var cookiesList = await clientService.cookies;
  //       if (cookiesList.isEmpty) return;
  //       for (Cookie cookie in cookiesList) {
  //         print('${cookie.name} ${cookie.value}');
  //       }
  //     }),
  //     test('Stored cookies', () async {
  //       var cookiesStr = localStorageService.load('cookies');
  //       if (cookiesStr == null) return;

  //       print(cookiesStr);
  //     }),
  //     test('Logout', () async {
  //       await authService.logoutAsync();
  //       var sessionResponse = await sessionService.getCurrentSession();
  //       var session = sessionResponse.model;

  //       print(session);

  //       bool flag = (await authService.isAuthenticatedAsync()).model!;
  //       expect(flag, false);
  //     })
  //   },
  // );
}
