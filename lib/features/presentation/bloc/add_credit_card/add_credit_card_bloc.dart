import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/features/domain/entity/checkout/tokenex_entity.dart';
import 'package:commerce_flutter_app/features/domain/enums/token_ex_view_mode.dart';
import 'package:commerce_flutter_app/features/domain/usecases/add_credit_card_usecase/add_credit_card_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/add_credit_card/add_credit_card_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/add_credit_card/add_credit_card_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class AddCreditCardBloc extends Bloc<AddCreditCardEvent, AddCreditCardState> {
  final AddCreditCardUsecase _addCreditCardUsecase;

  AddCreditCardBloc({required AddCreditCardUsecase addCreditCardUsecase})
      : _addCreditCardUsecase = addCreditCardUsecase,
        super(AddCreditCardInitialState()) {
    on<SetUpDataSourceEvent>(_onSetUpDataSourceEvent);
    on<SavePaymentProfileEvent>(_onSavePaymentProfile);
  }

  Future<void> _onSetUpDataSourceEvent(
      SetUpDataSourceEvent event, Emitter<AddCreditCardState> emit) async {
    emit(AddCreditCardLoadingState());
    var currentCartResponse = await _addCreditCardUsecase.getCurrentCart();

    Cart currentCart = (currentCartResponse is Success)
        ? (currentCartResponse as Success).value
        : null;
    PaymentOptionsDto? paymentOptions = currentCart.paymentOptions;

    var tokenExStyle = TokenExStyleDto(
      baseColor: OptiAppColors.lightGrayTextColor.toString(),
      focusColor: OptiAppColors.primaryColor.toString(),
      errorColor: OptiAppColors.invalidColor.toString(),
      textColor: OptiAppColors.darkGrayTextColor.toString(),
    );

    var tokenExResponse =
        await _addCreditCardUsecase.getTokenExConfiguration("");

    var tokenExConfiguration = (tokenExResponse is Success)
        ? (tokenExResponse as Success).value
        : null;

    var tokeExUrl = _addCreditCardUsecase.tokenExIFrameUrl;
    var tokenExEnity = TokenExEntity(
        tokenExConfiguration: tokenExConfiguration,
        tokenexStyle: tokenExStyle,
        tokenexMode: TokenExViewMode.full,
        cardType: "",
        tokenExUrl: tokeExUrl);

    emit(AddCreditCardLoadedState(
        tokenExEntity: tokenExEnity,
        expirationMonths: paymentOptions?.expirationMonths,
        expirationYears: paymentOptions?.expirationYears));
  }

  Future<void> _onSavePaymentProfile(
      SavePaymentProfileEvent event, Emitter<AddCreditCardState> emit) async {
    var response = await _addCreditCardUsecase
        .savePaymentProfile(event.accountPaymentProfile);

    switch (response) {
      case Success(value: final value):
        print("success");
        break;
      case Failure(errorResponse: final errorResponse):
        print(errorResponse);
        break;
    }
  }
}
