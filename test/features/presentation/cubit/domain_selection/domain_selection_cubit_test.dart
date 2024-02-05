import 'package:bloc_test/bloc_test.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/features/domain/enums/domain_selection_status.dart';
import 'package:commerce_flutter_app/features/domain/usecases/domain_selection_usecase/domain_selection_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/domain_selection/domain_selection_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../sdk/usecases/mock_usecases.dart';

void main() {
  group('DomainSelectionCubit', () {
    late DomainSelectionUsecase domainSelectionUsecase;
    late DomainSelectionCubit domainSelectionCubit;

    setUp(() {
      domainSelectionUsecase = MockDomainSelectionUsecase();
      domainSelectionCubit = DomainSelectionCubit(domainSelectionUsecase);
    });

    tearDown(() {
      domainSelectionCubit.close();
    });

    blocTest(
      'emits [DomainSelectionInProgress, DomainSelectionSuccess] when selectDomain is called successfully',
      build: () {
        when(() => domainSelectionUsecase.domainSelectHandler(any()))
            .thenAnswer((_) async => DomainSelectionStatus.success);
        return domainSelectionCubit;
      },
      act: (cubit) async {
        cubit.selectDomain('validDomain');
      },
      expect: () => [
        DomainSelectionInProgress(),
        DomainSelectionSuccess(),
      ],
    );

    blocTest(
      'emits [DomainSelectionInProgress, DomainSelectionFailedOffline] when selectDomain encounters an offline error',
      build: () {
        when(() => domainSelectionUsecase.domainSelectHandler(any()))
            .thenAnswer((_) async => DomainSelectionStatus.failedOffline);
        return domainSelectionCubit;
      },
      act: (cubit) async {
        cubit.selectDomain('invalidDomain');
      },
      expect: () => [
        DomainSelectionInProgress(),
        DomainSelectionFailedOffline(
          'No Internet',
          'Connection cannot be established.',
        ),
      ],
    );

    blocTest(
      'emits [DomainSelectionInProgress, DomainSelectionFailedInvalid] when selectDomain encounters an invalid domain error',
      build: () {
        when(() => domainSelectionUsecase.domainSelectHandler(any()))
            .thenAnswer((_) async => DomainSelectionStatus.failedInvalidDomain);
        return domainSelectionCubit;
      },
      act: (cubit) async {
        cubit.selectDomain('invalidDomain');
      },
      expect: () => [
        DomainSelectionInProgress(),
        DomainSelectionFailedInvalid(
          LocalizationConstants.invalidDomain,
          LocalizationConstants.domainWebsiteNotResponding,
        ),
      ],
    );

    blocTest(
      'emits [DomainSelectionInProgress, DomainSelectionFailedMobileAppDisabled] when selectDomain encounters a mobile app disabled error',
      build: () {
        when(() => domainSelectionUsecase.domainSelectHandler(any()))
            .thenAnswer((_) async => DomainSelectionStatus.failedMobileAppDisabled);
        return domainSelectionCubit;
      },
      act: (cubit) async {
        cubit.selectDomain('invalidDomain');
      },
      expect: () => [
        DomainSelectionInProgress(),
        DomainSelectionFailedMobileAppDisabled(
          LocalizationConstants.mobileAppDisabled,
          LocalizationConstants.mobileAppDisabledDescription,
        ),
      ],
    );

  });
}