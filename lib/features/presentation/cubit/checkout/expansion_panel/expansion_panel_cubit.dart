import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'expansion_panel_state.dart';

class ExpansionPanelCubit extends Cubit<ExpansionPanelState> {
  List<Item> list = [
    Item(headerValue: LocalizationConstants.billingShipping, isExpanded: true),
    Item(headerValue: LocalizationConstants.paymentDetails, isExpanded: false),
    Item(headerValue: LocalizationConstants.reviewOrder, isExpanded: false)
  ];

  int expansionIndex = 0;

  ExpansionPanelCubit() : super(ExpansionPanelInitialState());

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
  }

}

class Item {
  Item({
    required this.headerValue,
    required this.isExpanded,
  });

  String headerValue;
  bool isExpanded;
}
