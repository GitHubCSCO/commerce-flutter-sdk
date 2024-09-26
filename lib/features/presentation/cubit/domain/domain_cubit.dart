import 'package:commerce_flutter_app/core/constants/analytics_constants.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/features/domain/entity/analytics_event.dart';
import 'package:commerce_flutter_app/features/domain/enums/domain_change_status.dart';
import 'package:commerce_flutter_app/features/domain/usecases/domain_usecase/domain_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'domain_state.dart';

class DomainCubit extends Cubit<DomainState> {
  final DomainUsecase _domainUsecase;

  DomainCubit({required DomainUsecase domainUsecase})
      : _domainUsecase = domainUsecase,
        super(DomainUnknown());

  Future<void> fetchDomain() async {
    emit(DomainOperationInProgress());
    final result = await _domainUsecase.getDomain();

    if (result != null) {
      emit(DomainLoaded(result));
    } else {
      emit(DomainOperationFailed('No Domain', ''));
    }
  }

  Future<void> selectDomain(String domain) async {
    emit(DomainOperationInProgress());
    final result = await _domainUsecase.domainSelectHandler(domain);

    switch (result) {
      case DomainChangeStatus.success:
        var analyticsEvent = AnalyticsEvent(
          AnalyticsConstants.eventDomainSelection,
          AnalyticsConstants.screenNameDomainSelection,
        ).withProperty(
            name: AnalyticsConstants.eventPropertyDomain, strValue: domain);
        _domainUsecase.trackEvent(analyticsEvent);
        emit(DomainLoaded(domain));
        break;
      case DomainChangeStatus.failedOffline:
        emit(
          DomainOperationFailedOffline(
            'No Internet',
            'Connection cannot be established.',
          ),
        );
        break;
      case DomainChangeStatus.failedInvalidDomain:
        emit(
          DomainOperationFailedInvalid(
            LocalizationConstants.invalidDomain.localized(),
            LocalizationConstants.domainWebsiteNotResponding.localized(),
          ),
        );
        break;
      case DomainChangeStatus.failedMobileAppDisabled:
        emit(
          DomainOperationFailedMobileAppDisabled(
            LocalizationConstants.mobileAppDisabled.localized(),
            LocalizationConstants.mobileAppDisabledDescription.localized(),
          ),
        );
        break;
    }
  }
}
