import 'dart:async';

import 'package:commerce_flutter_app/features/domain/enums/auth_status.dart';
import 'package:commerce_flutter_app/features/domain/usecases/auth_usecase/auth_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthUsecase _authUsecase;
  final IAuthStreamService _authStreamService;
  late final StreamSubscription<AuthSDKStatus> _authSubscription;

  AuthCubit({
    required AuthUsecase authUsecase,
    required IAuthStreamService authStreamService,
  })  : _authUsecase = authUsecase,
        _authStreamService = authStreamService,
        super(const AuthState(status: AuthStatus.unknown)) {
    // Listen to the authStatusStream and handle status changes
    _authSubscription = _authStreamService.authStatusStream.listen((status) {
      if (status == AuthSDKStatus.loggedIn) {
        authenticated();
      } else if (status == AuthSDKStatus.loggedOut) {
        unauthenticated();
        autoLogout();
      }
    });
  }

  Future<bool> loadAuthenticationState() async {
    final isAuthenticated = await _authUsecase.isAuthenticated();
    // Load as soon as we know auth status and it is safe to call get current session
    if (isAuthenticated) {
      authenticated();
      return true;
    } else {
      unauthenticated();
      return false;
    }
  }

  void authenticated() => emit(const AuthState.authenticated());

  void unauthenticated() => emit(const AuthState.unauthenticated());
  void autoLogout() => emit(const AuthState.autoLogout());

  void reset() => emit(const AuthState(status: AuthStatus.unknown));

  @override
  void onChange(Change<AuthState> change) {
    super.onChange(change);
  }

  @override
  Future<void> close() {
    _authSubscription
        .cancel(); // Cancel the subscription when the cubit is closed
    return super.close();
  }
}

bool authCubitChangeTrigger(AuthState previous, AuthState current) {
  return previous.status != current.status &&
      current.status != AuthStatus.unknown &&
      previous.status != AuthStatus.unknown;
}
