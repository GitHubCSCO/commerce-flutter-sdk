import 'package:flutter_bloc/flutter_bloc.dart';

part 'quote_tab_switch_state.dart';

class QuoteTabSwitchCubit extends Cubit<QuoteTabSwitchState> {
  QuoteTabSwitchCubit() : super(QuoteTabSwitchInitial());

  void switchTab(int index) {
    emit(QuoteTabSwitchShouldSwitch(index: index));
  }
}
