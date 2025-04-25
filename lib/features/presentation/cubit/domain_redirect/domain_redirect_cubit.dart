import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:commerce_flutter_sdk/features/domain/enums/domain_redirect_status.dart';
import 'package:commerce_flutter_sdk/features/domain/usecases/domain_usecase/domain_usecase.dart';
import 'package:commerce_flutter_sdk/features/domain/usecases/language_usecase/language_usecase.dart';

class DomainRedirectState extends Equatable {
  final DomainRedirectStatus status;
  final String? domain;
  final bool isSignInRequired;

  const DomainRedirectState({
    required this.status,
    required this.domain,
    this.isSignInRequired = false,
  });

  @override
  List<Object> get props => [
        status,
        domain ?? '',
        isSignInRequired,
      ];

  DomainRedirectState copyWith({
    DomainRedirectStatus? status,
    String? domain,
    bool? isSignInRequired,
  }) {
    return DomainRedirectState(
      status: status ?? this.status,
      domain: domain ?? this.domain,
      isSignInRequired: isSignInRequired ?? this.isSignInRequired,
    );
  }
}

class DomainRedirectCubit extends Cubit<DomainRedirectState> {
  final DomainUsecase _domainUsecase;
  final LanguageUsecase _languageUsecase;

  DomainRedirectCubit(
      {required DomainUsecase domainUsecase,
      required LanguageUsecase languageUsecase})
      : _domainUsecase = domainUsecase,
        _languageUsecase = languageUsecase,
        super(
          const DomainRedirectState(
            status: DomainRedirectStatus.unknown,
            domain: null,
          ),
        );

  Future<void> redirect() async {
    emit(
      const DomainRedirectState(
        status: DomainRedirectStatus.unknown,
        domain: null,
      ),
    );

    final result = await _domainUsecase.getDomain();

    if (result != null) {
      await _languageUsecase.loadCurrentLanguage();
      await _languageUsecase.loadDefaultSiteMessage();
      await _domainUsecase.loadRemoteSettings();

      final domainIfChangePossible =
          await _domainUsecase.getDomainInSettingsScreen();
      final isSignInRequired = await _domainUsecase.checkSignInRequired();

      emit(
        state.copyWith(
          status: DomainRedirectStatus.redirect,
          domain: domainIfChangePossible,
          isSignInRequired: isSignInRequired,
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: DomainRedirectStatus.doNotRedirect,
        ),
      );
    }
  }
}
