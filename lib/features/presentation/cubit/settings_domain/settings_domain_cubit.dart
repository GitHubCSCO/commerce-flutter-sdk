import 'package:commerce_flutter_app/features/domain/usecases/domain_usecase/domain_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'settings_domain_state.dart';

class SettingsDomainCubit extends Cubit<SettingsDomainState> {
  final DomainUsecase _domainUsecase;
  SettingsDomainCubit({required DomainUsecase domainUsecase})
      : _domainUsecase = domainUsecase,
        super(SettingsDomainUnknown());

  Future<void> fetchDomain() async {
    emit(SettingsDomainLoading());
    final domain = await _domainUsecase.getDomainInSettingsScreen();
    if (domain == null) {
      emit(SettingsDomainUnknown());
      return;
    }

    emit(SettingsDomainLoaded(domain));
  }
}
