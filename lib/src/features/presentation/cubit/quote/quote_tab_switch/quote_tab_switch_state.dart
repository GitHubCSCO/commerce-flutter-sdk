part of 'quote_tab_switch_cubit.dart';

sealed class QuoteTabSwitchState {
  const QuoteTabSwitchState();
}

final class QuoteTabSwitchInitial extends QuoteTabSwitchState {}

final class QuoteTabSwitchShouldSwitch extends QuoteTabSwitchState {
  final int index;

  const QuoteTabSwitchShouldSwitch({required this.index});
}
