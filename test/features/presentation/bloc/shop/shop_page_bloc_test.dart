import 'package:bloc_test/bloc_test.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/analytics_event.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/shop_usecase/shop_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/shop/shop_page_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

import '../../../../sdk/usecases/mock_usecases.dart';

class MockAnalyticsEvent extends Mock implements AnalyticsEvent {}

void main() {
  late ShopUseCase mockShopUseCase;
  late ShopPageBloc sut;

  setUp(() {
    mockShopUseCase = MockShopUseCase();
    sut = ShopPageBloc(shopUseCase: mockShopUseCase);
  });

  setUpAll(() {
    registerFallbackValue(MockAnalyticsEvent());
  });

  tearDown(() {
    sut.close();
  });
  group('ShopPageBloc', () {
    blocTest<ShopPageBloc, ShopPageState>(
      'emits [ShopPageLoadingState, ShopPageLoadedState] when ShopPageLoadEvent is added and loadData succeeds',
      build: () => sut,
      act: (bloc) async {
        when(() => mockShopUseCase.trackEvent(any())).thenAnswer((_) async {});
        when(() => mockShopUseCase.loadData())
            .thenAnswer((_) async => const Success([]));
        bloc.add(const ShopPageLoadEvent());
        await untilCalled(() => mockShopUseCase.loadData());
      },
      expect: () => [
        isA<ShopPageLoadingState>(),
        ShopPageLoadedState(pageWidgets: []),
      ],
    );

    blocTest<ShopPageBloc, ShopPageState>(
      'emits [ShopPageLoadingState, ShopPageFailureState] when ShopPageLoadEvent is added and loadData fails',
      build: () {
        when(() => mockShopUseCase.trackEvent(any())).thenAnswer((_) async {});
        when(() => mockShopUseCase.loadData()).thenAnswer(
            (_) async => Failure(ErrorResponse(errorDescription: 'Error')));
        return sut;
      },
      act: (bloc) async {
        bloc.add(const ShopPageLoadEvent());
        await untilCalled(() => mockShopUseCase.loadData());
      },
      expect: () => [
        isA<ShopPageLoadingState>(),
        ShopPageFailureState('Error'),
      ],
    );
  });
}
