part of 'account_header_cubit.dart';

sealed class AccountHeaderState extends Equatable {
  const AccountHeaderState();

  @override
  List<Object> get props => [];
}

final class AccountHeaderInitial extends AccountHeaderState {}

final class AccountHeaderLoaded extends AccountHeaderState {
  final String firstName;
  final String lastName;
  final String email;

  const AccountHeaderLoaded({
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  @override
  List<Object> get props => [firstName, lastName, email];
}
