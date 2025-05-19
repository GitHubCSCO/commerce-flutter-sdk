import 'package:commerce_flutter_sdk/src/features/presentation/cubit/card_expiration_cubit.dart/card_expiration_state.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/widget/add_credit_card_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class CardExpirationCubit extends Cubit<CardExpirationState> {
  CardExpirationCubit() : super(CardExpirationInitialState());
  KeyValuePair<String, int>? selectedExpirationMonth;
  KeyValuePair<int, int>? selectedExpirationYear;

  Future<void> onLoadCardExpirarionData(
    AddCreditCardEntity addCreditCardEntity,
    List<KeyValuePair<int, int>>? expirationYears,
    List<KeyValuePair<String, int>>? expirationMonths,
  ) async {
    for (var year in expirationYears ?? []) {
      var accountExpirationYear = year.value;
      if (accountExpirationYear != null) {
        var lastTwoDigits = accountExpirationYear % 100;
        if (lastTwoDigits ==
            addCreditCardEntity.accountPaymentProfile?.expirationYear) {
          selectedExpirationYear = year;
          break;
        }
      }
    }

    for (var month in expirationMonths ?? []) {
      if (month.value ==
          addCreditCardEntity.accountPaymentProfile?.expirationMonth) {
        selectedExpirationMonth = month;
        break;
      }
    }
  }

  Future<void> onSelectExpirationMonth(KeyValuePair<String, int> month) async {
    selectedExpirationMonth = month;
    emit(CardExpirationLoadedState());
  }

  Future<void> onSelectExpirationYear(KeyValuePair<int, int> year) async {
    selectedExpirationYear = year;
    emit(CardExpirationLoadedState());
  }

  void validateExpirationDate() {
    emit(CardExpirationValidationState(
        selectedExpirationMonth == null, selectedExpirationYear == null));
  }
}
