import 'package:commerce_flutter_app/features/domain/enums/domain_redirect_status.dart';
import 'package:commerce_flutter_app/features/domain/usecases/domain_selection_usecase/domain_selection_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DomainRedirectCubit extends Cubit<DomainRedirectStatus> {
  final DomainSelectionUsecase _domainSelectionUsecase;

  DomainRedirectCubit({required DomainSelectionUsecase domainSelectionUsecase})
      : _domainSelectionUsecase = domainSelectionUsecase,
        super(DomainRedirectStatus.unknown);

  Future<void> redirect() async {
    emit(DomainRedirectStatus.loading);
    final result = await _domainSelectionUsecase.getSavedDomain();

    if (result != null) {
      emit(DomainRedirectStatus.redirect);
    } else {
      emit(DomainRedirectStatus.doNotRedirect);
    }
  }
}
