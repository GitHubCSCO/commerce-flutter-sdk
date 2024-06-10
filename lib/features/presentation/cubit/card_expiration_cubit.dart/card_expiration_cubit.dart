import 'package:commerce_flutter_app/features/presentation/cubit/card_expiration_cubit.dart/card_expiration_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class CardExpirationCubit extends Cubit<CardExpirationState> {
  CardExpirationCubit() : super(CardExpirationInitialState());
  KeyValuePair<String, int>? selectedExpirationMonth;
  KeyValuePair<int, int>? selectedExpirationYear;
  Future<void> onLoadCardExpirarionData() async {}

  Future<void> onSelectExpirationMonth(KeyValuePair<String, int> month) async {
    selectedExpirationMonth = month;
    emit(CardExpirationLoadedState());
  }

  Future<void> onSelectExpirationYear(KeyValuePair<int, int> year) async {
    selectedExpirationYear = year;
    emit(CardExpirationLoadedState());
  }
}
