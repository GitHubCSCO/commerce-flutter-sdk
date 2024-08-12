import 'package:bloc_test/bloc_test.dart';
import 'package:commerce_flutter_app/features/domain/usecases/logout_usecase/logout_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/logout/logout_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../sdk/usecases/mock_usecases.dart';

void main() {
  late LogoutUsecase mockLogoutUsecase;
  late LogoutCubit sut;

  setUp(() {
    mockLogoutUsecase = MockLogoutUsecase();
    sut = LogoutCubit(logoutUsecase: mockLogoutUsecase);
  });

  tearDown(() {
    sut.close();
  });

  group('LogoutCubit', () {
    blocTest(
      'emits [LogoutLoading, LogoutSuccess] when logout is called successfully',
      build: () {
        when(() => mockLogoutUsecase.logout()).thenAnswer((_) async {});
        when(() => mockLogoutUsecase.getDomainInSettingsScreen())
            .thenAnswer((_) async => null);
        when(() => mockLogoutUsecase.checkSignInRequired())
            .thenAnswer((_) async => false);
        return sut;
      },
      act: (cubit) async {
        await cubit.logout();
      },
      expect: () => [
        LogoutLoading(),
        isA<LogoutSuccess>(),
      ],
    );
    //TODO
    //Seems like we don't have LogoutFailed State. Need to look into it later
  });
}
