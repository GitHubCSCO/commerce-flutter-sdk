import 'package:commerce_flutter_app/features/domain/usecases/domain_selection_usecase/domain_selection_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'settings_domain_state.dart';

class SettingsDomainCubit extends Cubit<SettingsDomainState> {
  final DomainSelectionUsecase _domainSelectionUsecase;

  SettingsDomainCubit({required DomainSelectionUsecase domainSelectionUsecase})
      : _domainSelectionUsecase = domainSelectionUsecase,
        super(SettingsDomainUnknown());

  Future<void> getDomain() async {
    emit(SettingsDomainLoading());
    final result = await _domainSelectionUsecase.getSavedDomain();

    if (result != null) {
      emit(SettingsDomainLoaded(result));
    } else {
      emit(SettingsDomainUnknown());
    }
  }
}
