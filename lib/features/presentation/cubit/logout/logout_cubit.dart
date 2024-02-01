import 'package:commerce_flutter_app/features/domain/usecases/logout_usecase/logout_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  final LogoutUsecase _logoutUsecase;

  LogoutCubit({required LogoutUsecase logoutUsecase})
      : _logoutUsecase = logoutUsecase,
        super(LogoutInitial());

  Future<void> logout() async {
    emit(LogoutLoading());
    await _logoutUsecase.logout();
    emit(LogoutSuccess());
  }
}
