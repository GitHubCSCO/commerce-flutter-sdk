part of 'quick_order_auto_complete_bloc.dart';

abstract class QuickOrderAutoCompleteEvent {}

class QuickOrderStartSearchEvent extends QuickOrderAutoCompleteEvent {}

class QuickOrderEndSearchEvent extends QuickOrderAutoCompleteEvent {}

class QuickOrderFocusEvent extends QuickOrderAutoCompleteEvent {}

class QuickOrderTypingEvent extends QuickOrderAutoCompleteEvent {
  final String quickOrderQuery;

  QuickOrderTypingEvent(this.quickOrderQuery);
}

class QuickOrderUnFocusEvent extends QuickOrderAutoCompleteEvent {}

class QuickOrderLoadEvent extends QuickOrderAutoCompleteEvent {
  final String query;

  QuickOrderLoadEvent(this.query);
}
