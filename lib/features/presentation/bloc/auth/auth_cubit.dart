import 'package:commerce_flutter_app/features/domain/enums/auth_status.dart';
import 'package:commerce_flutter_app/features/domain/usecases/auth_usecase/auth_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthUsecase _authUsecase;

  AuthCubit({required AuthUsecase authUsecase})
      : _authUsecase = authUsecase,
        super(const AuthState(status: AuthStatus.unknown)) {
    loadAuthenticationState();
  }

  Future<void> loadAuthenticationState() async {
    final isAuthenticated = await _authUsecase.isAuthenticated();
    if (isAuthenticated) {
      authenticated();
    } else {
      unauthenticated();
    }
  }

  void authenticated() => emit(const AuthState.authenticated());

  void unauthenticated() => emit(const AuthState.unauthenticated());

  @override
  void onChange(Change<AuthState> change) {
    print(change);
    super.onChange(change);
  }
}
