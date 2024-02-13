import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/features/domain/enums/domain_selection_status.dart';
import 'package:commerce_flutter_app/features/domain/usecases/domain_selection_usecase/domain_selection_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'domain_selection_state.dart';

class DomainSelectionCubit extends Cubit<DomainSelectionState> {
  final DomainSelectionUsecase _domainSelectionUsecase;

  DomainSelectionCubit({required DomainSelectionUsecase domainSelectionUsecase})
      : _domainSelectionUsecase = domainSelectionUsecase, super(DomainSelectionInitial());

  Future<void> selectDomain(String domain) async {
    emit(DomainSelectionInProgress());
    final result = await _domainSelectionUsecase.domainSelectHandler(domain);

    switch (result) {
      case DomainSelectionStatus.success:
        emit(DomainSelectionSuccess());
        break;
      case DomainSelectionStatus.failedOffline:
        emit(
          DomainSelectionFailedOffline(
            'No Internet',
            'Connection cannot be established.',
          ),
        );
        break;
      case DomainSelectionStatus.failedInvalidDomain:
        emit(
          DomainSelectionFailedInvalid(
            LocalizationConstants.invalidDomain,
            LocalizationConstants.domainWebsiteNotResponding,
          ),
        );
        break;
      case DomainSelectionStatus.failedMobileAppDisabled:
        emit(
          DomainSelectionFailedMobileAppDisabled(
            LocalizationConstants.mobileAppDisabled,
            LocalizationConstants.mobileAppDisabledDescription,
          ),
        );
        break;
    }
  }
}
