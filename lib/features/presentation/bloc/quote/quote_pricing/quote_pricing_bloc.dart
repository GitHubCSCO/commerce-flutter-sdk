import 'dart:async';
import 'dart:math';

import 'package:commerce_flutter_app/core/constants/core_constants.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/features/domain/entity/quote_line_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/quote_line_pricing_break_item_entity.dart';
import 'package:commerce_flutter_app/features/domain/mapper/quote_line_mapper.dart';
import 'package:commerce_flutter_app/features/domain/usecases/quote_usecase/quote_pricing_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/quote/quote_pricing/quote_pricing_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/quote/quote_pricing/quote_pricing_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class QuotePricingBloc extends Bloc<QuotePricingEvent, QuotePricingState> {
  final QuotePricingUsecase _quotePricingUsecase;
  QuoteLineEntity? quoteLine;
  List<QuoteLinePricingBreakItemEntity> quoteLinePricingBreakItemEntities = [];

  QuotePricingBloc({required QuotePricingUsecase quotePricingUsecase})
      : _quotePricingUsecase = quotePricingUsecase,
        super(QuotePricingInitialState()) {
    on<LoadQuotePricingEvent>(_onQuoteLinePricingLoadEvent);
    on<AddQuotePriceBreakEvent>(_onAddPriceBreakEvent);
    on<QuoteStartQuantityUpdateEvent>(_onUpdateStartQuantityEvent);
    on<QuoteEndQuantityUpdateEvent>(_onUpdateEndQuantityEvent);
    on<QuotePriceUpdateEvent>(_onUpdatePriceEvent);
    on<QuotePiricngBreakDeletionEvent>(_onQuotePriceBreakDeletionEvent);
    on<ApplyQuoteLinePricingEvent>(_onApplyQuoteLinePricing);
    on<ResetQuotePriceBreakEvent>(_onResetQuoteLinePricing);
  }

  Future<void> _onQuoteLinePricingLoadEvent(
      LoadQuotePricingEvent event, Emitter<QuotePricingState> emit) async {
    emit(QuotePricingLoadingState());
    quoteLine = event.quoteLineEntity;
    quoteLinePricingBreakItemEntities =
        getQuoteLinePricingBreakItemEntities(event.quoteLineEntity);
    emit(QuotePricingLoadedState(
        quoteLineEntity: event.quoteLineEntity,
        quoteLinePricingBreakItemEntities: quoteLinePricingBreakItemEntities));
  }

  List<QuoteLinePricingBreakItemEntity> getQuoteLinePricingBreakItemEntities(
      QuoteLineEntity quoteLineEntity) {
    List<QuoteLinePricingBreakItemEntity>
        quoteLinePricingBreakItemEntitiesList = [];

    var priceBreaks = quoteLineEntity.pricingRfq?.priceBreaks ?? [];

    if (priceBreaks.isEmpty) {
      quoteLinePricingBreakItemEntitiesList.add(QuoteLinePricingBreakItemEntity(
        endQuantity: 1,
        startQuantityDisplay: startQuantityDisplay(1),
        endQuantityDisplay: endQuantityDisplay(1),
        priceDisplay: priceDisplay(0),
        price: 0,
        startQuantity: 1,
        deletionEnabled: true,
        id: 0,
      ));

      return quoteLinePricingBreakItemEntitiesList;
    }
    for (var index = 0; index < priceBreaks.length; index++) {
      var item = priceBreaks[index];
      quoteLinePricingBreakItemEntitiesList.add(
        QuoteLinePricingBreakItemEntity(
          endQuantity: item.endQty ?? 0,
          startQuantityDisplay: startQuantityDisplay(item.startQty),
          endQuantityDisplay: endQuantityDisplay(item.endQty),
          priceDisplay: priceDisplay(item.price),
          price: item.price ?? 0,
          startQuantity: item.startQty ?? 0,
          deletionEnabled: true,
          id: index,
        ),
      );
    }

    return quoteLinePricingBreakItemEntitiesList;
  }

  Future<void> _onResetQuoteLinePricing(
      ResetQuotePriceBreakEvent event, Emitter<QuotePricingState> emit) async {
    quoteLinePricingBreakItemEntities.clear();
    quoteLinePricingBreakItemEntities =
        getQuoteLinePricingBreakItemEntities(quoteLine!);
    emit(QuotePricingLoadedState(
        quoteLineEntity: quoteLine!,
        quoteLinePricingBreakItemEntities: quoteLinePricingBreakItemEntities));
  }

  Future<void> _onApplyQuoteLinePricing(
      ApplyQuoteLinePricingEvent event, Emitter<QuotePricingState> emit) async {
    var errorMessage =
        validatePriceBreak(false, quoteLinePricingBreakItemEntities);

    if (!errorMessage.isNullOrEmpty) {
      emit(QuotePriceBreakValidationState(
          isValid: false, message: errorMessage));
      return;
    }

    var parameters = QuoteLinePricingQueryParameters(
        id: quoteLine?.id,
        pricingRfq: PricingRfqEntityMapper.toModel(quoteLine!.pricingRfq!));
    List<BreakPrice> priceBreaks = [];
    for (var item in quoteLinePricingBreakItemEntities) {
      priceBreaks.add(BreakPrice(
        startQty: item.startQuantity,
        endQty: item.endQuantity,
        price: item.price,
      ));
    }
    // parameters.pricingRfq!.priceBreaks = priceBreaks;

    var quoteLinePricingResponse =
        await _quotePricingUsecase.getQuotePricing(quoteLine!.id!, parameters);

    switch (quoteLinePricingResponse) {
      case Success():
        emit(QuoteLinePricingApplySuccessState());
        break;
      case Failure():
        emit(QuoteLinePricingApplyFailureState());
        break;
      default:
    }
  }

  Future<void> _onAddPriceBreakEvent(
      AddQuotePriceBreakEvent event, Emitter<QuotePricingState> emit) async {
    if (quoteLinePricingBreakItemEntities.length > 5) {
      return;
    }
    var errorMessage =
        validatePriceBreak(false, quoteLinePricingBreakItemEntities);

    if (!errorMessage.isNullOrEmpty) {
      emit(QuotePriceBreakValidationState(
          isValid: false, message: errorMessage));
      return;
    }

    QuoteLinePricingBreakItemEntity? lastItem =
        quoteLinePricingBreakItemEntities.isNotEmpty
            ? quoteLinePricingBreakItemEntities.last
            : null;
    num startQty = 1;
    if (lastItem != null) {
      startQty = (lastItem.endQuantity == null || lastItem.endQuantity == 0)
          ? lastItem.startQuantity! + 1
          : lastItem.endQuantity! + 1;

      if (lastItem.endQuantity == null || lastItem.endQuantity == 0) {
        lastItem.endQuantity = lastItem.startQuantity;
      }
    }

    lastItem!.startQuantityDisplay =
        startQuantityDisplay(lastItem.startQuantity);
    lastItem.endQuantityDisplay = endQuantityDisplay(lastItem.endQuantity);

    quoteLinePricingBreakItemEntities.last = lastItem;

    quoteLinePricingBreakItemEntities.add(QuoteLinePricingBreakItemEntity(
      startQuantity: startQty,
      endQuantity: 0,
      startQuantityDisplay: startQuantityDisplay(startQty),
      endQuantityDisplay: endQuantityDisplay(0),
      price: 0,
      priceDisplay: priceDisplay(0),
      id: quoteLinePricingBreakItemEntities.length + 1,
      deletionEnabled: true,
    ));

    if (quoteLinePricingBreakItemEntities.isNotEmpty) {
      quoteLinePricingBreakItemEntities.first.deletionEnabled = false;
    }
    updatePriceBreakRule();
    emit(QuotePricingLoadedState(
        quoteLineEntity: quoteLine!,
        quoteLinePricingBreakItemEntities: quoteLinePricingBreakItemEntities));
  }

  Future<void> _onUpdateStartQuantityEvent(QuoteStartQuantityUpdateEvent event,
      Emitter<QuotePricingState> emit) async {
    int index = getIndexOFQuoteLinePricingBreakItemEntity(event.id);
    quoteLinePricingBreakItemEntities[index].endQuantity =
        event.startQuantity == '' ? 0 : double.parse(event.startQuantity);

    quoteLinePricingBreakItemEntities[index].startQuantityDisplay =
        startQuantityDisplay(
            quoteLinePricingBreakItemEntities[index].startQuantity);

    emit(QuotePricingLoadedState(
        quoteLineEntity: quoteLine!,
        quoteLinePricingBreakItemEntities: quoteLinePricingBreakItemEntities));
  }

  Future<void> _onUpdateEndQuantityEvent(QuoteEndQuantityUpdateEvent event,
      Emitter<QuotePricingState> emit) async {
    int index = getIndexOFQuoteLinePricingBreakItemEntity(event.id);
    quoteLinePricingBreakItemEntities[index].endQuantity =
        event.endQuantity == '' ? 0 : double.parse(event.endQuantity);
    quoteLinePricingBreakItemEntities[index].endQuantityDisplay =
        endQuantityDisplay(
            quoteLinePricingBreakItemEntities[index].endQuantity);
    emit(QuotePricingLoadedState(
        quoteLineEntity: quoteLine!,
        quoteLinePricingBreakItemEntities: quoteLinePricingBreakItemEntities));
  }

  Future<void> _onUpdatePriceEvent(
      QuotePriceUpdateEvent event, Emitter<QuotePricingState> emit) async {
    int index = getIndexOFQuoteLinePricingBreakItemEntity(event.id);
    quoteLinePricingBreakItemEntities[index].price =
        event.price == '' ? 0 : double.parse(event.price);
    quoteLinePricingBreakItemEntities[index].priceDisplay =
        priceDisplay(quoteLinePricingBreakItemEntities[index].price);
    emit(QuotePricingLoadedState(
        quoteLineEntity: quoteLine!,
        quoteLinePricingBreakItemEntities: quoteLinePricingBreakItemEntities));
  }

  Future<void> _onQuotePriceBreakDeletionEvent(
      QuotePiricngBreakDeletionEvent event,
      Emitter<QuotePricingState> emit) async {
    quoteLinePricingBreakItemEntities
        .removeWhere((element) => element.id == event.id);
    updatePriceBreakRule();
    emit(QuotePricingLoadedState(
        quoteLineEntity: quoteLine!,
        quoteLinePricingBreakItemEntities: quoteLinePricingBreakItemEntities));
  }

  int getIndexOFQuoteLinePricingBreakItemEntity(int id) {
    for (int i = 0; i < quoteLinePricingBreakItemEntities.length; i++) {
      if (quoteLinePricingBreakItemEntities[i].id == id) {
        return i;
      }
    }
    return 0;
  }

  void updatePriceBreakRule() {
    for (int i = 0; i < quoteLinePricingBreakItemEntities.length - 1; i++) {
      var vm = quoteLinePricingBreakItemEntities[i];
      vm.endQuantity =
          quoteLinePricingBreakItemEntities[i + 1].startQuantity! - 1;
      vm.endQuantityEnabled = false;
    }

    if (quoteLinePricingBreakItemEntities.isNotEmpty) {
      quoteLinePricingBreakItemEntities.last.endQuantityEnabled = true;
    }
  }

  String validatePriceBreak(bool isDone,
      List<QuoteLinePricingBreakItemEntity> quoteLinePricingBreakItemEntities) {
    StringBuffer errorMessage = StringBuffer();

    for (int i = 0; i < quoteLinePricingBreakItemEntities.length; i++) {
      if (quoteLinePricingBreakItemEntities[i].startQuantity == null) {
        errorMessage.writeln(LocalizationConstants.startQtyRequired);
      } else {
        if (i == 0) {
          // First item
          if (quoteLinePricingBreakItemEntities[i].startQuantity != 1) {
            errorMessage.writeln(LocalizationConstants.startQtyInvalid);
          }
        } else if (quoteLinePricingBreakItemEntities[i].startQuantity! <=
            quoteLinePricingBreakItemEntities[i - 1].startQuantity!) {
          errorMessage.writeln(LocalizationConstants.qtyRangeInvalid);
        }
      }

      if (quoteLinePricingBreakItemEntities[i].endQuantity == null) {
        errorMessage.writeln(LocalizationConstants.endQtyRequired);
      } else if (i == quoteLinePricingBreakItemEntities.length - 1) {
        // Last item
        var maxQty = quoteLinePricingBreakItemEntities[i].endQuantity!;
        if (maxQty > 0 &&
            maxQty < quoteLinePricingBreakItemEntities[i].startQuantity!) {
          errorMessage.writeln(LocalizationConstants.endQtyInvalid);
        } else if (isDone && maxQty != 0) {
          errorMessage.writeln(LocalizationConstants.endQtyInvalid);
        }
      }

      if (quoteLinePricingBreakItemEntities[i].price == null) {
        errorMessage.writeln(LocalizationConstants.priceRequired);
      } else {
        if (quoteLinePricingBreakItemEntities[i].price! < 0 ||
            (quoteLine?.pricingRfq?.minimumPriceAllowed != null &&
                quoteLinePricingBreakItemEntities[i].price! <
                    quoteLine!.pricingRfq!.minimumPriceAllowed!)) {
          errorMessage.writeln(LocalizationConstants.priceInvalid);
        }
      }

      if (errorMessage.isNotEmpty) {
        break;
      }
    }

    return errorMessage.toString();
  }

  String startQuantityDisplay(num? startQty) {
    String startQtyDisplay;
    if (startQty != null) {
      startQtyDisplay = startQty
          .toStringAsFixed(2)
          .replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => ',');
    } else {
      startQtyDisplay = '';
    }
    return startQtyDisplay;
  }

  String endQuantityDisplay(num? endQty) {
    String endQtyDisplay;

    if (endQty != null && endQty == 0) {
      return LocalizationConstants.max;
    } else if (endQty != null) {
      endQtyDisplay = endQty
          .toStringAsFixed(2)
          .replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => ',');
    } else {
      endQtyDisplay = '';
    }
    return endQtyDisplay;
  }

  String priceDisplay(num? price) {
    // const String currencySymbol = CoreConstants.currencySymbol;
    String priceDisplay;
    if (price != null) {
      priceDisplay = price
          .toStringAsFixed(2)
          .replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => ',');
    } else {
      priceDisplay = '';
    }
    return priceDisplay;
  }
}
