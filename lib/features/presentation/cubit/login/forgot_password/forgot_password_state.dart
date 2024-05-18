part of 'forgot_password_cubit.dart';

class ForgotPasswordState extends Equatable {
  final ForgotPasswordStatus status;
  final AccountSettingsEntity settings;

  const ForgotPasswordState({
    required this.status,
    required this.settings,
  });

  @override
  List<Object> get props => [status, settings];

  ForgotPasswordState copyWith({
    ForgotPasswordStatus? status,
    AccountSettingsEntity? settings,
  }) {
    return ForgotPasswordState(
      status: status ?? this.status,
      settings: settings ?? this.settings,
    );
  }
}
