import 'package:commerce_flutter_app/features/domain/enums/auth_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthState(status: AuthStatus.unknowm));

  void authenticated() => emit(const AuthState.authenticated());

  void unauthenticated() => emit(const AuthState.unauthenticated());

  @override
  void onChange(Change<AuthState> change) {
    print(change);
    super.onChange(change);
  }
}
