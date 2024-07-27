import 'package:bloc_test/bloc_test.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/features/domain/enums/domain_change_status.dart';
import 'package:commerce_flutter_app/features/domain/usecases/domain_usecase/domain_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/domain/domain_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../sdk/usecases/mock_usecases.dart';

void main() {
  group('DomainCubit', () {
    late DomainUsecase domainUsecase;
    late DomainCubit domainCubit;

    setUp(() {
      domainUsecase = MockDomainUsecase();
      domainCubit = DomainCubit(domainUsecase: domainUsecase);
    });

    tearDown(() {
      domainCubit.close();
    });

    blocTest(
      'emits [DomainOperationInProgress, DomainLoaded] when selectDomain is called successfully',
      build: () {
        when(() => domainUsecase.domainSelectHandler(any()))
            .thenAnswer((_) async => DomainChangeStatus.success);
        return domainCubit;
      },
      act: (cubit) async {
        cubit.selectDomain('validDomain');
      },
      expect: () => [
        DomainOperationInProgress(),
        DomainLoaded('validDomain'),
      ],
    );

    blocTest(
      'emits [DomainOperationInProgress, DomainOperationFailedOffline] when selectDomain encounters an offline error',
      build: () {
        when(() => domainUsecase.domainSelectHandler(any()))
            .thenAnswer((_) async => DomainChangeStatus.failedOffline);
        return domainCubit;
      },
      act: (cubit) async {
        cubit.selectDomain('invalidDomain');
      },
      expect: () => [
        DomainOperationInProgress(),
        DomainOperationFailedOffline(
          'No Internet',
          'Connection cannot be established.',
        ),
      ],
    );

    // blocTest(
    //   'emits [DomainOperationInProgress, DomainOperationFailedInvalid] when selectDomain encounters an invalid domain error',
    //   build: () {
    //     when(() => domainUsecase.domainSelectHandler(any()))
    //         .thenAnswer((_) async => DomainChangeStatus.failedInvalidDomain);
    //     return domainCubit;
    //   },
    //   act: (cubit) async {
    //     cubit.selectDomain('invalidDomain');
    //   },
    //   expect: () => [
    //     DomainOperationInProgress(),
    //     DomainOperationFailedInvalid(
    //       LocalizationConstants.invalidDomain.localized(),
    //       LocalizationConstants.domainWebsiteNotResponding.localized(),
    //     ),
    //   ],
    // );

    // blocTest(
    //   'emits [DomainOperationInProgress, DomainOperationFailedMobileAppDisabled] when selectDomain encounters a mobile app disabled error',
    //   build: () {
    //     when(() => domainUsecase.domainSelectHandler(any())).thenAnswer(
    //         (_) async => DomainChangeStatus.failedMobileAppDisabled);
    //     return domainCubit;
    //   },
    //   act: (cubit) async {
    //     cubit.selectDomain('invalidDomain');
    //   },
    //   expect: () => [
    //     DomainOperationInProgress(),
    //     DomainOperationFailedMobileAppDisabled(
    //       LocalizationConstants.mobileAppDisabled.localized(),
    //       LocalizationConstants.mobileAppDisabledDescription.localized(),
    //     ),
    //   ],
    // );

    blocTest(
      'emits [DomainOperationInProgress, DomainLoaded] when fetchDomain is called successfully',
      build: () {
        when(() => domainUsecase.getDomain())
            .thenAnswer((_) async => Future.value('savedDomain'));
        return domainCubit;
      },
      act: (cubit) async {
        await cubit.fetchDomain();
      },
      expect: () => [
        DomainOperationInProgress(),
        DomainLoaded('savedDomain'),
      ],
    );

    blocTest(
      'emits [DomainOperationInProgress, DomainOperationFailed] when fetchDomain encounters an error',
      build: () {
        when(() => domainUsecase.getDomain())
            .thenAnswer((_) async => Future.value(null));
        return domainCubit;
      },
      act: (cubit) async {
        await cubit.fetchDomain();
      },
      expect: () => [
        DomainOperationInProgress(),
        DomainOperationFailed('No Domain', ''),
      ],
    );
  });
}
