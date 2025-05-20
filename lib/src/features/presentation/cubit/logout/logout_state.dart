part of 'logout_cubit.dart';

sealed class LogoutState extends Equatable {
  const LogoutState();

  @override
  List<Object> get props => [];
}

final class LogoutInitial extends LogoutState {}

final class LogoutLoading extends LogoutState {}

final class LogoutSuccess extends LogoutState {
  final String? domain;
  final bool isSignInRequired;

  const LogoutSuccess({
    this.domain,
    this.isSignInRequired = false,
  });

  @override
  List<Object> get props => [
        domain ?? '',
        isSignInRequired,
      ];

  LogoutSuccess copyWith({
    String? domain,
    bool? isSignInRequired,
  }) {
    return LogoutSuccess(
      domain: domain ?? this.domain,
      isSignInRequired: isSignInRequired ?? this.isSignInRequired,
    );
  }
}
