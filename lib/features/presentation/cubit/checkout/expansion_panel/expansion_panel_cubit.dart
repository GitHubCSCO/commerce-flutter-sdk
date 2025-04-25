import 'dart:async';

import 'package:commerce_flutter_sdk/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/core/models/expansion_panel_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'expansion_panel_state.dart';

class ExpansionPanelCubit extends Cubit<ExpansionPanelState> {
  List<ExpansionPanelItem> list = [
    ExpansionPanelItem(
        headerValue: LocalizationConstants.billingShipping.localized(),
        isExpanded: true),
    ExpansionPanelItem(
        headerValue: LocalizationConstants.paymentDetails.localized(),
        isExpanded: false),
    ExpansionPanelItem(
        headerValue: LocalizationConstants.reviewOrder.localized(),
        isExpanded: false)
  ];

  int expansionIndex = 0;
  int numberOfPanels = 3;

  late StreamController<String> _continueButtonController;

  Stream<String> get buttonTextStream => _continueButtonController.stream;

  ExpansionPanelCubit() : super(ExpansionPanelInitialState()) {
    _continueButtonController = StreamController<String>.broadcast();
    _continueButtonController
        .add(LocalizationConstants.continueText.localized());
  }

  void initialize(int numberOfPanels) {
    this.numberOfPanels = numberOfPanels;
    // For order approval
    if (numberOfPanels == 2) {
      list.removeAt(1);
    }
  }

  void onPanelExpansionChange(int index) {
    if (expansionIndex > index) {
      expansionIndex = index;
      for (var i = 0; i < list.length; i++) {
        if (index == i) {
          list[i].isExpanded = true;
        } else {
          list[i].isExpanded = false;
        }
      }
      emit(ExpansionPanelChangeState(list: list));
      _updateButtonText(expansionIndex == (numberOfPanels == 2 ? 1 : 2)
          ? (numberOfPanels == 2
              ? LocalizationConstants.submitForApproval.localized()
              : LocalizationConstants.placeOrder.localized())
          : LocalizationConstants.continueText.localized());
    }
  }

  void onContinueClick() {
    if (expansionIndex >= (numberOfPanels == 2 ? 1 : 2)) {
    } else {
      expansionIndex++;
      for (var i = 0; i < list.length; i++) {
        if (expansionIndex == i) {
          list[i].isExpanded = true;
        } else {
          list[i].isExpanded = false;
        }
      }
    }
    emit(ExpansionPanelChangeState(list: list));
    _updateButtonText(expansionIndex == (numberOfPanels == 2 ? 1 : 2)
        ? (numberOfPanels == 2
            ? LocalizationConstants.submitForApproval.localized()
            : LocalizationConstants.placeOrder.localized())
        : LocalizationConstants.continueText.localized());
  }

  void _updateButtonText(String text) {
    _continueButtonController.add(text);
  }

  Future<void> dispose() async {
    await _continueButtonController.close();
  }
}
