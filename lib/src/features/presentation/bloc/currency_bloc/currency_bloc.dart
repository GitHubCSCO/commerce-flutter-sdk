import 'package:commerce_flutter_sdk/src/features/domain/usecases/currency_usecase/currency_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/currency_bloc/currency_event.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/bloc/currency_bloc/currency_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class CurrencyBloc extends Bloc<CurrencyEvent, CurrencyState> {
  final CurrencyUsecase currencyUsecase;

  CurrencyBloc({required this.currencyUsecase}) : super(CurrencyInitial()) {
    on<CurrencyListLoadEvent>(_onCurrencyListLoadEvent);
    on<CurrencyChangeEvent>(_onCurrencyChangeEvent);
  }

  Future<void> _onCurrencyChangeEvent(
      CurrencyChangeEvent event, Emitter<CurrencyState> emit) async {
    emit(CurrencyLoading());

    final result = await currencyUsecase.changeCurrency(event.currency);

    switch (result) {
      case Success(value: final success):
        if (success == true) {
          emit(CurrencyChanged());
          add(CurrencyListLoadEvent());
        } else {
          emit(CurrencyFailedToLoad("Failed to change currency"));
        }
      case Failure(errorResponse: final error):
        emit(
            CurrencyFailedToLoad(error.message ?? "Failed to change currency"));
    }
  }

  Future<void> _onCurrencyListLoadEvent(
      CurrencyListLoadEvent event, Emitter<CurrencyState> emit) async {
    emit(CurrencyLoading());

    final result = await currencyUsecase.loadCurrencyList();

    switch (result) {
      case Success(value: final currencyCollection):
        await currencyUsecase.loadCurrentCurrency();
        final selectedCurrency = currencyUsecase.getCurrentCurrency() ??
            (currencyCollection?.currencies?.isNotEmpty == true
                ? currencyCollection?.currencies?.first
                : null);
        emit(CurrencyListLoaded(
            currencyCollection?.currencies, selectedCurrency));
      case Failure(errorResponse: final error):
        emit(
            CurrencyFailedToLoad(error.message ?? "Failed to load currencies"));
    }
  }
}
