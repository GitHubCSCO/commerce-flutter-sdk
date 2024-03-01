import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'domain_change_state.dart';

class DomainChangeCubit extends Cubit<DomainChangeState> {
  DomainChangeCubit() : super(DomainChangeInitial());

  Future<void> changeDomain(String domain) async {
    emit(DomainChangeInProgress());
    emit(DomainChangeSuccess(domain));
  }
}
