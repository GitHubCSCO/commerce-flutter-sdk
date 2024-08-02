import 'package:commerce_flutter_app/features/domain/usecases/remote_config/remote_config_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'remote_config_state.dart';

class RemoteConfigCubit extends Cubit<RemoteConfigState> {
  final RemoteConfigUsecase _remoteConfigUsecase;

  RemoteConfigCubit({required RemoteConfigUsecase remoteConfigUsecase})
      : _remoteConfigUsecase = remoteConfigUsecase,
        super(RemoteConfigInitial());

  Future<void> fetchDebugCredential(String domain) async {
    emit(RemoteConfigLoading());
    var debugCredentials =
        await _remoteConfigUsecase.fetchDebugCredential(domain);
    emit(RemoteConfigDebugCredentialsLoaded(creds: debugCredentials));
  }

  Future<void> fetchDebugDomains() async {
    emit(RemoteConfigLoading());
    var domainMaps = await _remoteConfigUsecase.fetchDebugDomains();
    emit(RemoteConfigDebugDomainLoaded(domains: domainMaps));
  }
}
