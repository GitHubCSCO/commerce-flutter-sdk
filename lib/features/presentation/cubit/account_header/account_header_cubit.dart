import 'package:commerce_flutter_app/features/domain/usecases/account_usecase/account_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'account_header_state.dart';

class AccountHeaderCubit extends Cubit<AccountHeaderState> {
  final AccountUseCase accountUseCase;
  AccountHeaderCubit({required this.accountUseCase})
      : super(AccountHeaderInitial());

  void loadAccountHeader() {
    final firstName = accountUseCase.firstName;
    final lastName = accountUseCase.lastName;
    final userName = accountUseCase.userName;
    final email = accountUseCase.email;

    emit(
      AccountHeaderLoaded(
        firstName: firstName ?? '',
        lastName: lastName ?? '',
        userName: userName ?? '',
        email: email ?? '',
      ),
    );
  }
}
