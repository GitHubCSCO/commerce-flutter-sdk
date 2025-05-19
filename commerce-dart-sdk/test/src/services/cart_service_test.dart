import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../mocks/mocks.dart';

void main() {
  late CartService sut;
  late MockClientService clientService;
  late MockNetworkService networkService;

  setUp(() {
    clientService = MockClientService();
    networkService = MockNetworkService();
    sut = CartService(
      clientService: clientService,
      networkService: networkService,
      cacheService: MockCacheService(),
    );
  });

  group('addCartLine', () {
    test('should add cart line to the cart', () async {
      // Arrange
      final cartLine = AddCartLine(productId: '1', qtyOrdered: 2);
      final expectedResponseModel = CartLine()
        ..qtyOrdered = 2
        ..productId = '1';
      when(
        () => networkService.isOnline(),
      ).thenAnswer(
        (_) => Future.value(true),
      );
      when(() => clientService.postAsync(
            any(),
            any(),
            cancelToken: any(named: 'cancelToken'),
          )).thenAnswer(
        (_) => Future.value(
          Success(
            Response(
              data: expectedResponseModel.toJson(),
              requestOptions: RequestOptions(),
              statusCode: 200,
            ),
          ),
        ),
      );

      // Act
      final response = await sut.addCartLine(cartLine);

      switch (response) {
        case Success(value: final value):
          {
            expect(value, isNotNull);
            expect(value, isA<CartLine>());
            expect(value?.toJson(), equals(expectedResponseModel.toJson()));

            verify(() => clientService.postAsync(
                  any(),
                  any(),
                  cancelToken: any(named: 'cancelToken'),
                ));
          }
        case Failure():
          {
            fail('Should not be a failure');
          }
      }

      // Assert
      // expect(response.?.toJson(), isNotNull);
      // expect(
      //   response.model?.toJson().toString(),
      //   expectedResponseModel.toJson().toString(),
      // );
    });
  });

  // group('addCartLineCollection', () {
  //   test('should add cart line collection to the cart', () async {
  //     // Arrange
  //     final cartLineCollection = [
  //       AddCartLine(productId: '1', qtyOrdered: 2),
  //       AddCartLine(productId: '2', qtyOrdered: 3),
  //     ];
  //     final expectedResponse = ServiceResponse<List<CartLine>>(
  //       model: [
  //         CartLine(id: '1', quantity: 2),
  //         CartLine(id: '2', quantity: 3),
  //       ],
  //       statusCode: 200,
  //     );
  //     when(clientService.postAsyncNoCache<CartLineList>(
  //       any,
  //       any,
  //       any,
  //     )).thenAnswer((_) async => ServiceResponse<CartLineList>(
  //           model: CartLineList(cartLines: expectedResponse.model!),
  //           statusCode: expectedResponse.statusCode,
  //         ));

  //     // Act
  //     final response =
  //         await sut.addCartLineCollection(cartLineCollection);

  //     // Assert
  //     expect(response, equals(expectedResponse));
  //     verify(clientService.postAsyncNoCache<CartLineList>(
  //       any,
  //       any,
  //       any,
  //     ));
  //   });
  // });

  // group('addWishListToCart', () {
  //   test('should add wishlist to the cart', () async {
  //     // Arrange
  //     final wishListId = '1';
  //     final expectedResponse = ServiceResponse<CartLineCollectionDto>(
  //       model: CartLineCollectionDto(cartLines: []),
  //       statusCode: 200,
  //     );
  //     when(clientService.postAsyncNoCache<CartLineCollectionDto>(
  //       any,
  //       any,
  //       any,
  //     )).thenAnswer((_) async => expectedResponse);

  //     // Act
  //     final response = await sut.addWishListToCart(wishListId);

  //     // Assert
  //     expect(response, equals(expectedResponse));
  //     verify(clientService.postAsyncNoCache<CartLineCollectionDto>(
  //       any,
  //       any,
  //       any,
  //     ));
  //   });
  // });

  // group('applyPromotion', () {
  //   test('should apply promotion to the cart', () async {
  //     // Arrange
  //     final promotion = AddPromotion(code: 'PROMO');
  //     final expectedResponse = ServiceResponse<Promotion>(
  //       model: Promotion(id: '1', code: 'PROMO'),
  //       statusCode: 200,
  //     );
  //     when(clientService.postAsyncNoCache<Promotion>(
  //       any,
  //       any,
  //       any,
  //     )).thenAnswer((_) async => expectedResponse);

  //     // Act
  //     final response = await sut.applyPromotion(promotion);

  //     // Assert
  //     expect(response, equals(expectedResponse));
  //     verify(clientService.postAsyncNoCache<Promotion>(
  //       any,
  //       any,
  //       any,
  //     ));
  //   });
  // });

  // group('approveCart', () {
  //   test('should approve the cart', () async {
  //     // Arrange
  //     final cart = Cart(id: '1');
  //     final expectedResponse = ServiceResponse<Cart>(
  //       model: Cart(id: '1', status: 'approved'),
  //       statusCode: 200,
  //     );
  //     when(clientService.patchAsyncNoCache<Cart>(
  //       any,
  //       any,
  //       any,
  //     )).thenAnswer((_) async => expectedResponse);

  //     // Act
  //     final response = await sut.approveCart(cart);

  //     // Assert
  //     expect(response, equals(expectedResponse));
  //     verify(clientService.patchAsyncNoCache<Cart>(
  //       any,
  //       any,
  //       any,
  //     ));
  //   });

  //   test('should throw an exception if cartId is empty', () async {
  //     // Arrange
  //     final cart = Cart(id: '');
  //     final expectedResponse = ServiceResponse<Cart>(
  //       exception: Exception('cartId is empty'),
  //     );

  //     // Act
  //     final response = await sut.approveCart(cart);

  //     // Assert
  //     expect(response, equals(expectedResponse));
  //   });
  // });

  // group('clearCart', () {
  //   test('should clear the cart', () async {
  //     // Arrange
  //     final expectedResponse = true;
  //     when(clientService.deleteAsync(any)).thenAnswer((_) async =>
  //         ServiceResponse<dynamic>(
  //             model: null, statusCode: 200, error: null, exception: null));

  //     // Act
  //     final response = await sut.clearCart();

  //     // Assert
  //     expect(response, equals(expectedResponse));
  //     expect(sut.isCartEmpty, isTrue);
  //     verify(clientService.deleteAsync(any));
  //   });

  //   test('should return false if an exception is thrown', () async {
  //     // Arrange
  //     final expectedResponse = false;
  //     when(clientService.deleteAsync(any)).thenThrow(Exception());

  //     // Act
  //     final response = await sut.clearCart();

  //     // Assert
  //     expect(response, equals(expectedResponse));
  //     expect(sut.isCartEmpty, isNull);
  //     verify(clientService.deleteAsync(any));
  //   });
  // });

  // group('createAlternateCart', () {
  //   test('should create an alternate cart', () async {
  //     // Arrange
  //     final addCartModel = AddCartModel();
  //     final expectedResponse = ServiceResponse<Cart>(
  //       model: Cart(id: '1'),
  //       statusCode: 200,
  //     );
  //     when(clientService.postAsyncNoCache<Cart>(
  //       any,
  //       any,
  //       any,
  //     )).thenAnswer((_) async => expectedResponse);

  //     // Act
  //     final response = await sut.createAlternateCart(addCartModel);

  //     // Assert
  //     expect(response, equals(expectedResponse));
  //     verify(clientService.postAsyncNoCache<Cart>(
  //       any,
  //       any,
  //       any,
  //     ));
  //   });
  // });

  // group('deleteCart', () {
  //   test('should delete the cart', () async {
  //     // Arrange
  //     final cartId = '1';
  //     final expectedResponse = true;
  //     when(clientService.deleteAsync(any)).thenAnswer((_) async =>
  //         ServiceResponse<dynamic>(
  //             model: null, statusCode: 200, error: null, exception: null));

  //     // Act
  //     final response = await sut.deleteCart(cartId);

  //     // Assert
  //     expect(response, equals(expectedResponse));
  //     verify(clientService.deleteAsync(any));
  //   });
  // });
}
