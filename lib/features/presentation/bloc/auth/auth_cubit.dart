import 'package:commerce_flutter_app/features/domain/enums/auth_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final IAuthenticationService _authenticationService;

  AuthCubit({required IAuthenticationService authenticationService})
      : _authenticationService = authenticationService,
        super(const AuthState(status: AuthStatus.unknown)) {
    loadAuthenticationState();
  }

  Future<void> loadAuthenticationState() async {
    final authResult = await _authenticationService.isAuthenticatedAsync();
    switch (authResult) {
      case Success(value: final value):
        value! ? authenticated() : unauthenticated();
        break;
      case Failure():
        unauthenticated();
        break;
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
