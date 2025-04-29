import 'package:commerce_flutter_sdk/src/features/domain/usecases/saved_payments_usecase/saved_payments_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/saved_payments/saved_payments_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class SavedPaymentsCubit extends Cubit<SavedPaymentsState> {
  final SavedPaymentsUsecase _savedPaymentsUsecase;
  SavedPaymentsCubit({required SavedPaymentsUsecase savedPaymentsUsecase})
      : _savedPaymentsUsecase = savedPaymentsUsecase,
        super(SavedPaymentsInitialState());

  Future<void> loadSavedPayments() async {
    emit(SavedPaymentsLoadingState());
    var parameters = PaymentProfileQueryParameters(page: 1, pageSize: 16);
    var response = await _savedPaymentsUsecase.getSavedPayments(parameters);
    var accountPaymentProfilesResponse = (response is Success)
        ? (response as Success).value as AccountPaymentProfileCollectionResult
        : null;

    if (accountPaymentProfilesResponse != null) {
      var accountPaymentProfile =
          accountPaymentProfilesResponse.accountPaymentProfiles;
      emit(SavedPaymentsLoadedState(
          accountPaymentProfiles: accountPaymentProfile));
    } else {
      emit(SavedPaymentsFailureState());
    }
  }
}
