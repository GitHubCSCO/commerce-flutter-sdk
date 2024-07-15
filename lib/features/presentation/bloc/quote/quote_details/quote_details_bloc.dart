import 'package:commerce_flutter_app/core/utils/inventory_utils.dart';
import 'package:commerce_flutter_app/features/domain/entity/quote_line_entity.dart';
import 'package:commerce_flutter_app/features/domain/mapper/quote_line_mapper.dart';
import 'package:commerce_flutter_app/features/domain/usecases/quote_usecase/quote_details_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/quote/quote_details/quote_details_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/quote/quote_details/quote_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class QuoteDetailsBloc extends Bloc<QuoteDetailsEvent, QuoteDetailsState> {
  final QuoteDetailsUsecase _quoteDetailsUsecase;
  ProductSettings? productSettings;

  QuoteDetailsBloc({required QuoteDetailsUsecase quoteDetailsUsecase})
      : _quoteDetailsUsecase = quoteDetailsUsecase,
        super(QuoteDetailsInitialState()) {
    on<LoadQuoteDetailsDataEvent>(_onLoadQuoteDetailsDataEvent);
  }

  Future<void> _onLoadQuoteDetailsDataEvent(
      LoadQuoteDetailsDataEvent event, Emitter<QuoteDetailsState> emit) async {
    emit(QuoteDetailsLoadingState());

    var productSettingsResult =
        await _quoteDetailsUsecase.getProductSettingAsync();
    productSettings = productSettingsResult is Success
        ? (productSettingsResult as Success).value as ProductSettings
        : null;

    var result = await _quoteDetailsUsecase.getQuote(event.quoteId);
    switch (result) {
      case Success(value: final data):
        if (data != null) {
          emit(QuoteDetailsLoadedState(
              quoteDto: data, quoteLines: getQuoteLineEntities(data)));
        } else {
          emit(QuoteDetailsFailedState(error: 'Data not found'));
        }

        break;
      case Failure(errorResponse: final errorResponse):
        emit(QuoteDetailsFailedState(
            error: errorResponse.errorDescription ?? ''));
        break;
      default:
    }
  }

  List<QuoteLineEntity> getQuoteLineEntities(QuoteDto quote) {
    List<QuoteLineEntity> quoteLineEntities = [];
    for (var quoteLine in quote.quoteLineCollection ?? []) {
      var quoteLineEntity = QuoteLineEntityMapper.toEntity(quoteLine);
      var shouldShowWarehouseInventoryButton =
          InventoryUtils.isInventoryPerWarehouseButtonShownAsync(
                  productSettings) &&
              quoteLine.availability.messageType != 0;
      quoteLineEntity = quoteLineEntity.copyWith(
          showInventoryAvailability: shouldShowWarehouseInventoryButton,
          quoteStatus: quote.status,
          isJobQuote: quote.isJobQuote,
          quoteId: quote.id,
          quoteLinePricingBreakList:
              _makeBreakPricingEntityList(quoteLineEntity));
      quoteLineEntities.add(quoteLineEntity);
    }

    return quoteLineEntities;
  }

  List<QuoteLinePricingEntity> _makeBreakPricingEntityList(
      QuoteLineEntity quoteLineEntity) {
    List<QuoteLinePricingEntity> quoteLinePricingEntityList = [];

    for (int i = 0;
        i < quoteLineEntity.pricing!.unitListBreakPrices!.length;
        i++) {
      var quoteLinePricingEntity = QuoteLinePricingEntity(
        qty: quoteLineEntity.pricing?.unitListBreakPrices![i].breakQty
            .toString(),
        price:
            quoteLineEntity.pricing?.unitListBreakPrices![i].breakPriceDisplay,
      );

      if (i < quoteLineEntity.pricing!.unitListBreakPrices!.length - 1) {
        quoteLinePricingEntity = QuoteLinePricingEntity(
          qty:
              '${quoteLinePricingEntity.qty} - ${(quoteLineEntity.pricing!.unitListBreakPrices![i + 1].breakQty! - 1).toStringAsFixed(4)}',
          price: quoteLinePricingEntity.price,
        );
      } else if (quoteLineEntity.maxQty! > 0) {
        quoteLinePricingEntity = QuoteLinePricingEntity(
          qty:
              '${quoteLinePricingEntity.qty} - ${quoteLineEntity.maxQty!.round()}',
          price: quoteLinePricingEntity.price,
        );
      } else {
        quoteLinePricingEntity = QuoteLinePricingEntity(
          qty: '${quoteLinePricingEntity.qty}+',
          price: quoteLinePricingEntity.price,
        );
      }

      quoteLinePricingEntityList.add(quoteLinePricingEntity);
    }
    return quoteLinePricingEntityList;
  }
}
