import 'package:bloc_test/bloc_test.dart';
import 'package:commerce_flutter_sdk/src/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/src/features/domain/enums/domain_change_status.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/domain_usecase/domain_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/domain/domain_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../sdk/usecases/mock_usecases.dart';
import '../../../domain/injector_mock.dart';

void main() async {
  late DomainUsecase mockDomainUsecase;
  late DomainCubit sut;
  setUp(() async {
    await initInjectionContainerMock();
    await GetIt.I.allReady();

    mockDomainUsecase = MockDomainUsecase();
    sut = DomainCubit(domainUsecase: mockDomainUsecase);
  });
  tearDown(() {
    // Reset GetIt after each test
    GetIt.I.reset();
    sut.close();
  });
  group('DomainCubit', () {
    test('equality for states', () {
      expect(DomainUnknown(), isA<DomainState>());
      expect(DomainUnknown(), DomainUnknown());

      expect(DomainOperationInProgress(), isA<DomainState>());
      expect(DomainOperationInProgress(), DomainOperationInProgress());

      expect(DomainLoaded('domain'), isA<DomainState>());
      expect(DomainLoaded('domain'), DomainLoaded('domain'));
      expect(DomainLoaded('domain'), isNot(DomainLoaded('not_valid_domain')));

      expect(DomainOperationFailed('title', 'message'), isA<DomainState>());
      expect(DomainOperationFailed('title', 'message'),
          DomainOperationFailed('title', 'message'));
      expect(DomainOperationFailed('title', 'message'),
          isNot(DomainOperationFailed('not_title', 'not_message')));

      expect(
          DomainOperationFailedOffline('title', 'message'), isA<DomainState>());
      expect(DomainOperationFailedOffline('title', 'message'),
          DomainOperationFailedOffline('title', 'message'));
      expect(DomainOperationFailedOffline('title', 'message'),
          isNot(DomainOperationFailedOffline('not_title', 'not_message')));

      expect(
          DomainOperationFailedInvalid('title', 'message'), isA<DomainState>());
      expect(DomainOperationFailedInvalid('title', 'message'),
          DomainOperationFailedInvalid('title', 'message'));
      expect(DomainOperationFailedInvalid('title', 'message'),
          isNot(DomainOperationFailedInvalid('not_title', 'not_message')));

      expect(DomainOperationFailedMobileAppDisabled('title', 'message'),
          isA<DomainState>());
      expect(DomainOperationFailedMobileAppDisabled('title', 'message'),
          DomainOperationFailedMobileAppDisabled('title', 'message'));
      expect(
          DomainOperationFailedMobileAppDisabled('title', 'message'),
          isNot(DomainOperationFailedMobileAppDisabled(
              'not_title', 'not_message')));
    });
    test('initial state is DomainUnknown', () {
      expect(sut.state, isA<DomainUnknown>());
    });
    blocTest(
      'emits [DomainOperationInProgress, DomainLoaded] when selectDomain is called successfully',
      build: () {
        when(() => mockDomainUsecase.domainSelectHandler(any()))
            .thenAnswer((_) async => DomainChangeStatus.success);
        return sut;
      },
      act: (cubit) async {
        await cubit.selectDomain('validDomain');
      },
      expect: () => [
        DomainOperationInProgress(),
        DomainLoaded('validDomain'),
      ],
    );

    blocTest(
      'emits [DomainOperationInProgress, DomainOperationFailedOffline] when selectDomain encounters an offline error',
      build: () {
        when(() => mockDomainUsecase.domainSelectHandler(any()))
            .thenAnswer((_) async => DomainChangeStatus.failedOffline);
        return sut;
      },
      act: (cubit) async {
        await cubit.selectDomain('invalidDomain');
      },
      expect: () => [
        DomainOperationInProgress(),
        DomainOperationFailedOffline(
          'No Internet',
          'Connection cannot be established.',
        ),
      ],
    );

    blocTest(
      'emits [DomainOperationInProgress, DomainOperationFailedInvalid] when selectDomain encounters an invalid domain error',
      build: () {
        when(() => mockDomainUsecase.domainSelectHandler(any()))
            .thenAnswer((_) async => DomainChangeStatus.failedInvalidDomain);
        return sut;
      },
      act: (cubit) async {
        await cubit.selectDomain('invalidDomain');
      },
      expect: () => [
        DomainOperationInProgress(),
        DomainOperationFailedInvalid(
          LocalizationConstants.invalidDomain.localized(),
          LocalizationConstants.domainWebsiteNotResponding.localized(),
        ),
      ],
    );

    blocTest(
      'emits [DomainOperationInProgress, DomainOperationFailedMobileAppDisabled] when selectDomain encounters a mobile app disabled error',
      build: () {
        when(() => mockDomainUsecase.domainSelectHandler(any())).thenAnswer(
            (_) async => DomainChangeStatus.failedMobileAppDisabled);
        return sut;
      },
      act: (cubit) async {
        await cubit.selectDomain('invalidDomain');
      },
      expect: () => [
        DomainOperationInProgress(),
        DomainOperationFailedMobileAppDisabled(
          LocalizationConstants.mobileAppDisabled.localized(),
          LocalizationConstants.mobileAppDisabledDescription.localized(),
        ),
      ],
    );

    blocTest(
      'emits [DomainOperationInProgress, DomainLoaded] when fetchDomain is called successfully',
      build: () {
        when(() => mockDomainUsecase.getDomain())
            .thenAnswer((_) async => Future.value('savedDomain'));
        return sut;
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
        when(() => mockDomainUsecase.getDomain())
            .thenAnswer((_) async => Future.value(null));
        return sut;
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
