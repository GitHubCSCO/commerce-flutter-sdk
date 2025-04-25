import 'package:commerce_flutter_sdk/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/core/constants/site_message_constants.dart';
import 'package:commerce_flutter_sdk/features/domain/usecases/quote_usecase/quote_all_usecase.dart';
import 'package:commerce_flutter_sdk/features/presentation/cubit/quote/quote_all_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class QuoteAllCubit extends Cubit<QuoteAllState> {
  final QuoteAllUsecase _quoteAllUsecase;
  QuoteDto? quoteDto;
  CalculationMethod? selectedCalculationMethod;
  int quantity = 0;

  QuoteAllCubit({required QuoteAllUsecase quoteAllUsecase})
      : _quoteAllUsecase = quoteAllUsecase,
        super(QuoteAllInitialState());

  Future<void> initialize(QuoteDto quoteDto) async {
    emit(QuoteAllLoadingState());
    this.quoteDto = quoteDto;
    var titleMsgResponse = await _quoteAllUsecase.getSiteMessage(
        SiteMessageConstants.nameRfqQuoteOrderHeader,
        SiteMessageConstants.defaultValueRfqQuoteOrderHeader);

    var titleMsg = titleMsgResponse is Success
        ? (titleMsgResponse as Success).value
        : SiteMessageConstants.defaultValueRfqQuoteOrderHeader;

    selectedCalculationMethod = quoteDto.calculationMethods?.first;
    emit(QuoteAllLoadedState(quoteDto: quoteDto, titleMsg: titleMsg));
  }

  Future<void> quoteAll() async {
    emit(QuoteAllLoadingState());
    var quoteAllQueryParameters = QuoteAllQueryParameters(
        calculationMethod: selectedCalculationMethod!.value,
        percent: quantity,
        quoteId: quoteDto!.id);
    var quoteAllResponse =
        await _quoteAllUsecase.quoteAll(quoteAllQueryParameters);

    switch (quoteAllResponse) {
      case Success(value: final data):
        emit(QuoteAllAppliedSuccessState(quoteDto: data!));
      case Failure(errorResponse: final errorResponse):
      default:
    }
  }

  Future<void> onselectCalculationMethod(
      CalculationMethod calculationMethod) async {
    selectedCalculationMethod = calculationMethod;
    initialize(quoteDto!);
  }

  Future<void> onUpdateDiscountQuantity(String value) async {
    quantity = int.tryParse(value) ?? 0;
  }

  bool calculationMethodsEqual(CalculationMethod a, CalculationMethod b) {
    return a.value == b.value &&
        a.name == b.name &&
        a.displayName == b.displayName &&
        a.maximumDiscount == b.maximumDiscount &&
        a.minimumMargin == b.minimumMargin;
  }

  Future<void> onValidateDiscount() async {
    var maxDiscount =
        double.tryParse(selectedCalculationMethod?.maximumDiscount ?? '0') ?? 0;
    var minMargin =
        double.tryParse(selectedCalculationMethod?.minimumMargin ?? '0') ?? 0;

    var quantityIsValid = (maxDiscount == 0 || quantity <= maxDiscount) &&
        (minMargin == 0 || quantity >= minMargin);
    var discountMessage = LocalizationConstants.discountMessage.localized();
    emit(QuoteAllValidationState(
        isValid: quantityIsValid, message: discountMessage));
  }

  int get selectedCarrierIndex {
    if (selectedCalculationMethod == null || quoteDto == null) {
      return 0;
    }

    if (quoteDto!.calculationMethods == null) {
      return 0;
    }

    for (int index = 0; index < quoteDto!.calculationMethods!.length; index++) {
      if (calculationMethodsEqual(
          quoteDto!.calculationMethods![index], selectedCalculationMethod!)) {
        return index;
      }
    }

    return 0;
  }
}
