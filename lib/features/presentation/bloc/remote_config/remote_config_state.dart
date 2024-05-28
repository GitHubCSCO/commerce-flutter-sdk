part of 'remote_config_cubit.dart';

sealed class RemoteConfigState extends Equatable {
  const RemoteConfigState();

  @override
  List<Object?> get props => [];
}

final class RemoteConfigInitial extends RemoteConfigState {}

final class RemoteConfigLoading extends RemoteConfigState {}

final class RemoteConfigDebugCredentialsLoaded extends RemoteConfigState {
  final List<Map<String,String>>? creds;
  const RemoteConfigDebugCredentialsLoaded({required this.creds});
    
  @override
  List<Object?> get props => [creds];
}

final class RemoteConfigDebugDomainLoaded extends RemoteConfigState {
  final Map<String, String> domains;
  const RemoteConfigDebugDomainLoaded({required this.domains});
  
  @override
  List<Object?> get props => [domains];
}
