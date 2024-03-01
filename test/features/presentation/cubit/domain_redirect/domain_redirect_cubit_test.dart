// import 'package:bloc_test/bloc_test.dart';
// import 'package:commerce_flutter_app/features/domain/enums/domain_redirect_status.dart';
// import 'package:commerce_flutter_app/features/domain/usecases/domain_selection_usecase/domain_selection_usecase.dart';
// import 'package:commerce_flutter_app/features/presentation/cubit/domain_redirect/domain_redirect_cubit.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';

// import '../../../../sdk/usecases/mock_usecases.dart';

// void main() {
//   group('DomainRedirectCubit', () {
//     late DomainSelectionUsecase domainSelectionUsecase;
//     late DomainRedirectCubit domainRedirectCubit;

//     setUp(() {
//       domainSelectionUsecase = MockDomainSelectionUsecase();
//       domainRedirectCubit = DomainRedirectCubit(domainSelectionUsecase: domainSelectionUsecase);
//     });

//     tearDown(() {
//       domainRedirectCubit.close();
//     });

//     blocTest(
//       'emits [DomainRedirectStatus.loading, DomainRedirectStatus.redirect] when redirect is called with a saved domain',
//       build: () {
//         when(() => domainSelectionUsecase.getSavedDomain()).thenAnswer((_) async => Future.value('savedDomain'));
//         return domainRedirectCubit;
//       },
//       act: (cubit) async {
//         await cubit.redirect();
//       },
//       expect: () => [
//         DomainRedirectStatus.loading,
//         DomainRedirectStatus.redirect,
//       ],
//     );

//     blocTest(
//       'emits [DomainRedirectStatus.loading, DomainRedirectStatus.doNotRedirect] when redirect is called without a saved domain',
//       build: () {
//         when(() => domainSelectionUsecase.getSavedDomain()).thenAnswer((_) async => null);
//         return domainRedirectCubit;
//       },
//       act: (cubit) async {
//         await cubit.redirect();
//       },
//       expect: () => [
//         DomainRedirectStatus.loading,
//         DomainRedirectStatus.doNotRedirect,
//       ],
//     );
    
//   });
// }