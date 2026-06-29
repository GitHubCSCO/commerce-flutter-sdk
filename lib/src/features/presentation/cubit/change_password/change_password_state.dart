part of 'change_password_cubit.dart';

sealed class ChangePasswordState extends Equatable {
  const ChangePasswordState();

  @override
  List<Object> get props => [];
}

class ChangePasswordInitial extends ChangePasswordState {
  const ChangePasswordInitial();
}

class ChangePasswordLoading extends ChangePasswordState {
  const ChangePasswordLoading();
}

class ChangePasswordSuccess extends ChangePasswordState {
  final String newPassword;

  const ChangePasswordSuccess(this.newPassword);

  @override
  List<Object> get props => [newPassword];
}

class ChangePasswordFailure extends ChangePasswordState {
  final String message;

  const ChangePasswordFailure(this.message);

  @override
  List<Object> get props => [message];
}
