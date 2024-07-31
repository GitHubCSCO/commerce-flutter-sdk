import 'package:commerce_flutter_app/core/utils/inventory_utils.dart';
import 'package:commerce_flutter_app/features/domain/entity/quote_line_entity.dart';
import 'package:commerce_flutter_app/features/domain/mapper/quote_line_mapper.dart';
import 'package:commerce_flutter_app/features/domain/usecases/pricing_inventory_usecase/pricing_inventory_usecase.dart';
import 'package:commerce_flutter_app/features/domain/usecases/quote_usecase/quote_confirmation_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/quote/quote_confirmation/quote_confirmation_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class QuoteConfirmationCubit extends Cubit<QuoteConfirmationState> {
  ProductSettings? productSettings;
  final PricingInventoryUseCase _pricingInventoryUseCase;
  final QuoteConfirmationUsecase _quoteConfirmationUsecase;
  QuoteConfirmationCubit(
      {required QuoteConfirmationUsecase quoteConfirmationUsecase,
      required PricingInventoryUseCase pricingInventoryUseCase})
      : _quoteConfirmationUsecase = quoteConfirmationUsecase,
        _pricingInventoryUseCase = pricingInventoryUseCase,
        super(QuoteConfirmationInitialState());

  Future<void> loadQuoteConfirmation(QuoteDto quoteDto) async {
    emit(QuoteConfirmationLoadingState());
    var productSettingsResult =
        await _quoteConfirmationUsecase.getProductSettingAsync();
    productSettings = productSettingsResult is Success
        ? (productSettingsResult as Success).value as ProductSettings
        : null;

    emit(QuoteConfirmationLoadedState(
        quoteDto: quoteDto, quoteLineEntities: getQuoteLineEntities(quoteDto)));
  }

  List<QuoteLineEntity> getQuoteLineEntities(QuoteDto quote) {
    List<QuoteLineEntity> quoteLineEntities = [];
    var hideInventoryEnable = _pricingInventoryUseCase.getHideInventoryEnable();
    var hidePricingEnable = _pricingInventoryUseCase.getHidePricingEnable();

    for (var quoteLine in quote.quoteLineCollection ?? []) {
      var quoteLineEntity = QuoteLineEntityMapper.toEntity(quoteLine);
      var shouldShowWarehouseInventoryButton =
          InventoryUtils.isInventoryPerWarehouseButtonShownAsync(
                  productSettings) &&
              quoteLine.availability.messageType != 0;
      quoteLineEntity = quoteLineEntity.copyWith(
          hideInventoryEnable: hideInventoryEnable,
          hidePricingEnable: hidePricingEnable,
          showInventoryAvailability: shouldShowWarehouseInventoryButton,
          quoteStatus: quote.status,
          isJobQuote: quote.isJobQuote,
          quoteId: quote.id,
          quoteLinePricingBreakList: []);
      quoteLineEntities.add(quoteLineEntity);
    }

    return quoteLineEntities;
  }
}
