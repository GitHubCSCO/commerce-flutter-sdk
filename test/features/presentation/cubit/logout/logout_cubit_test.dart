import 'package:bloc_test/bloc_test.dart';
import 'package:commerce_flutter_app/features/domain/usecases/logout_usecase/logout_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/logout/logout_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../sdk/usecases/mock_usecases.dart';

void main() {
  group('LogoutCubit', () {
    late LogoutUsecase logoutUsecase;
    late LogoutCubit logoutCubit;

    setUp(() {
      logoutUsecase = MockLogoutUsecase();
      logoutCubit = LogoutCubit(logoutUsecase: logoutUsecase);
    });

    tearDown(() {
      logoutCubit.close();
    });

    blocTest(
      'emits [LogoutLoading, LogoutSuccess] when logout is called successfully',
      build: () {
        when(() => logoutUsecase.logout()).thenAnswer((_) async {});
        return logoutCubit;
      },
      act: (cubit) async {
        await cubit.logout();
      },
      expect: () => [
        LogoutLoading(),
        LogoutSuccess(),
      ],
    );
  });
}
