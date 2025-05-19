part of 'settings_domain_cubit.dart';

sealed class SettingsDomainState extends Equatable {
  const SettingsDomainState();

  @override
  List<Object> get props => [];
}

final class SettingsDomainUnknown extends SettingsDomainState {}

final class SettingsDomainLoading extends SettingsDomainState {}

final class SettingsDomainLoaded extends SettingsDomainState {
  final String domain;

  const SettingsDomainLoaded(this.domain);

  @override
  List<Object> get props => [domain];
}
