import 'dart:async';

import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/models/expansion_panel_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'expansion_panel_state.dart';

class ExpansionPanelCubit extends Cubit<ExpansionPanelState> {
  List<ExpansionPanelItem> list = [
    ExpansionPanelItem(headerValue: LocalizationConstants.billingShipping, isExpanded: true),
    ExpansionPanelItem(headerValue: LocalizationConstants.paymentDetails, isExpanded: false),
    ExpansionPanelItem(headerValue: LocalizationConstants.reviewOrder, isExpanded: false)
  ];

  int expansionIndex = 0;

  late StreamController<String> _continueButtonController;

  Stream<String> get buttonTextStream => _continueButtonController.stream;

  ExpansionPanelCubit() : super(ExpansionPanelInitialState()) {
    _continueButtonController = StreamController<String>.broadcast();
    _continueButtonController.add(LocalizationConstants.continueText);
  }

  Future<void> onPanelExpansionChange(int index) async {
    if (expansionIndex > index) {
      expansionIndex = index;
      for (int i = 0; i < list.length; i++) {
        if (index == i) {
          list[i].isExpanded = true;
        } else {
          list[i].isExpanded = false;
        }
      }
      emit(ExpansionPanelChangeState(list: list));
      _updateButtonText(expansionIndex == 2 ? LocalizationConstants.placeOrder : LocalizationConstants.continueText);
    }
  }

  Future<void> onContinueClick() async {
    if (expansionIndex >= 2) {

    } else {
      expansionIndex++;
      for (int i = 0; i < list.length; i++) {
        if (expansionIndex == i) {
          list[i].isExpanded = true;
        } else {
          list[i].isExpanded = false;
        }
      }
    }
    emit(ExpansionPanelChangeState(list: list));
    _updateButtonText(expansionIndex == 2 ? LocalizationConstants.placeOrder : LocalizationConstants.continueText);
  }

  void _updateButtonText(String text) {
    _continueButtonController.add(text);
  }

  void dispose() {
    _continueButtonController.close();
  }

}
