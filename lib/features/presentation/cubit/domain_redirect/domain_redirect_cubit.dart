import 'package:commerce_flutter_app/features/domain/enums/domain_redirect_status.dart';
import 'package:commerce_flutter_app/features/domain/usecases/domain_usecase/domain_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DomainRedirectCubit extends Cubit<DomainRedirectStatus> {
  final DomainUsecase _domainUsecase;

  DomainRedirectCubit({required DomainUsecase domainUsecase})
      : _domainUsecase = domainUsecase,
        super(DomainRedirectStatus.unknown);

  Future<void> redirect() async {
    emit(DomainRedirectStatus.loading);
    final result = await _domainUsecase.getDomain();

    if (result != null) {
      emit(DomainRedirectStatus.redirect);
    } else {
      emit(DomainRedirectStatus.doNotRedirect);
    }
  }
}
